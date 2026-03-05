class FilterTransactionsParams {
  final int? skip;
  final int? limit;
  final int? categoryId;
  final String date;

  FilterTransactionsParams({this.skip, this.limit, this.categoryId, required this.date});
}