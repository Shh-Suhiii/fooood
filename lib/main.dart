import 'package:flutter/material.dart';
import 'package:flutterdelivery1/pages/home.dart' as home_page; // Import the file and alias it
import 'package:flutterdelivery1/pages/login.dart';
import 'package:flutterdelivery1/pages/onboard.dart';
import 'package:flutterdelivery1/pages/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
        ),
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUp(),
        '/home': (context) => const home_page.HomeScreen(), // Use alias here
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _showOnboarding = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    // Add your initialization logic here
  }

  @override
  Widget build(BuildContext context) {
    if (_showOnboarding) {
      return Onboard(
        onCompleted: () {
          setState(() {
            _showOnboarding = false;
          });
        },
      );
    }

    return _isLoggedIn
        ? const home_page.HomeScreen() // Use alias here
        : const LoginPage();
  }
}
