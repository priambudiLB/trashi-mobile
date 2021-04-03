part of 'on_boarding_bloc.dart';

class OnBoardingState extends Equatable {
  const OnBoardingState({this.index = 0, this.isNavigateToHome = false});

  final int index;
  final bool isNavigateToHome;

  OnBoardingState copywith({int index, bool isNavigateToHome}) {
    return OnBoardingState(
        index: index ?? this.index,
        isNavigateToHome: isNavigateToHome ?? this.isNavigateToHome);
  }

  @override
  List<Object> get props => [index, isNavigateToHome];
}
