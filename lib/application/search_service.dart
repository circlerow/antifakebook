import 'package:flutter_application/domain/friend.dart';

import '../data/search_repository.dart';
import '../domain/post.dart';
import '../domain/search.dart';

class SearchService {
  final SearchRepository searchRepository;

  SearchService({required this.searchRepository});

  Future<List<SaveSearch>> getSaveSearch() async {
    dynamic data = await searchRepository.getSavedSearch();
    List<dynamic> dataSavedSearch = data["data"];
    return dataSavedSearch
        .map((postJson) => SaveSearch.fromJson(postJson))
        .toList();
  }

  Future<List<Post>> search(dynamic body) async {
    dynamic data = await searchRepository.getSearch(body);
    var statusCode = data["code"];
    if (statusCode == '1000') {
      List<dynamic> dataSearch = data["data"];
      return dataSearch.map((search) => Post.fromJson(search)).toList();
    }
    if (statusCode == 9994) {
      return [];
    }
    return [];
  }

  Future<List<Friend>> searchUser(dynamic body) async {
    dynamic data = await searchRepository.getSearchUser(body);
    var statusCode = data["code"];
    if (statusCode == '1000') {
      List<dynamic> dataSearch = data["data"];
      return dataSearch.map((search) => Friend.fromJson(search)).toList();
    }
    if (statusCode == 9994) {
      return [];
    }
    return [];
  }

  Future<bool> deleteSearchById(String id) async {
    dynamic data = await searchRepository.deleteSearchById(id);
    var statusCode = data["code"];
    if (statusCode == 1000) {
      return true;
    }
    return false;
  }

  Future<bool> deleteSearchAll() async {
    dynamic data = await searchRepository.deleteSearchAll();
    var statusCode = data["code"];
    if (statusCode == 1000) {
      return true;
    }
    return false;
  }
}
