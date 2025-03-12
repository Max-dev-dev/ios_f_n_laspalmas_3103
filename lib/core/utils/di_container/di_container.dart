import 'package:get_it/get_it.dart';
import 'package:momento_las_palmas/home/presentation/cubit/places_cubit/places_cubit.dart';
import 'package:momento_las_palmas/splash/presentation/cubit/loading_cubit/loading_cubit.dart';
import 'package:momento_las_palmas/tabs/blog/presentation/cubit/blog_cubit/blog_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  getIt.registerLazySingleton<LoadingCubit>(() => LoadingCubit()..loadApp());
  getIt.registerLazySingleton<BlogCubit>(() => BlogCubit()..loadBlogs());
  getIt.registerLazySingleton<PlacesCubit>(() => PlacesCubit()..loadPlaces());
}