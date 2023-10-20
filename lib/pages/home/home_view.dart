import 'package:flutter/material.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/resources/images.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defaultScaffoldBgClr,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageStr.icHomeBg,
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Text(Globe.comingSoon),
          ),
        ],
      ),
    );
  }
}
