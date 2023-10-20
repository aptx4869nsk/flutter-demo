import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/widgets/video_player/network_player_widget.dart';

class VideoSwapper extends StatelessWidget {
  final List<String> videos;
  final String? oss;

  const VideoSwapper({
    Key? key,
    required this.videos,
    required this.oss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return NetworkPlayerWidget(
          videoUrlLink: "$oss${videos[index]}",
        );
      },
      itemCount: videos.length,
      pagination: SwiperCustomPagination(
        builder: (context, config) {
          return ConstrainedBox(
            constraints: const BoxConstraints.expand(
              width: double.infinity,
              height: double.infinity,
            ),
            child: videos.isNotEmpty
                ? Visibility(
                    visible: false,
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 15.w,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${config.activeIndex + 1}',
                            style: Styles.tsDefaultTxtClr18spBold200,
                          ),
                          Text(
                            '/',
                            style: Styles.tsDefaultTxtClr18spBold200,
                          ),
                          Text(
                            "${config.itemCount}",
                            style: Styles.tsTheme18spBold200,
                          )
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Container(
                      color: Styles.defaultScaffoldBgClr.withOpacity(0.5),
                    ),
                  ),
          );
        },
      ),
      autoplay: false,
      loop: false,
      onTap: (index) {},
      onIndexChanged: (index) {},
    );
  }
}
