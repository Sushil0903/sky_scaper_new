import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      Duration(seconds: 4),
          () {
        Navigator.pushReplacementNamed(context, "home_page");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2C494F),
      body:
      Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.network("https://i.pinimg.com/originals/47/3e/f8/473ef810fc400109b613becdcbec407c.png",fit: BoxFit.cover,)),
    );
  }
}