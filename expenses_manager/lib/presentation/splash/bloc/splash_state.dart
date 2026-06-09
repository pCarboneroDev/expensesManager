part of 'splash_bloc.dart';

class SplashState extends Equatable {
  final UIState uiState;

  const SplashState({required this.uiState});

  SplashState copyWith({UIState? uiState}) {
    return SplashState(
      uiState: uiState ?? this.uiState,
    );
  }
  
  @override
  List<Object> get props => [ uiState ];
}



