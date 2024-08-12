import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_appp/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage('assets/splash_pic.png'),
            height: height * 0.5,
            //  width: width,
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: height * 0.04,
          ),
          Text(
            'TOP HEADLINES',
            style: GoogleFonts.anton(
                letterSpacing: 1, color: Colors.grey.shade700, fontSize: 18),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          SpinKitChasingDots(
            color: Colors.blue,
          )
        ],
      ),
    ));
  }
}
