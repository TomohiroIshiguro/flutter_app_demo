import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerComponent extends StatefulWidget {
  int type;
  String videoPath;

  static const int ASSET = 0;
  static const int URL = 1;

  VideoPlayerComponent(this.type, this.videoPath) ;

  @override
  _VideoPlayerComponentState createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  VideoPlayerController _videoPlayerController;
  bool startedPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.type == VideoPlayerComponent.URL) {
      _videoPlayerController =
          VideoPlayerController.network(widget.videoPath);
    } else {
      _videoPlayerController =
          VideoPlayerController.asset(widget.videoPath);
    }
    _videoPlayerController.addListener(() {
      if (startedPlaying && !_videoPlayerController.value.isPlaying) {
        Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future<bool> started() async {
    startedPlaying = false;
    try {
      await _videoPlayerController.initialize();
      await _videoPlayerController.play();
      startedPlaying = true;
    } catch (e) {
      print(e);
    }
    return startedPlaying;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      child: Center(
        child: FutureBuilder<bool>(
          future: started(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return AspectRatio(
                aspectRatio: _videoPlayerController.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController),
              );
            } else {
              return const Text('waiting for video to load');
            }
          },
        ),
      ),
    );
  }
}