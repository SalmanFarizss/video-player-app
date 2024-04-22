import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task_app/core/providers/firebase_porviders.dart';
import 'package:lilac_task_app/features/auth/repository/auth_repository.dart';
import 'package:lilac_task_app/features/auth/screens/otp_screen.dart';
import 'package:lilac_task_app/features/auth/screens/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utilities.dart';
import '../../../models/user_model.dart';

final authControllerProvider =
    NotifierProvider<AuthController, bool>(() => AuthController());
final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository(
    auth: ref.read(authProvider), fireStore: ref.read(fireStoreProvider)));
final userProvider = StateProvider<UserModel?>((ref) => null);
final authStateChangesProvider = StreamProvider.autoDispose<User?>(
    (ref) => ref.read(authControllerProvider.notifier).authStateChange);

class AuthController extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  ///function for auth Stream
  Stream<User?> get authStateChange => _repository.authStateChange;

  // ///function for get current user
  // Stream<DocumentSnapshot> getUser(String uid) {
  //   return _repository.getUser(uid);
  // }
  Future<DocumentSnapshot> getUser(String uid)async{
    return _repository.getUser(uid);
  }
  ///function for sendOTP
  Future<void> verifyPhoneNumber(
      {required BuildContext context, required String phone}) async {
    state = true;
    var res = await _repository.verityPhoneNumber(phone,context);
    state=false;
    res.fold((l) => failureSnackBar(context, l.failure), (completerResponse) {
      if(completerResponse.contains('error')){
        failureSnackBar(context, completerResponse);
      }else{
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                phoneNumber: phone,
                verificationId:completerResponse,
              ),
            ));
      }
    });
  }
  ///function for verify OTP
  Future<void> verifyOTP(
      {required BuildContext context,
      required String otp,
      required String vId}) async {
    state = true;
    var res = await _repository.verityOTP(otp: otp, vId: vId);
    state = false;
    res.fold((l) => failureSnackBar(context, l.failure), (user) async {
      successSnackBar(context, 'Login Successful');
      SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString('uid', user.uid);
      prefs.setString('phone', user.phoneNumber??'');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserDataScreen(uid:user.uid,phone: user.phoneNumber??'',),));
    });
  }
  /// logout
  Future<void> signOut() async {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.remove('uid');
    prefs.remove('phone');
  }
}
