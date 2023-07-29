import 'package:flutter/material.dart';
import 'package:tests/model/home_model.dart';
import 'package:tests/screen/home/home_details_screen.dart';
import 'package:tests/screen/home/home_screen.dart';
import 'package:tests/screen/splash_screen/splash_screen.dart';

class RouteNames {
  static const String splashScreen = '/';
  static const String homePage = '/homePage';
  static const String homeDetailsPage = '/homeDetailsPage';


  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case RouteNames.splashScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const SplashScreen());

      case RouteNames.homePage:
        return MaterialPageRoute(
            settings: settings, builder: (_) => const HomePage());

      case RouteNames.homeDetailsPage:
        final data = settings.arguments as Movie;
        return MaterialPageRoute(
            settings: settings, builder: (_) => HomeDetailsScreen(movie: data));


      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
