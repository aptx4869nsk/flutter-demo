import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:kaibo/resources/styles.dart';

class AdDialog extends StatelessWidget {
  final String? title;
  final String? htmlData;
  final Image? image;

  const AdDialog({
    Key? key,
    this.title,
    this.htmlData,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 35.h),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(17),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Styles.theme,
                  letterSpacing: 2,
                ),
              ),
            ),
            10.verticalSpace,
            SizedBox(
              width: double.infinity,
              height: 240.h,
              child: SingleChildScrollView(
                child: Html(data: htmlData),
              ),
            ),
            10.verticalSpace,
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => Get.back(),
                child: Text(
                  '关闭',
                  style: Styles.tsTheme12spBold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
