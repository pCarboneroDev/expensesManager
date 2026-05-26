class FilterTransactionsParams {
  final int? skip;
  final int? limit;
  final String? categoryId;
  final String date;

  FilterTransactionsParams({this.skip, this.limit, this.categoryId, required this.date});
}