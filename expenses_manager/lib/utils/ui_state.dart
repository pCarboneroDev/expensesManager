import 'package:equatable/equatable.dart';

enum UIStatus { loading, success, error, idle }

class UIState extends Equatable {
  final UIStatus status;
  final String errorMessage;

  const UIState({
    required this.status,
    this.errorMessage ='',
  });

  factory UIState.loading() => const UIState(
    status: UIStatus.loading
  );
  factory UIState.success() => UIState(
    status: UIStatus.success
  );
  factory UIState.error(String errorMessage) => UIState(
    status: UIStatus.error,
    errorMessage: errorMessage
  );
  factory UIState.idle() => UIState(
    status: UIStatus.idle
  );

  @override
  List<Object?> get props => [status, errorMessage];
}