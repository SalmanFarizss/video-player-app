import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lilac_task_app/core/commons/failure.dart';
import 'package:lilac_task_app/core/constants/firebase_constants.dart';
import 'package:lilac_task_app/core/typedef.dart';
import 'package:http/http.dart' as http;
import '../../../models/user_model.dart';
class HomeRepository {
  final FirebaseFirestore _fireStore;
  HomeRepository(
      { required FirebaseFirestore fireStore})
      :
        _fireStore = fireStore;
  CollectionReference get _users =>
      _fireStore.collection(FirebaseConstants.usersCollection);
  FutureEither<UserModel> addUserData({required UserModel userModel})async{
    try{
      await _users.doc(userModel.uid).set(userModel.toJson());
      return right(userModel);
    }on FirebaseException catch(error){
      throw error.message!;
    }catch(e){
      return left(Failure(failure: e.toString()));
    }
  }
  FutureEither<List<String>> getVideosFromOnline() async {
    // try {
    //   bool initialised = await Dropbox.init(
    //       'Lilac Task', 'ftv84qqxoro41zg', 'pywdin13dkxvd9i');
    //   if (!initialised) {
    //     throw 'DropBox initialisation failed';
    //   }
    //   await Dropbox.authorizeWithAccessToken(
    //     'sl.My_ACCESS_TOKEN'
    //   ).then((value) async {
    //     final result = await Dropbox.listFolder('');
    //     for (var data in result) {
    //       if (data['filesize'] != null) {
    //         final link = await Dropbox.getTemporaryLink(data['pathLower']);
    //         if (link != null) {
    //           videoLinks.add(link);
    //         }
    //       }
    //     }
    //   });
    //   print(videoLinks);
    //   videos=videoLinks;
    //   if (videoLinks.isNotEmpty) {
    //     _playerController =
    //         VideoPlayerController.networkUrl(Uri.parse(videoLinks.first))
    //           ..initialize().then((value) {
    //             setState(() {});
    //           });
    //   }
    // } catch (e) {
    //   print(e.toString());
    // }
    List<String> videoLinks = [];
    try {
      List<String> videoIds =[];
      const String apiUrl ='https://www.googleapis.com/drive/v3/files?q=\'YOUR-DRIVE-FOLDER-ID\'+in+parents&key=YOUR-DRIVE-API-KEY';
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> files = jsonData['files'];
        for(Map<String,dynamic> fileData in files){
          if(fileData['mimeType']=='video/mp4'){
            videoIds.add(fileData['id']);
          }
        }
      }else{
        throw 'Api failed with status code:${response.statusCode}';
      }
      return right(videoIds);
    }on Exception catch (e) {
      return left(Failure(failure: e.toString()));
    }
  }
}
