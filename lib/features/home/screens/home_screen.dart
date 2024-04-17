import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lilac_task_app/features/auth/screens/splash_screen.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   late VideoPlayerController _playerController;
  @override
  void initState() {
    _playerController = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((value) {
        setState(() {});
      });
    super.initState();
  }
  bool paused=false;
  @override
  Widget build(BuildContext context) {
    if(paused){
      _playerController.pause();
    }else{
      _playerController.play();
    }
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [],
          ),
        ),
        backgroundColor: Colors.grey.shade100,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: height * 0.28,
                      width: width,
                      color: Colors.red.shade100,
                      child: _playerController.value.isInitialized
                          ? AspectRatio(
                        aspectRatio: _playerController.value.aspectRatio,
                        child: VideoPlayer(_playerController),
                      )
                          : Container(
                        // height: height * 0.28,
                        // width: width,
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(onTap:() {
                      setState(() {
                        paused=!paused;
                      });
                    },
                      child:paused?Icon(CupertinoIcons.play):Icon(Icons.pause)
                      ,
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: width * 0.1,
                          width: width * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.white),
                          child: const Icon(CupertinoIcons.left_chevron),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: width * 0.1,
                          width: width * 0.32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Colors.white),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.arrow_drop_down,
                                  color: Color.fromRGBO(87, 238, 157, 1),
                                  size: width * 0.1),
                              Text(
                                'Download',
                                style: TextStyle(
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: width * 0.1,
                          width: width * 0.1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: const Icon(CupertinoIcons.right_chevron),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
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
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.brown),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
