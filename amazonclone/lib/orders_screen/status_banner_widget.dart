import 'package:amazonclone/sellers_screens/home/home_screen.dart';
import 'package:amazonclone/sellers_screens/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class StatusBanner extends StatelessWidget {
  bool? status;
  String? orderStatus;

  StatusBanner({
    super.key,
    required this.status,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = "Successful" : message = "UnSuccessful";

    return Container(
      height: 70.h,
      child: commonContainer(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreens())),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          // SizedBox(
          //   width: 30.w,
          // ),
          Text(
            orderStatus == "ended"
                ? "Parcel Dlivered $message"
                : orderStatus == "shifted"
                    ? "Parcel Shifted $message"
                    : orderStatus == "normal"
                        ? "Order Placed $message"
                        : "",
            style: TextStyle(color: Colors.black, fontSize: 16.sp),
          ),
          // SizedBox(
          //   width: 5.w,
          // ),
          CircleAvatar(
            radius: 15,
            backgroundColor: Colors.black,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
