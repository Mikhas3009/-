import 'package:eco_city/appRouter.dart';
import 'package:eco_city/presentation/bloc/navigationBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eco City',
      home: BlocProvider(
        create: (context) => NavigationBloc(),
        child: const AppNavigator(),
      ),
    );
  }
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, String>(
      builder: (context, route) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: route,
          getPages: AppRouter.routes,
          unknownRoute: AppRouter.unknownRoute,
        );
      },
    );
  }
}
