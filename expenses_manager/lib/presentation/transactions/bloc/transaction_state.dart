part of 'transaction_bloc.dart';

class TransactionState extends Equatable {
  final UIState uiState;

  final List<CategoryModel> categories;
  final int selectedCategory;
  final List<String> dateFilterOptions;
  final String selectedDateOption;
  final bool contentLoading;

  final Map<DateTime, List<TransactionModel>> transactionList;

  const TransactionState({
    required this.uiState,
    required this.transactionList,
    required this.categories,
    required this.dateFilterOptions,
    required this.selectedCategory,
    required this.selectedDateOption,
    required this.contentLoading
  });

  TransactionState copyWith({
    UIState? uiState,
    Map<DateTime, List<TransactionModel>>? transactionList,
    List<CategoryModel>? categories,
    List<String>? dateFilterOptions,
    int? selectedCategory,
    String? selectedDateOption,
    bool? contentLoading
  }) => TransactionState(
    uiState: uiState ?? this.uiState,
    transactionList: transactionList ?? this.transactionList,
    categories: categories ?? this.categories,
    dateFilterOptions: dateFilterOptions ?? this.dateFilterOptions,
    selectedCategory: selectedCategory ?? this.selectedCategory,
    selectedDateOption: selectedDateOption ?? this.selectedDateOption,
    contentLoading: contentLoading ?? this.contentLoading
  );

  @override
  List<Object> get props => [uiState, transactionList, categories, dateFilterOptions, selectedCategory, selectedDateOption];
}
