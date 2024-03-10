import 'package:app/shared/models/youtubeModel.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final VideoItem video;
  const VideoPlayer({super.key, required this.video});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late YoutubePlayerController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = YoutubePlayerController(
        initialVideoId: widget.video.id.videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          controlsVisibleAtStart: true,
          mute: false,
        ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !controller.value.isFullScreen,
      onPopInvoked: (didPop) {
        if (controller.value.isFullScreen) {
          controller.toggleFullScreenMode();
        }
      },
      child: OrientationBuilder(builder: (context, orientation) {
        return Scaffold(
            appBar: (orientation == Orientation.landscape)
                ? null
                : AppBar(title: const Text('Video')),
            body: Column(
              children: [
                Expanded(
                  flex: controller.value.isFullScreen ? 1 : 0,
                  child: YoutubePlayer(
                    controller: controller,
                    showVideoProgressIndicator: true,
                  ),
                ),
                if (orientation == Orientation.portrait)
                  Expanded(flex: 2, child: Container(color: Colors.white)),
              ],
            ));
      }),
    );
  }
}
