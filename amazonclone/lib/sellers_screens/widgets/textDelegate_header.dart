import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextDelegateHeader extends SliverPersistentHeaderDelegate {
  String? title;
  TextDelegateHeader({this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink, Colors.purple],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        height: height * 0.1,
        width: width,
        child: InkWell(
          child: Text(title!,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white, fontSize: 18.sp, letterSpacing: 1)),
        ),
      ),
    );
  }

  //will Ocuured error if you don't put maxExtent
  @override
  // TODO: implement maxExtent
  double get maxExtent => 50;

  @override
  // TODO: implement minExtent
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
