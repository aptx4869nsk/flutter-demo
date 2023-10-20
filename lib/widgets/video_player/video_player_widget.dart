import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'video_overlay_widget.dart';

class VideoPlayerWidget extends StatelessWidget {
  final VideoPlayerController controller;

  const VideoPlayerWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => controller.value.isInitialized
      ? Container(
          alignment: Alignment.topCenter,
          child: buildVideo(),
        )
      : SizedBox(
          height: 200.h,
          child: Container(
            color: Styles.defaultScaffoldBgClr.withOpacity(0.5),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitWave(
                  size: 18.sp,
                  color: Styles.theme,
                ),
                8.verticalSpace,
                Text(
                  '加载中',
                  style: Styles.ts_theme_10sp_semibold,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );

  Widget buildVideo() => Stack(
        fit: StackFit.expand, // loose-expand new added
        children: [
          buildVideoPlayer(),
          Positioned.fill(
            child: VideoOverlayWidget(controller: controller),
          ),
        ],
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      );

  Widget buildFullScreen({required Widget child}) {
    final size = controller.value.size;
    final width = 1.sw; //size.width;
    final height = 200.h; // size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }
}
