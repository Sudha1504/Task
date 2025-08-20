import 'package:counter_task/Core/Network/Api_Service.dart';
import 'package:counter_task/Data/Model/list_model.dart';
import 'package:flutter/material.dart';

class ListProvider extends ChangeNotifier {
  final ApiService api = ApiService();
  List<ListModel> list = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  Future<void> fetchList() async {
    if(isLoading || !hasMore) return;

    isLoading = true;
    notifyListeners();

    final newList = await api.fetchData(page);

    if(newList.isNotEmpty) {
      list.addAll(newList);
      page++;
    }
    else {
      hasMore = false;
    }

    isLoading = false;
    notifyListeners();
  }

  void reset() {
    list = [];
    page = 1;
    hasMore = true;
    notifyListeners();
  }
}