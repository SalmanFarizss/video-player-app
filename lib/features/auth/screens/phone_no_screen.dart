import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lilac_task_app/core/utils.dart';
import 'package:lilac_task_app/features/auth/screens/splash_screen.dart';

import '../../../core/constants/constants.dart';
import 'otp_screen.dart';

class PhoneNoScreen extends StatefulWidget {
  const PhoneNoScreen({super.key});

  @override
  State<PhoneNoScreen> createState() => _PhoneNoScreenState();
}

class _PhoneNoScreenState extends State<PhoneNoScreen> {
  TextEditingController phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Padding(
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
                  'Enter Phone Number',
                  style: TextStyle(
                      fontSize: width * 0.045, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                SizedBox(
                  height: height * 0.06,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: RichText(
                          text:  TextSpan(
                              text: 'Enter Phone Number ',
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color:  Colors.grey,),
                              children: [
                                TextSpan(
                                    text: '*', style: TextStyle(fontSize:width * 0.035,color: Colors.red))
                              ]),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color:Colors.grey.shade100))),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                InkWell(
                  onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OtpScreen(phoneNumber: phoneController.text,),));
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.25),
                        color: Colors.black),
                    child: Center(
                        child: Text(
                          'Get OTP',
                          style: TextStyle(
                              fontSize: width * 0.05, color:Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
