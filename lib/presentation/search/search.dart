// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';

import '../../application/search_service.dart';
import '../../data/search_repository.dart';
import '../../domain/search.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<dynamic> searchSavedData;

  @override
  void initState() {
    getsearchSavedData();
    super.initState();
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
      final response = await searchService.deleteSearchById(id);
      print(response);
    } catch (error) {
      print(error);
    }
  }

  Future<void> deleteAll() async {
    try {
      SearchService searchService =
          SearchService(searchRepository: SearchRepositoryImpl());
      final response = await searchService.deleteSearchAll();
      print(response);
    } catch (error) {
      print(error);
    }
  }



  Future<void> search(String searchContext) async {
    try {
      SearchService searchService =
          SearchService(searchRepository: SearchRepositoryImpl());
      final response = await searchService.search(searchContext);
      print(response);
      var searchData = response.toList();
      print(searchData[0]);
    } catch (error) {
      print(error);
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
            },
          ),
        ],
      ),
      body: Column(
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
          )),
        ],
      ),
    );
  }
}
