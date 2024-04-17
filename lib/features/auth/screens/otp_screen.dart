import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lilac_task_app/features/auth/screens/phone_no_screen.dart';
import 'package:lilac_task_app/features/auth/screens/splash_screen.dart';
import 'package:lilac_task_app/features/home/screens/home_screen.dart';

import '../../../core/constants/constants.dart';
class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpScreen({super.key,required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  late Timer timer;
  int duration = 90;
  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (duration == 0) {
          timer.cancel();
          if(mounted){
            setState(() {
            });
          }
        } else {
          duration--;
          if(mounted){
            setState(() {
            });
          }
        }
      },
    );
  }
  @override
  void initState() {
    _startTimer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    String time = '$duration sec';
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.1,
              ),
              SizedBox(
                height: height * 0.18,
                width: width,
                child: Image.asset(Constants.loginImage),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Text(
                'OTP Verification',
                style: TextStyle(
                    fontSize: width * 0.045, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: height * 0.035,
              ),
              Text(
                'Enter the verification code we just sent to your number +91 ********${widget.phoneNumber.substring(8, 10)}',
                style: TextStyle(
                    fontSize: width * 0.04, color: Colors.grey.shade600),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              // Center(
              //   child: Form(
              //     key: _formKey,
              //     child: Pinput(
              //       cursor: Container(),
              //       controller: otpController,
              //       keyboardType: TextInputType.number,
              //       length: 6,
              //       defaultPinTheme: PinTheme(
              //           height: width * 0.13,
              //           width: width * 0.13,
              //           textStyle: TextStyle(
              //               color: Palette.redColor,
              //               fontSize: width * 0.04,
              //               fontWeight: FontWeight.bold),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               border:
              //               Border.all(color: Palette.greyColor, width: 1))),
              //       submittedPinTheme: PinTheme(
              //           height: width * 0.13,
              //           width: width * 0.13,
              //           textStyle: TextStyle(
              //               color: Palette.redColor,
              //               fontSize: width * 0.04,
              //               fontWeight: FontWeight.bold),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               border:
              //               Border.all(color: Palette.blackColor, width: 1))
              //       ),
              //       errorPinTheme: PinTheme(
              //           height: width * 0.13,
              //           width: width * 0.13,
              //           textStyle: TextStyle(
              //               color: Palette.redColor,
              //               fontSize: width * 0.04,
              //               fontWeight: FontWeight.bold),
              //           decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               border:
              //               Border.all(color: Palette.redColor.shade400, width: 1))
              //       ),
              //       validator: (value) {
              //         if(value!.trim().length!=6){
              //           return 'Please Enter Valid Pin';
              //         }
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                height: height * 0.02,
              ),
              SizedBox(
                width: width,
                child: Center(child: Text(time,style: const TextStyle(color:Colors.red,fontWeight: FontWeight.bold),)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't Get OTP?",
                    style: TextStyle(fontSize: width * 0.035),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const PhoneNoScreen(),));
                      },
                      child: Text(
                        'Resend',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: width * 0.035),
                      ))
                ],
              ),
              InkWell(
                onTap: () {
                  // if(_formKey.currentState!.validate()){
                    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const HomeScreen(),));
                  // }
                },
                child: Container(
                  height: height * 0.06,
                  width: width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(height * 0.25),
                      color: Colors.black),
                  child: Center(
                    child: Text(
                      'Verify',
                      style: TextStyle(
                          fontSize: width * 0.04, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
