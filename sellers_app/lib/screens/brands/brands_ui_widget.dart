import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:sellers_app/models/brands.dart';
import 'package:sellers_app/screens/itemsScreen/item_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/screens/splashScreen/splashview_page.dart';
import '../../common/widgets/flutter_toast.dart';

// ignore: must_be_immutable
class BrandUiDesignWidget extends StatefulWidget {
  Brands model;
  BuildContext context;
  BrandUiDesignWidget({
    Key? key,
    required this.model,
    required this.context,
  }) : super(key: key);

  @override
  State<BrandUiDesignWidget> createState() => _BrandUiDesignWidgetState();
}

class _BrandUiDesignWidgetState extends State<BrandUiDesignWidget> {
  deleteBrand(String brandUniqueId) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("brands")
        .doc(brandUniqueId)
        .delete();
    toastInfo(msg: "Brand has been Deleted Successfully");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ItemScreen(
                model: widget.model,
              ))),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 100,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.model.brandImage!,
                  height: 220.h,
                  fit: BoxFit.fill,
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.model.brandTitle!,
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                          letterSpacing: 3),
                    ),
                    IconButton(
                        onPressed: () {
                          deleteBrand(widget.model.brandId!);
                        },
                        icon: const Icon(
                          Icons.delete_sweep,
                          color: Colors.pinkAccent,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
