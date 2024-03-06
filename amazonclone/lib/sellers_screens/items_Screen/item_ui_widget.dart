import 'package:amazonclone/models/items.dart';
import 'package:amazonclone/sellers_screens/items_Screen/item_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ItemUiDesignWidget extends StatefulWidget {
  Items model;
  BuildContext context;
  ItemUiDesignWidget({
    Key? key,
    required this.model,
    required this.context,
  }) : super(key: key);

  @override
  State<ItemUiDesignWidget> createState() => _ItemUiDesignWidgetState();
}

class _ItemUiDesignWidgetState extends State<ItemUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ItemDetailsScreen(
                itemModel: widget.model,
              ))),
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(4.h),
          child: SizedBox(
            height: 100,
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.model.itemTitle!,
                  style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      letterSpacing: 3),
                ),
                SizedBox(height: 7.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model.itemImage!,
                    height: height * 0.3,
                    width: width * 0.7,
                    // fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: Text(
                    widget.model.itemInfo!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
