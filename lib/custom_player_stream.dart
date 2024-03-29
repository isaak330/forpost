import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class CustomPlayerStream extends StatefulWidget {
  CustomPlayerStream({Key? key, required this.url}) : super(key: key);

  String url;

  @override
  State<CustomPlayerStream> createState() => _CustomPlayerStreamState();
}

class _CustomPlayerStreamState extends State<CustomPlayerStream> {
  late final bool _isplaying = true;
  VlcPlayerController? _vlcPlayerController;
  bool _isFullScreen = false;
  double playbackValue = 0.0;

  @override
  void dispose() async {
    super.dispose();
    await _vlcPlayerController?.stopRendererScanning();
    await _vlcPlayerController?.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vlcPlayerController = VlcPlayerController.network(
      widget.url,
      hwAcc: HwAcc.full,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
    _vlcPlayerController!.addListener(() {
      setState(() {
        playbackValue =
            _vlcPlayerController!.value.position.inSeconds.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildRTPSPlayer(context);
  }

  Center buildRTPSPlayer(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          widget.url != null
              ? VlcPlayer(
                  controller: _vlcPlayerController!,
                  aspectRatio: 16 / 9,
                  placeholder: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SizedBox(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
          // Positioned(
          //   top: 10,
          //   right: 10,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.white.withOpacity(0.3),
          //     ),
          //     child: IconButton(
          //       icon: const Icon(
          //         Icons.close,
          //         color: Colors.blue,
          //       ),
          //       onPressed: () {
          //         Navigator.pop(context);
          //       },
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 0,
            child: Container(
              width: _isFullScreen
                  ? MediaQuery.of(context).size.width / 1.2
                  : MediaQuery.of(context).size.width,
              color: Colors.white.withOpacity(0.5),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                // _isplaying
                //     ? TextButton(
                //         onPressed: () {
                //           setState(() {
                //             _isplaying = false;
                //             _vlcPlayerController?.pause();
                //           });
                //         },
                //         child: const Icon(
                //           Icons.pause,
                //           size: 30,
                //         ),
                //       )
                //     : TextButton(
                //         onPressed: () {
                //           setState(() {
                //             _isplaying = true;
                //             _vlcPlayerController?.play();
                //           });
                //         },
                //         child: const Icon(
                //           Icons.play_arrow,
                //           size: 30,
                //         ),
                //       ),
                // Expanded(
                //   flex: 2,
                //   child: SizedBox(
                //     child: Slider(
                //         value: playbackValue,
                //         max: double.parse(_vlcPlayerController!
                //             .value.duration.inSeconds
                //             .toString()),
                //         onChanged: (value) {
                //           setState(() {
                //             _vlcPlayerController!
                //                 .seekTo(Duration(seconds: value.toInt()));
                //           });

                //           // setState(() {});
                //         }),
                //   ),
                // ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isFullScreen = !_isFullScreen;
                      if (_isFullScreen) {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                        ]);
                      } else {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                        ]);
                      }
                    });
                  },
                  child: Icon(
                    _isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                    size: 30,
                  ),
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
