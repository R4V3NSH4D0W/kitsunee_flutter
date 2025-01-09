import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/navigation/bottom_navigation.dart';
import 'package:kitsunee_flutter/screens/home_screen.dart';
import 'package:kitsunee_flutter/screens/search_screen.dart';

class StackNavigation extends StatefulWidget {
  const StackNavigation({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StackNavigationState createState() => _StackNavigationState();
}

class _StackNavigationState extends State<StackNavigation> {
  @override
  void initState() {
    super.initState();
    _checkForUpdate();
  }

  // Update check logic here
  void _checkForUpdate() {
    // Your update check logic
    // If update is available, set _isUpdateAvailable = true
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
