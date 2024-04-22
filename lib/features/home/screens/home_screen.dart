import 'dart:convert';
import 'package:dropbox_client/dropbox_client.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task_app/features/auth/controller/auht_controller.dart';
import 'package:lilac_task_app/features/auth/screens/splash_screen.dart';
import 'package:lilac_task_app/features/home/controller/home_controller.dart';
import 'package:lilac_task_app/features/home/screens/drawer.dart';
import 'package:lilac_task_app/features/home/screens/profile_screen.dart';
import 'package:lilac_task_app/features/home/screens/video_screen.dart';
import 'package:lilac_task_app/models/user_model.dart';
import 'package:video_player/video_player.dart';
import '../../../core/commons/loading.dart';

final darkThemeProvider = StateProvider<bool>((ref) => false);
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading=true;
  @override
  void initState() {
    ref.read(homeControllerProvider.notifier).getVideosFromOnline(context);
    Future.delayed(Duration(seconds: 2),(){
      setState(() {
        isLoading=false;
      });
    });
    super.initState();
  }
  bool paused = true;
  @override
  Widget build(BuildContext context) {
    List<String> videos = ref.watch(videoProvider);
    // if(videos.isNotEmpty){
    //   _playerController = VideoPlayerController.networkUrl(Uri.parse(
    //       'https://drive.google.com/uc?export=view&id=${videos.first}'))
    //     ..initialize().then((value) {
    //       setState(() {});
    //     });
    // }
    UserModel user = ref.watch(userProvider)!;
    return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              drawer: HomeDrawer(
                user: user,
              ),
              // backgroundColor:Theme.of(context).colorScheme.background,
              body:isLoading?const Loading() : Stack(
                children: [
                  videos.isEmpty? Center(child: Text('No Images Found'),):
                  VideoScreen(videoList: videos),
                  Padding(
                    padding: EdgeInsets.all(width * 0.03),
                    child: SizedBox(
                      width: width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                size: width * 0.1,
                                color: Colors.white,
                              )),
                          Container(
                            height: width * 0.12,
                            width: width * 0.12,
                            decoration: BoxDecoration(
                                image:DecorationImage(image:  NetworkImage(user.imageUrl),fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(15)),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ),
          );
  }
}
