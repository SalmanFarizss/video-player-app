import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lilac_task_app/core/commons/failure.dart';
import 'package:lilac_task_app/core/constants/firebase_constants.dart';
import 'package:lilac_task_app/core/typedef.dart';
import '../../../models/user_model.dart';
import 'package:flutter/material.dart';

import '../screens/otp_screen.dart';

class AuthRepository {
  final FirebaseFirestore _fireStore;
  final FirebaseAuth _auth;
  AuthRepository(
      {required FirebaseAuth auth, required FirebaseFirestore fireStore})
      : _auth = auth,
        _fireStore = fireStore;
  CollectionReference get _users =>
      _fireStore.collection(FirebaseConstants.usersCollection);
  Stream<User?> get authStateChange => _auth.authStateChanges();

  /// function for sending OTP
  FutureEither<String> verityPhoneNumber(String phone,BuildContext context) async {
    try {
      Completer<String> completer = Completer<String>();
      if (phone.length < 10) {
        throw 'Enter a Valid Phone Number';
      }
      await _auth.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (phoneAuthCredential) async {
          await _auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          completer.completeError('error: ${error.code}');
        },
        codeSent: (verificationId, forceResendingToken) {
          completer.complete(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          completer.completeError('error: Session Timeout...');
        },
      );
      return right(await completer.future);
    } on FirebaseAuthException catch (error) {
      throw error.message!;
    } catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }
  /// function for verify OTP
  FutureEither<User> verityOTP({required String vId, required String otp}) async {
    try {
      PhoneAuthCredential credential =
          PhoneAuthProvider.credential(verificationId: vId, smsCode: otp);
      final res = await _auth.signInWithCredential(credential);
      if (res.user == null) {
        throw 'Invalid OTP';
      }
      return right(res.user!);
    } on FirebaseException catch (error) {
      throw error.message!;
    } catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }

  // /// function for get current user data
  // Stream<UserModel> getUser(String uid) {
  //   return _users.doc(uid).snapshots().map(
  //       (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
  // }
  /// function for get current user data
  Future<DocumentSnapshot> getUser(String uid) {
    // return _users.doc(uid).snapshots().map(
    //     (event) => UserModel.fromJson(event.data() as Map<String, dynamic>));
    return _users.doc(uid).get();
  }
  /// logout
  void signOut(){
    _auth.signOut();
  }
}
