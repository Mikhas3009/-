import 'package:eco_city/appRouter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Cubit<String> {
  NavigationBloc() : super(AppRouter.initialRoute);

  void navigateTo(String route) {
    emit(route);
  }
}
