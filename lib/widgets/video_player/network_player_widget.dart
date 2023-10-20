import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:kaibo/widgets/video_player/video_player_widget.dart';

class NetworkPlayerWidget extends StatefulWidget {
  final String videoUrlLink;

  const NetworkPlayerWidget({
    Key? key,
    required this.videoUrlLink,
  }) : super(key: key);

  @override
  State<NetworkPlayerWidget> createState() => _NetworkPlayerWidgetState();
}

class _NetworkPlayerWidgetState extends State<NetworkPlayerWidget> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrlLink))
          ..addListener(() {
            setState(() {});
          })
          ..setLooping(true)
          ..initialize().then((_) => controller.pause());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: VideoPlayerWidget(
        controller: controller,
      ),
    );
  }
}
