import 'package:amazonclone/global/global.dart';
import 'package:amazonclone/orders_screen/orders_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDrawar extends StatefulWidget {
  const MyDrawar({super.key});

  @override
  State<MyDrawar> createState() => _MyDrawarState();
}

class _MyDrawarState extends State<MyDrawar> {
  @override
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          //header
          Container(
            padding: EdgeInsets.only(top: 26.h, bottom: 12.h),
            child: Column(
              children: [
                SizedBox(
                  height: 120.h,
                  width: 120.w,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      sharedPreferences!.getString("photoUrl")!,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          //body
          Container(
            padding: EdgeInsets.only(top: 5.h),
            child: Column(
              children: [
                drawElement(Icons.home, "Home", () {}),
                drawElement(Icons.reorder, "My Order", () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const OrdersScreen()));
                }),
                drawElement(Icons.picture_in_picture_alt_rounded,
                    "Not Yet Receive Order", () {}),
                drawElement(Icons.history, "History", () {}),
                drawElement(Icons.search, "Search", () {}),
                drawElement(Icons.logout, "LogOut", () async {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("authscreen", (route) => false);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget drawElement(IconData icon, String textTitle, void Function()? function) {
  return Column(
    children: [
      Divider(
        height: 8.h,
        color: Colors.grey,
        thickness: 2.h,
      ),
      ListTile(
        leading: Icon(
          icon,
          color: Colors.grey,
        ),
        title: Text(
          textTitle,
          style: const TextStyle(color: Colors.grey),
        ),
        onTap: function,
      ),
    ],
  );
}
