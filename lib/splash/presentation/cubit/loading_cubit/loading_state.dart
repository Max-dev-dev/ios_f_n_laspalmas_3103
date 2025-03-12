import 'package:equatable/equatable.dart';

abstract class LoadingState extends Equatable {
  const LoadingState();

  @override
  List<Object> get props => <Object>[];
}

class LoadingInitial extends LoadingState {}

class LoadingInProgressState extends LoadingState {}

class LoadedState extends LoadingState {}

class LoadedOnboardState extends LoadingState {}