import 'package:flutter/material.dart';
import 'package:kitsunee_flutter/navigation/bottom_navigation.dart';
import 'package:kitsunee_flutter/screens/home_screen.dart';
import 'package:kitsunee_flutter/screens/profile_screen.dart';
import 'package:kitsunee_flutter/screens/search_screen.dart';

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
            return MaterialPageRoute(
                builder: (context) => const BottomTabNavigation());
          case '/home':
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case '/search':
            return MaterialPageRoute(
                builder: (context) => const SearchScreen());
          case '/profile':
            return MaterialPageRoute(
                builder: (context) => const ProfileScreen());
          default:
            return MaterialPageRoute(
                builder: (context) => const BottomTabNavigation());
        }
      },
    );
  }
}
