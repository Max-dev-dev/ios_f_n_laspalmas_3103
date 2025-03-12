import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momento_las_palmas/core/router/router.dart';
import 'package:momento_las_palmas/core/utils/di_container/di_container.dart';
import 'package:momento_las_palmas/core/widgets/gradient_backgroud/gradient_background.dart';
import 'package:momento_las_palmas/splash/presentation/cubit/loading_cubit/loading_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<LoadingCubit>(
        create: (_) => getIt<LoadingCubit>(),
        child: MaterialApp.router(
          routerDelegate: appRouter.routerDelegate,
          routeInformationParser: appRouter.routeInformationParser,
          routeInformationProvider: appRouter.routeInformationProvider,
          theme: ThemeData(
            fontFamily: 'Raleway',
          ),
          builder: (BuildContext context, Widget? child) => GradientBackground(
            child: child!,
          ),
        ),
      );
}
