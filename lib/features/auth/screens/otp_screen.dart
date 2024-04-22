import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task_app/core/commons/loading.dart';
import 'package:lilac_task_app/features/auth/controller/auht_controller.dart';
import 'package:lilac_task_app/features/auth/screens/phone_no_screen.dart';
import 'package:lilac_task_app/features/auth/screens/splash_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:telephony/telephony.dart';
import '../../../core/constants/constants.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const OtpScreen(
      {super.key, required this.phoneNumber, required this.verificationId});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Telephony telephony = Telephony.instance;
  late Timer timer;
  int duration = 90;
  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (duration == 0) {
          timer.cancel();
          if (mounted) {
            setState(() {});
          }
        } else {
          duration--;
          if (mounted) {
            setState(() {});
          }
        }
      },
    );
  }
  void listenToIncomingSMS(){
    telephony.listenIncomingSms(onNewMessage: (message) {
      if(message.body!.contains('lilac-task-1cfeb')){
        otpController.text=message.body!.substring(0,6);
        if(otpController.text.trim().length==6){
          ref.read(authControllerProvider.notifier).verifyOTP(
              context: context,
              otp: otpController.text.trim(),
              vId: widget.verificationId);
        }
      }
    },
      listenInBackground: false
    );
  }
  @override
  void initState() {
    _startTimer();
    listenToIncomingSMS();
    super.initState();
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String time = '$duration sec';
    bool isLoading = ref.watch(authControllerProvider);
    return Scaffold(
        body: isLoading
            ? const Loading()
            : Padding(
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
                            fontSize: width * 0.045,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      Text(
                        'Enter the verification code we just sent to your number +91 ********${widget.phoneNumber.substring(8, 10)}',
                        style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.grey.shade600),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Center(
                        child: Form(
                          key: _formKey,
                          child: Pinput(
                            cursor: Container(),
                            controller: otpController,
                            keyboardType: TextInputType.number,
                            length: 6,
                            defaultPinTheme: PinTheme(
                                height: width * 0.13,
                                width: width * 0.13,
                                textStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.red, width: 1))),
                            submittedPinTheme: PinTheme(
                                height: width * 0.13,
                                width: width * 0.13,
                                textStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor, width: 1))),
                            errorPinTheme: PinTheme(
                                height: width * 0.13,
                                width: width * 0.13,
                                textStyle: TextStyle(
                                    color: Colors.red,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.bold),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.red.shade400, width: 1))),
                            validator: (value) {
                              if (value!.trim().length != 6) {
                                return 'Please Enter Valid Pin';
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Auto send Code in  ",
                            style: TextStyle(fontSize: width * 0.035),
                          ),
                          SizedBox(
                            width: width*0.3,
                            child: Text(
                              time,
                              style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height*0.06,),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(authControllerProvider.notifier).verifyOTP(
                                context: context,
                                otp: otpController.text.trim(),
                                vId: widget.verificationId);
                          }
                        },
                        child: Container(
                          height: height * 0.06,
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(height * 0.25),
                              color: Colors.black),
                          child: Center(
                            child: Text(
                              'Verify',
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}
