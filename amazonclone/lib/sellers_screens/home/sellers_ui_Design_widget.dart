import 'package:amazonclone/brands_screen/brands_screen.dart';
import 'package:flutter/material.dart';

import 'package:amazonclone/models/sellers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

// ignore: must_be_immutable
class SellersUiDesignWidget extends StatefulWidget {
  Sellers? sellerModel;
  SellersUiDesignWidget({
    Key? key,
    required this.sellerModel,
  }) : super(key: key);

  @override
  State<SellersUiDesignWidget> createState() => _SellersUiDesignWidgetState();
}

class _SellersUiDesignWidgetState extends State<SellersUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => BrandsScreen(
                sellerMode: widget.sellerModel,
              ))),
      child: Card(
        color: Colors.black54,
        elevation: 20,
        shadowColor: Colors.grey,
        child: SizedBox(
            height: 290.h,
            width: width,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: SizedBox(
                    width: width * 0.9,
                    child: Image.network(
                      widget.sellerModel!.photoUrl!,
                      height: 220.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(widget.sellerModel!.name!,
                    style: TextStyle(
                        color: Colors.pinkAccent,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold)),
                SmoothStarRating(
                  rating: widget.sellerModel!.ratings == null
                      ? 0.0
                      : double.parse(widget.sellerModel!.ratings!),
                  starCount: 5,
                  color: Colors.pinkAccent,
                  borderColor: Colors.pinkAccent,
                  size: 16.h,
                )
              ],
            )),
      ),
    );
  }
}
