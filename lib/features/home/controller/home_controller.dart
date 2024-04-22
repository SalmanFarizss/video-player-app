import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task_app/core/providers/firebase_porviders.dart';
import 'package:lilac_task_app/core/providers/storage_repository_provider.dart';
import 'package:lilac_task_app/features/auth/controller/auht_controller.dart';
import 'package:lilac_task_app/features/home/repository/home_repository.dart';
import 'package:lilac_task_app/models/user_model.dart';
import 'package:video_player/video_player.dart';
import '../../../core/utilities.dart';
import '../screens/home_screen.dart';

final homeControllerProvider =
    NotifierProvider<HomeController, bool>(() => HomeController());
final videoProvider = StateProvider<List<String>>((ref) => []);

final homeRepositoryProvider = Provider<HomeRepository>(
    (ref) => HomeRepository(fireStore: ref.read(fireStoreProvider)));

class HomeController extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  HomeRepository get _repository => ref.read(homeRepositoryProvider);
  StorageRepository get _storageRepository =>
      ref.read(storageRepositoryProvider);
  Future<void> addUserData(
      {required UserModel userModel,
      required File selectedImage,
      required BuildContext context}) async {
    state = true;
    final res = await _storageRepository.storeFile(
        'users/avatar', DateTime.now().toString(), selectedImage);
    state = false;
    res.fold((l) => failureSnackBar(context, l.failure), (r) async {
      userModel = userModel.copyWith(imageUrl: r);
      state = true;
      final dat = await _repository.addUserData(userModel: userModel);
      state = false;
      dat.fold((l) => failureSnackBar(context, l.failure), (r) {
        successSnackBar(context, 'Details updated');
        ref.read(userProvider.notifier).update((state) => r);
        Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) =>  HomeScreen()));
      });
    });
  }
  Future<void> getVideosFromOnline(BuildContext context)async{
    var res=await _repository.getVideosFromOnline();
    res.fold((l) => failureSnackBar(context,l.failure), (r) {
      ref.read(videoProvider.notifier).update((state) => r);
    });
  }
}
