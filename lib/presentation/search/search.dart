import 'package:flutter/material.dart';

import '../../application/search_service.dart';
import '../../data/search_repository.dart';
import '../../domain/friend.dart';
import '../../domain/post.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/separator_widget.dart';
import '../friend/FriendInfo.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<dynamic> searchSavedData;
  bool isSearching = false;
  bool isLoading = false;
  late List<Post> searchData = [];
  late List<Friend> searchUserData = [];
  int currentPage = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    searchSavedData = [];
    getsearchSavedData();
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      search(_searchController.text);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> getsearchSavedData() async {
    try {
      SearchService searchService =
          SearchService(searchRepository: SearchRepositoryImpl());
      final response = await searchService.getSaveSearch();
      setState(() {
        searchSavedData = response.toList();
      });
    } catch (error) {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> deleteId(String id) async {
    try {
      SearchService searchService =
          SearchService(searchRepository: SearchRepositoryImpl());
      await searchService.deleteSearchById(id);
    } catch (error) {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> deleteAll() async {
    try {
      SearchService searchService =
          SearchService(searchRepository: SearchRepositoryImpl());
      await searchService.deleteSearchAll();
    } catch (error) {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> search(String searchContext) async {
    try {
      SearchService searchService =
          SearchService(searchRepository: SearchRepositoryImpl());
      dynamic body = {
        "keyword": searchContext,
        "user_id": '',
        "index": "$currentPage",
        "count": "10"
      };
      final response = await searchService.search(body);
      searchData = response.toList();
      print(searchData);
      setState(() {
        isSearching = true;
        isLoading = false;
        currentPage += searchData.length;
      });
    } catch (error) {
      throw Exception('Failed to load data!');
    }
  }

  Future<void> searchUser(String searchContext) async {
    try {
      SearchService searchService =
          SearchService(searchRepository: SearchRepositoryImpl());
      dynamic body = {
        "keyword": searchContext,
        "index": "$currentPage",
        "count": "10"
      };
      final response = await searchService.searchUser(body);
      searchUserData = response.toList();
      print(searchUserData);
      setState(() {
        isSearching = true;
        isLoading = false;
        currentPage += searchUserData.length;
      });
    } catch (error) {
      throw Exception('Failed to load data!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.blue,
          size: 24.0,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 24,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Container(
          constraints: const BoxConstraints(
            maxWidth: double.infinity,
            maxHeight: 40,
          ),
          child: TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.blue),
            decoration: InputDecoration(
              hintText: 'Tìm kiếm',
              hintStyle: TextStyle(color: Colors.blue.withOpacity(0.7)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              filled: true,
              fillColor: const Color.fromARGB(255, 21, 24, 27).withOpacity(0.1),
              alignLabelWithHint: true,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(20.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue.withOpacity(0.7)),
                borderRadius: BorderRadius.circular(20.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              search(_searchController.text);
              searchUser(_searchController.text);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          buildMainContent(),
          buildSearchResults(),
        ],
      ),
    );
  }

  Widget buildMainContent() {
    return Visibility(
      visible: !isSearching,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Gần đây',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    deleteAll();
                    setState(() {
                      searchSavedData.clear();
                    });
                  },
                  child: const Text(
                    'Xóa tất cả',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchSavedData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      const Icon(Icons.access_time_outlined),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          searchSavedData[index].keyword,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            deleteId(searchSavedData[index].id);
                            searchSavedData.removeAt(index);
                          });
                        },
                        child: const Icon(Icons.close),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearchResults() {
    return Visibility(
      visible: isSearching,
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Visibility(
              visible: isSearching,
              child: Container(
                color: Colors.lightBlue,
                child: const TabBar(
                  tabs: [
                    Tab(text: 'Bài viết'),
                    Tab(text: 'Người dùng'),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Visibility(
                    visible: isSearching,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            'Kết quả tìm kiếm',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: <Widget>[
                              for (Post post in searchData)
                                Column(
                                  children: <Widget>[
                                    const SeparatorWidget(),
                                    PostWidget(post: post),
                                  ],
                                ),
                              const SeparatorWidget(),
                              if (isLoading) const CircularProgressIndicator(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isSearching,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          const SizedBox(height: 8),
                          const Text(
                            'Kết quả tìm kiếm',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Column(
                            children: <Widget>[
                              for (Friend friend in searchUserData)
                                Column(
                                  children: <Widget>[FriendItem(friend)],
                                ),
                              const SeparatorWidget(),
                              if (isLoading) const CircularProgressIndicator(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget FriendItem(Friend friend) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FriendInfo(
                            friendId: friend.id,
                          )),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(friend.avatar.isNotEmpty
                    ? friend.avatar
                    : "https://it4788.catan.io.vn/files/avatar-1701276452055-138406189.png"),
                radius: 40.0,
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  friend.username.isNotEmpty ? friend.username : "(No Name)",
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15.0),
              ],
            )
          ],
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
