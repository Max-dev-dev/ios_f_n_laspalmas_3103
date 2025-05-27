import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:momento_las_palmas/core/router/router.dart';
import 'package:momento_las_palmas/core/utils/di_container/di_container.dart';
import 'package:momento_las_palmas/core/widgets/gradient_backgroud/gradient_background.dart';
import 'package:momento_las_palmas/splash/presentation/cubit/loading_cubit/loading_cubit.dart';
import 'package:momento_las_palmas/splash/presentation/cubit/loading_cubit/loading_state.dart';
import 'package:momento_las_palmas/ver_screen.dart';
import 'package:momento_las_palmas/web_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  await setupDependencies();

  final now = DateTime.now();
  final dateOff = DateTime(2024, 5, 29, 9, 0);
  final initialRoute = now.isBefore(dateOff) ? '/white' : '/verify';

  runApp(
    BlocProvider<LoadingCubit>(
      create: (_) => getIt<LoadingCubit>()..loadApp(),
      child: RootApp(
        initialRoute: initialRoute,
        whiteScreen: const MainApp(),
      ),
    ),
  );
}

class RootApp extends StatelessWidget {
  final String initialRoute;
  final Widget whiteScreen;

  const RootApp({
    Key? key,
    required this.initialRoute,
    required this.whiteScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, LoadingState>(
      builder: (context, state) {
        if (state is LoadingInitial || state is LoadingInProgressState) {
          return const SizedBox.shrink();
        }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          routes: {
            '/white': (_) => whiteScreen,
            '/verify': (_) => const VerificationScreen(),
            '/webview': (ctx) {
              final args = ModalRoute.of(ctx)!.settings.arguments as UrlWebViewArgs;
              return UrlWebViewApp(
                url: args.url,
                pushUrl: args.pushUrl,
                openedByPush: args.openedByPush,
              );
            },
          },
        );
      },
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocProvider<LoadingCubit>(
        create: (_) => getIt<LoadingCubit>(),
        child: MaterialApp.router(
          routerDelegate: appRouter.routerDelegate,
          routeInformationParser: appRouter.routeInformationParser,
          routeInformationProvider: appRouter.routeInformationProvider,
          theme: ThemeData(
            fontFamily: 'Raleway',
          ),
          builder: (BuildContext context, Widget? child) =>
              GradientBackground(
                child: child!,
              ),
        ),
      );
}

class UrlWebViewArgs {
  final String url;
  final String? pushUrl;
  final bool openedByPush;

  UrlWebViewArgs(this.url, this.pushUrl, this.openedByPush);
}