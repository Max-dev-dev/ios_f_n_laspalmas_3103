import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:momento_las_palmas/splash/presentation/cubit/loading_cubit/loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitial());

  Future<void> loadApp() async {
    emit(LoadingInProgressState());
    await Future.delayed(
      const Duration(seconds: 2),
    );
    FlutterNativeSplash.remove();



    emit(LoadedState());
  }
}
