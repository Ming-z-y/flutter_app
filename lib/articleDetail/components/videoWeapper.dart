import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWeapper extends StatefulWidget {
  const VideoWeapper({
    Key? key,
    required this.url,
  }) : super(key: key);
  final String url;

  @override
  State<StatefulWidget> createState() => _VideoWeapper();
}

class _VideoWeapper extends State<VideoWeapper> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.url);
    await _videoPlayerController1.initialize();
    _createChewieController();
  }

  void _createChewieController() {
    setState(() {
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        autoPlay: false,
        looping: false,
        cupertinoProgressColors:
            ChewieProgressColors(backgroundColor: Colors.amber),
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.orange,
          // bufferedColor: Colors.black,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(
              controller: _chewieController!,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Loading'),
              ],
            ),
    );
  }
}
