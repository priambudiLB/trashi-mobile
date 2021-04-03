import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'on_boarding_state.dart';
part 'on_boarding_event.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  OnBoardingBloc() : super(const OnBoardingState());

  @override
  Stream<OnBoardingState> mapEventToState(OnBoardingEvent event) async* {
    if (event is OnBoardingIndexIncrease) {
      yield _mapIndexIncreasedToState(state);
    } else if (event is OnBoardingIndexDecrease) {
      yield _mapIndexDecreasedToState(state);
    } else if (event is OnBoardingNavigateToHome) {
      yield _mapNavigatedToHomeToState(state);
    }
  }

  OnBoardingState _mapIndexIncreasedToState(OnBoardingState state) {
    final nextIndex = state.index == 2 ? 0 : state.index + 1;
    return state.copywith(index: nextIndex);
  }

  OnBoardingState _mapIndexDecreasedToState(OnBoardingState state) {
    final nextIndex = state.index == 0 ? 2 : state.index - 1;
    return state.copywith(index: nextIndex);
  }

  OnBoardingState _mapNavigatedToHomeToState(OnBoardingState state) {
    return state.copywith(isNavigateToHome: true);
  }
}
