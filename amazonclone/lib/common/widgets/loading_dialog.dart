import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;
  const LoadingDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 14.h),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text("$message , Please Wait...", style: const TextStyle())
        ],
      ),
    );
  }
}
