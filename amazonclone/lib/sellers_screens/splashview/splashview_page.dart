import 'dart:async';

import 'package:amazonclone/auth/authScreens/auth_srceens.dart';
import 'package:amazonclone/sellers_screens/home/home_screen.dart';
import 'package:amazonclone/sellers_screens/widgets/common_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/utils/const.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  splahScreenTimer() {
    Timer(const Duration(seconds: 3), () async {
      //user already logged-in
      if (FirebaseAuth.instance.currentUser != null &&
          FirebaseAuth.instance.currentUser!.emailVerified) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const HomeScreens()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const AuthScreens()));
      }
    });
  }

  @override

  void initState() {
    super.initState();
    splahScreenTimer();
  }
  @override


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink, Colors.purple],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(12.h),
                child: Image.asset(images["welcome"]!),
              ),
              SizedBox(
                height: 10.h,
              ),
              // Text(
              //   "iShop User App",
              //   style: TextStyle(
              //       fontSize: 30.sp, letterSpacing: 3, color: Colors.white),
              // )
              resuableText(
                  text: "iShop User App",
                  fontsize: 30.sp,
                  letterspacing: 3,
                  color: Colors.white,
                  fontweight: FontWeight.bold),
            ],
          ),
        ),
      ),
    );
  }
}
