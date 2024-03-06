import 'package:flutter/material.dart';




Widget commonContainer({required Widget child}) {
  return Container(
    decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.pink, Colors.purple],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp)),
    child: child,
  );
}

Widget resuableText(
    {required String text,
    required double fontsize,
    required double letterspacing,
    required Color color,
    required FontWeight fontweight}) {
  return Text(
    text,
    style: TextStyle(
        fontSize: fontsize,
        letterSpacing: letterspacing,
        color: color,
        fontWeight: fontweight),
  );
}

Widget tabLoginAndSignUp({required String text, required IconData icon}){
 return  Tab(
              text: text,
              icon: Icon(
                icon,
                color: Colors.white,
              ),
            );
}