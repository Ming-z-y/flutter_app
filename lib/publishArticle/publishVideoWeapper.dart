import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PublishVideoWeapper extends StatefulWidget {
  const PublishVideoWeapper({
    Key? key,
    required this.url,
    required this.child,
  }) : super(key: key);
  final String url;
  final Widget child;

  @override
  State<StatefulWidget> createState() => _PublishVideoWeapper();
}

class _PublishVideoWeapper extends State<PublishVideoWeapper> {
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
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Center(
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
          ),
        ),
        SizedBox(
          child: widget.child,
        )
      ],
    );
  }
}
