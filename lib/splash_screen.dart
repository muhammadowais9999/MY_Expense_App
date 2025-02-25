import 'dart:async';
import 'package:flutter/material.dart';
import 'login_page.dart'; // Replace with your login/signup page

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to Login
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEBB812), // Same color as Sign Up button
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/logo.png',
              width: 200,
              height: 250,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),

            // App Name with Professional Style
            Text(
              'Spend Smart, Save Big!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white, // White text for better contrast
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 20),

            // Circular Progress Indicator
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
