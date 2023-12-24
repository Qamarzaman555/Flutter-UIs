part of '../../../local_pub.dart';

abstract class TableViewModel extends BaseViewModel {
  final ApiClient apiClient = GetIt.I.get<ApiClient>();
  String? search;
  int page = 1;
  int perPage = 30;
  int totalRecords = 0;
  // bool isRowSelected = false;
  String? sorting;
  int sortOrderAlgoType = 0;

  void onRowsPageChanged(int? value) {
    perPage = value ?? perPage;
    fetchData();
  }

  void onSearch(String? query) {
    search = query;
    fetchData();
  }

  void onPageChanged(int value) {
    page = value;
    fetchData();
  }

  void onSort(String key, String? order) {
    sorting = order == null ? null : '$key:$order';
    fetchData();
  }

  /// implement to fetch the data from the server.
  Future<void> fetchData();
}
