import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:momento_las_palmas/core/widgets/gradient_backgroud/gradient_background.dart';
import 'package:momento_las_palmas/home/presentation/pages/home_page.dart';
import 'package:momento_las_palmas/onboarding/presentation/pages/onboading_page.dart';
import 'package:momento_las_palmas/splash/presentation/cubit/loading_cubit/loading_cubit.dart';
import 'package:momento_las_palmas/splash/presentation/cubit/loading_cubit/loading_state.dart';
import 'package:momento_las_palmas/splash/presentation/pages/splash_page.dart';

class AppRoutes{
  static const String homePage = '/home';
}

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: rootNavigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          BlocBuilder<LoadingCubit, LoadingState>(
        builder: (BuildContext context, LoadingState loadingState) {
          if (loadingState is LoadingInProgressState ||
              loadingState is LoadingInitial) {
            return const SplashPage();
          } else if (loadingState is LoadedOnboardState) {
            return const OnBoardPage();
          } else {
            return HomePage();
          }
        },
      ),
    ),
    GoRoute(
      path: AppRoutes.homePage,
      builder: (BuildContext context, GoRouterState state) =>
          GradientBackground(
        child: HomePage(),
      ),
    ),
  ],
);
