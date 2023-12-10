import '../data/search_repository.dart';
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

  Future<List<Search>> search(String keyword) async {
    dynamic data = await searchRepository.getSearch(keyword);
    var statusCode = data["code"];
    if (statusCode == 1000) {
      List<dynamic> dataSearch = data["data"];
      return dataSearch.map((search) => Search.fromJson(search)).toList();
    }
    if(statusCode == 9994){
      return [];
    }
    return [];
  }

  Future<bool> deleteSearchById(String id) async{
    dynamic data  = await searchRepository.deleteSearchById(id);
    var statusCode = data["code"];
    if(statusCode == 1000){
      return true;
    }
    return false;
  }

  Future<bool> deleteSearchAll() async{
    dynamic data  = await searchRepository.deleteSearchAll();
    var statusCode = data["code"];
    if(statusCode == 1000){
      return true;
    }
    return false;
  }
}
