import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task_app/core/constants/constants.dart';
import 'package:lilac_task_app/features/auth/screens/phone_no_screen.dart';
import 'package:lilac_task_app/features/auth/screens/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/commons/loading.dart';

late double height;
late double width;

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Future<void> keepLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('uid')??'';
    String phone = prefs.getString('phone')??'';
    if (uid != '' && phone != '') {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  UserDataScreen(uid: uid,phone: phone,),));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PhoneNoScreen(),));
    }
  }
  bool isLoading = false;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      keepLogin();
      setState(() {
        isLoading=true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isLoading
          ? const Loading()
          : Center(
              child: Image.asset(Constants.logo),
            ),
    );
  }
}
