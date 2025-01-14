import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/navigation/bottom_navigation.dart';
import 'package:kitsunee_flutter/screens/detail_screen.dart';
import 'package:kitsunee_flutter/screens/home_screen.dart';
import 'package:kitsunee_flutter/screens/search_screen.dart';
import 'package:kitsunee_flutter/screens/see_all_screen.dart';

class StackNavigation extends StatefulWidget {
  const StackNavigation({super.key});

  @override
  _StackNavigationState createState() => _StackNavigationState();
}

class _StackNavigationState extends State<StackNavigation> {
  @override
  void initState() {
    super.initState();
    _checkForUpdate();
  }

  void _checkForUpdate() {
    // Your update check logic
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return _fadeInRoute(const BottomTabNavigation());
          case '/home':
            return _fadeInRoute(const HomeScreen());
          case '/search':
            return _fadeInRoute(const SearchScreen());
          case '/detail':
            final animeId = settings.arguments as String?;
            return _fadeInRoute(DetailScreen(animeId: animeId));
          case '/seeall':
            final type = settings.arguments as String?;
            return _fadeInRoute(SeeAllScreen(type: type));
          default:
            return _fadeInRoute(const BottomTabNavigation());
        }
      },
    );
  }

  PageRouteBuilder _fadeInRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
