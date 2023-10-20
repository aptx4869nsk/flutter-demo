import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';

class VideoOverlayWidget extends StatelessWidget {
  final VideoPlayerController controller;
  static const allSpeeds = <double>[0.25, 0.5, 1.0, 1.5, 2.0, 3.0, 5.0, 10];

  const VideoOverlayWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  String getPosition() {
    final duration = Duration(
        microseconds: controller.value.position.inMicroseconds.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
    behavior: HitTestBehavior.opaque,
    onTap: () =>
    controller.value.isPlaying ? controller.pause() : controller.play(),
    child: Stack(
      children: [
        buildPlay(),
        buildSpeed(),
        // logo
        // Positioned(
        //   top: 5.h,
        //   left: 5.w,
        //   child: Image.asset(
        //     ImageRes.ic_app_logo_landscape,
        //     width: 100.h,
        //     height: 40.h,
        //   ),
        // ),
        Positioned(
          left: 4.w,
          bottom: 8.h,
          child: Text(
            getPosition(),
            style: TextStyle(
              color: const Color(0xFFFFFFFF),
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: buildIndicator(),
        ),
      ],
    ),
  );

  Widget buildIndicator() => VideoProgressIndicator(controller,
      allowScrubbing: false,
      colors: VideoProgressColors(
        //video player progress bar
        backgroundColor: const Color.fromRGBO(200, 200, 200, 0.5),
        playedColor: Styles.theme,
        bufferedColor: const Color.fromRGBO(50, 50, 200, 0.2),
      ));

  Widget buildPlay() => controller.value.isPlaying
      ? Container()
      : Container(
    alignment: Alignment.center,
    color: Colors.white24, //Colors.black26,
    child: const Icon(
      Icons.play_arrow,
      color: Colors.white,
      size: 80,
    ),
  );

  Widget buildSpeed() => Align(
    alignment: Alignment.topLeft,
    child: PopupMenuButton<double>(
      initialValue: controller.value.playbackSpeed,
      tooltip: '快速播放',
      onSelected: (value) => controller.setPlaybackSpeed(value),
      itemBuilder: (context) => allSpeeds
          .map<PopupMenuEntry<double>>(
            (speed) => PopupMenuItem(
          value: speed,
          child: Text('${speed}x'),
        ),
      )
          .toList(),
      child: Container(
        color: Styles.cThemeOpacity20, // Colors.white38
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Text(
          '${controller.value.playbackSpeed}x',
          style: Styles.tsFFFFFF16spSemiBold,
        ),
      ),
    ),
  );
}
