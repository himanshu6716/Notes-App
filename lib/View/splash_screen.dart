import 'package:flutter/material.dart';
import 'package:notes_app/View/Button_Navbar.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigater();
  }

  Future<void> _navigater() async {
    await Future.delayed(const Duration(seconds: 3));
    // User is logged in, navigate to NewsRoom
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text( "Welcome to Notes App", style: TextStyle(color: Colors.white,fontSize: 24)),
      ),
    );
  }
}