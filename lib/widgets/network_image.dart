import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:rxdart/rxdart.dart';

class NetworkImageWidget extends StatelessWidget {
  final String path;
  final BehaviorSubject<int> refreshTrigger;

  const NetworkImageWidget({
    super.key,
    required this.path,
    required this.refreshTrigger,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: refreshTrigger.stream,
      builder: (context, snapshot) {
        return CachedNetworkImage(
          imageUrl: '$path?ts=${snapshot.data ?? 0}',
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          progressIndicatorBuilder: (_, url, download) {
            if (download.progress != null) {
              final percent = download.progress! * 100;
              return Center(
                child: CircularPercentIndicator(
                  radius: 40.0,
                  lineWidth: 5.0,
                  animation: true,
                  percent: percent.round() / 100,
                  backgroundColor: Styles.theme,
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: Styles.theme,
                  center: Text(
                    "${percent.round()}%",
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Styles.theme,
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Text('', style: Styles.tsDefaultTxtClr14sp),
              );
            }
          },
          errorWidget: (context, url, error) {
            // Automatically trigger a refresh when an error occurs
            refreshTrigger.add(DateTime.now().millisecondsSinceEpoch);
            return Container();
          },
        );
      },
    );
  }
}

// "https://huanbao-bucket.oss-cn-hongkong.aliyuncs.com"

// class NetworkImageWidget extends StatelessWidget {
//   const NetworkImageWidget({
//     Key? key,
//     required this.path,
//   }) : super(key: key);
//
//   final String path;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: path,
//       cacheKey: path + DateTime.now().day.toString(),
//       imageBuilder: (context, imageProvider) => Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: imageProvider,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//       progressIndicatorBuilder: (_, url, download) {
//         if (download.progress != null) {
//           final percent = download.progress! * 100;
//           return Center(
//             child: CircularPercentIndicator(
//               radius: 40.0,
//               lineWidth: 5.0,
//               animation: true,
//               percent: percent.round() / 100,
//               backgroundColor: Styles.theme,
//               circularStrokeCap: CircularStrokeCap.round,
//               progressColor: Styles.theme,
//               center: Text(
//                 "${percent.round()}%",
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   color: Styles.theme,
//                 ),
//               ),
//             ),
//           );
//         } else {
//           return Center(
//             child: Text('', style: Styles.tsDefaultTxtClr14sp),
//           );
//         }
//       },
//       errorWidget: (context, url, error) => Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Icon(
//             Icons.error,
//             size: 33.sp,
//           ),
//           8.verticalSpace,
//           Text(
//             Globe.networkImgLoadFailed,
//             style: Styles.tsDefaultTxtClr12sp,
//           ),
//           Text(error.toString(), style: Styles.tsDefaultTxtClr12sp,),
//         ],
//       ),
//     );
//   }
// }
