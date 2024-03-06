import 'package:amazonclone/models/brands.dart';
import 'package:amazonclone/sellers_screens/items_Screen/item_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class BrandUiDesignWidget extends StatefulWidget {
  Brands model;

  BrandUiDesignWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<BrandUiDesignWidget> createState() => _BrandUiDesignWidgetState();
}

class _BrandUiDesignWidgetState extends State<BrandUiDesignWidget> {
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
        // color: Colors.black,
        elevation: 10,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: SizedBox(
            height: 100,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      widget.model.brandImage!,
                      height: 194.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Text(
                  widget.model.brandTitle!,
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      letterSpacing: 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
