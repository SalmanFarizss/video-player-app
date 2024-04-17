import 'package:flutter/material.dart';
import 'package:lilac_task_app/core/constants/constants.dart';
import 'package:lilac_task_app/features/auth/screens/phone_no_screen.dart';

late double height;
late double width;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2),()=>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const PhoneNoScreen(),)));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    height=MediaQuery.of(context).size.height;
    width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(child: Image.asset(Constants.logo),),
    );
  }
}
