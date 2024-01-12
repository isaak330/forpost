import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:forpost/custom_player%20-%20Copia.dart';
import 'package:forpost/src/Repos/get_stream_repo.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage({super.key});

  // final int id;
  // final String name;
  // const VideoPlayerPage({super.key, required this.id, required this.name});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CustomVideoPlayerController _controller;
  late Uri uri;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
              // widget.name
              'asd'),
        ),
        body: CustomPlayer(
            url:
                'rtsp://video-test.k-telecom.org:8080/rtsp/1859/StHYqddnjBxpDkR9SpJ0'));
  }
}
