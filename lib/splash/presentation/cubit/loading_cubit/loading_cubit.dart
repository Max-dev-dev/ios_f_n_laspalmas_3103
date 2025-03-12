import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:momento_las_palmas/splash/presentation/cubit/loading_cubit/loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitial());

  final String isFirstLaunchKey = 'is_first_launch_test';

  Future<void> loadApp() async {
    emit(LoadingInProgressState());

    // Simulation of loading
    await Future.delayed(
      const Duration(seconds: 6),
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstLaunch = prefs.getBool(isFirstLaunchKey) ?? true;

    if (isFirstLaunch) {
      await prefs.setBool(isFirstLaunchKey, false);
      emit(LoadedOnboardState());
    } else {
      emit(LoadedState());
    }
  }
}
