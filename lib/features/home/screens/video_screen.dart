import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lilac_task_app/core/utilities.dart';
import 'package:video_player/video_player.dart';
import '../../auth/screens/splash_screen.dart';

final isUploadingProvider = StateProvider<double>((ref) {
  return 0;
});

class VideoScreen extends ConsumerStatefulWidget {
  final List<String> videoList;
  const VideoScreen({super.key, required this.videoList});
  @override
  ConsumerState<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends ConsumerState<VideoScreen> {
  late FlickManager flickManager;
  int index = 0;
  Future<void> downloadFile(BuildContext context) async {
    FileDownloader.downloadFile(
        url:
            'https://drive.google.com/uc?export=download&id=${widget.videoList[index]}',
        name: 'lilac: ${DateTime.now()}',
        onProgress: (fileName, progress) {
          ref.read(isUploadingProvider.notifier).update((state) => progress);
        },
        onDownloadCompleted: (String path) {
          ref.read(isUploadingProvider.notifier).update((state) => 0);
          successSnackBar(context, 'File downloaded to the Path: $path');
          print('path:...................$path');
        },
        onDownloadError: (String error) {
          ref.read(isUploadingProvider.notifier).update((state) => 0);
          failureSnackBar(context, 'Error While Uploading: $error');
        });
  }

  changeController() {
    flickManager.handleChangeVideo(VideoPlayerController.networkUrl(
      Uri.parse(
          'https://drive.google.com/uc?export=view&id=${widget.videoList[index]}'),
    ));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.networkUrl(
      Uri.parse(
          'https://drive.google.com/uc?export=view&id=${widget.videoList[index]}'),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: height * 0.3,
          child: FlickVideoPlayer(flickManager: flickManager),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              index == 0
                  ? SizedBox(
                      height: width * 0.1,
                      width: width * 0.1,
                    )
                  : GestureDetector(
                      onTap: () {
                        --index;
                        changeController();
                      },
                      child: Container(
                        height: width * 0.1,
                        width: width * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Theme.of(context).cardColor),
                        child: const Icon(CupertinoIcons.left_chevron),
                      ),
                    ),
              Consumer(
                builder: (context, ref, child) {
                  double progress = ref.watch(isUploadingProvider);
                  return progress == 0.0
                      ? GestureDetector(
                          onTap: () {
                            downloadFile(context);
                          },
                          child: Container(
                            height: width * 0.1,
                            width: width * 0.32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(13),
                                color: Theme.of(context).cardColor),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.arrow_drop_down,
                                    color: Theme.of(context).primaryColor,
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
                        )
                      : Container(
                          height: width * 0.1,
                          width: width * 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(13),
                              color: Theme.of(context).cardColor),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Downloading: ',
                                style: TextStyle(
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '$progress%',
                                style: TextStyle(
                                    fontSize: width * 0.032,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        );
                },
              ),
              index == widget.videoList.length - 1
                  ? SizedBox(
                      height: width * 0.1,
                      width: width * 0.1,
                    )
                  : GestureDetector(
                      onTap: () {
                        ++index;
                        changeController();
                      },
                      child: Container(
                        height: width * 0.1,
                        width: width * 0.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).cardColor),
                        child: const Icon(CupertinoIcons.right_chevron),
                      ),
                    ),
            ],
          ),
        )
      ],
    );
  }
}
