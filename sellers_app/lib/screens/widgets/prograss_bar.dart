import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

linearPrograssBar() {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 14.h),
    child: const LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
    ),
  );
}
