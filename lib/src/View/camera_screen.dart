import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/material.dart';
import 'package:forpost/src/Repos/get_archive_repo.dart';
import 'package:forpost/src/Repos/get_stream_repo.dart';
import 'package:forpost/src/custom_player_archive.dart';

class VideoPlayerPage extends StatefulWidget {
  final int id;
  final String name;
  const VideoPlayerPage({super.key, required this.id, required this.name});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CustomVideoPlayerController _controller;
  late Uri uri;
  @override
  void initState() {
   var _stream = GetStreamRepo.GetStream(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
            // widget.name
            widget.name),
      ),
      body: FutureBuilder(
        future: GetArchiveRepo.GetArchive(widget.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomPlayerArchive(url: snapshot.data),
            ],
          );
        },
      ),
    );
  }
}
