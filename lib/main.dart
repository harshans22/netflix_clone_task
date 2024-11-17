import 'package:flutter/material.dart';
import 'package:netflix_clone_task/screens/splash_screen.dart';

import 'screens/details_screen.dart';
import 'screens/home_screen.dart';
import 'screens/navigation_screen.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Netflix Style Movie App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(),
        '/search': (context) => SearchScreen(),
        '/details': (context) => DetailsScreen(),
        '/navigation': (context) => NavigationScreen(),
      },
    );
  }
}