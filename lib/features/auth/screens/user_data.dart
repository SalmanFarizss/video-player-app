import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task_app/core/commons/loading.dart';

import '../../../models/user_model.dart';
import '../../home/screens/home_screen.dart';
import '../../home/screens/profile_screen.dart';
import '../controller/auht_controller.dart';
class UserDataScreen extends ConsumerStatefulWidget {
  final String uid;
  final String phone;
  const UserDataScreen({super.key,required this.uid,required this.phone});
  @override
  ConsumerState<UserDataScreen> createState() => _UserDataScreenState();
}

class _UserDataScreenState extends ConsumerState<UserDataScreen> {
  Future<void> getUser()async{
    DocumentSnapshot userDoc =
        await ref.read(authControllerProvider.notifier).getUser(widget.uid);
    if (userDoc.exists) {
      UserModel userModel = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      ref.read(userProvider.notifier).update((state) => userModel);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen(uid: widget.uid, phone: widget.phone),));
    }
  }
  @override
  void initState() {
    getUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Loading());
  }
}
