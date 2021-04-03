part of 'on_boarding_bloc.dart';

abstract class OnBoardingEvent extends Equatable {
  const OnBoardingEvent();

  @override
  List<Object> get props => [];
}

class OnBoardingIndexIncrease extends OnBoardingEvent {}

class OnBoardingIndexDecrease extends OnBoardingEvent {}

class OnBoardingNavigateToHome extends OnBoardingEvent {}
