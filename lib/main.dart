import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await setupDependencies();

  final now = DateTime.now();
  final dateOff = DateTime(2025, 5, 29, 9, 0);

  runApp(
    BlocProvider<LoadingCubit>(
      create: (_) => getIt<LoadingCubit>()..loadApp(),
      child: RootApp(now: now, dateOff: dateOff),
    ),
  );
}

class RootApp extends StatelessWidget {
  final DateTime now;
  final DateTime dateOff;

  const RootApp({
    required this.now,
    required this.dateOff,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoadingCubit, LoadingState>(
      builder: (context, state) {
        if (state is LoadingInitial || state is LoadingInProgressState) {
          return const SizedBox.shrink();
        }
        final initialRoute = now.isBefore(dateOff) ? '/white' : '/verify';

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: initialRoute,
          routes: {
            '/white': (_) => const MainApp(),
            '/verify': (_) => const VerificationScreen(),
            '/webview': (ctx) {
              final args =
              ModalRoute.of(ctx)!.settings.arguments as UrlWebViewArgs;
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