import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoEditor extends StatefulWidget {
  const VideoEditor({super.key});

  @override
  State<VideoEditor> createState() {
    return _VideoEditor();
  }
}

class _VideoEditor extends State<VideoEditor> {
  late File _video;
  late VideoPlayerController controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  initState() {
    super.initState();
    controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );

    _initializeVideoPlayerFuture = controller.initialize();
  }

  _pickerVideo() async {
    var video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    print('video' + video!.path);
  }

  _takePhoto() async {
    var video = await ImagePicker().pickVideo(source: ImageSource.camera);
    _video = video as File;
    controller = VideoPlayerController.file(_video);
    controller.initialize().then((value) => {controller.play()});

    print('video' + video!.path);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Center(
  //     child: Column(
  //       children: [
  //         TextButton(
  //             onPressed: (() => {_pickerVideo()}), child: const Text('本地选择视频')),
  //         TextButton(
  //             onPressed: () => {_takePhoto()}, child: const Text('拍摄视频')),
  //         VideoPlayer(controller),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
