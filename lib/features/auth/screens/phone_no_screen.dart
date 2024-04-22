import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task_app/core/commons/loading.dart';
import 'package:lilac_task_app/features/auth/controller/auht_controller.dart';
import 'package:lilac_task_app/features/auth/screens/splash_screen.dart';
import 'package:telephony/telephony.dart';
import '../../../core/constants/constants.dart';

class PhoneNoScreen extends ConsumerStatefulWidget {
  const PhoneNoScreen({super.key});

  @override
  ConsumerState<PhoneNoScreen> createState() => _PhoneNoScreenState();
}

class _PhoneNoScreenState extends ConsumerState<PhoneNoScreen> {
  final Telephony telephony = Telephony.instance;
  TextEditingController phoneController=TextEditingController();
  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    telephony.requestSmsPermissions;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool isLoading=ref.watch(authControllerProvider);
    return Scaffold(
        body:isLoading?const Loading():Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Text(
                  'Hello,',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Verify your phone number',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: height*0.05,),
                SizedBox(
                  height: height * 0.18,
                  width: width,
                  child: Image.asset(Constants.loginImage),
                ),
                SizedBox(
                  height: height * 0.06,
                ),
                Text(
                  'Phone Number',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: height * 0.025,
                ),
                SizedBox(
                  height: height * 0.06,
                  child: TextFormField(
                    style:Theme.of(context).textTheme.bodyMedium,
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
                              style:Theme.of(context).textTheme.labelSmall,
                              children: [
                                TextSpan(
                                    text: '*', style: TextStyle(fontSize:width * 0.035,color: Colors.red))
                              ]),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color:Theme.of(context).primaryColor))),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    ref.read(authControllerProvider.notifier).verifyPhoneNumber(context: context, phone: phoneController.text.trim());
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(height * 0.25),
                        color:Colors.black),
                    child: Center(
                        child: Text(
                          'Get OTP',
                          style:Theme.of(context).textTheme.labelLarge,
                        )),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
