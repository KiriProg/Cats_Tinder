import 'package:cats_tinder/domain/entities/cat.dart';
import 'package:cats_tinder/presentation/screens/detail/detail_screen.dart';
import 'package:cats_tinder/presentation/screens/home/home_screen.dart';
import 'package:cats_tinder/presentation/screens/liked_cats/liked_cats_screen.dart';
import 'package:cats_tinder/presentation/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static const String home = '/';
  static const String likedCats = '/liked';
  static const String detail = '/detail';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case likedCats:
        return MaterialPageRoute(builder: (_) => const LikedCatsScreen());
      case detail:
        final cat = settings.arguments as Cat;
        return MaterialPageRoute(builder: (_) => DetailScreen(cat: cat));
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        );
    }
  }
}
