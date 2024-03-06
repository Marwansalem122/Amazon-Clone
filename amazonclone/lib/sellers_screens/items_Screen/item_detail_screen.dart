import 'package:amazonclone/common/widgets/flutter_toast.dart';
import 'package:amazonclone/models/items.dart';
import 'package:amazonclone/sellers_screens/widgets/appbar_cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cart_stepper/cart_stepper.dart';

import 'package:amazonclone/global/global.dart';

// ignore: must_be_immutable
class ItemDetailsScreen extends StatefulWidget {
  Items? itemModel;
  ItemDetailsScreen({
    Key? key,
    required this.itemModel,
  }) : super(key: key);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  int counterLimit = 0;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarWithCartBadge(sellerUid: widget.itemModel!.sellerId),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.purpleAccent,
        onPressed: () {
          int itemCounter = counterLimit;

          List<String> itemIDsList =
              cartMethods.separateItemIDsFromUserCartList();
          //check if item exist already in cart
          if (itemIDsList.contains(widget.itemModel!.itemId)) {
            toastInfo(msg: "item is already in Cart.");
          } else if (counterLimit == 0) {
            toastInfo(msg: "no item is selected.");
          } else {
            //add item in cart
            cartMethods.addItemToCart(
                widget.itemModel!.itemId, itemCounter, context);
          }
        },
        label: const Text("Add To Cart"),
        icon: const Icon(Icons.add_shopping_cart_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20.h),
          Container(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.network(
                widget.itemModel!.itemImage!,
                //fit: BoxFit.fill,
                // height: 200.h,
                width: width * 0.9,
              ),
            ),
          ),
          Center(
            child: CartStepperInt(
                size: 40.h,
                didChangeCount: (value) {
                  if (value < 1) {
                    toastInfo(msg: "The quantity can't be less than 1");
                  }
                  setState(() {
                    counterLimit = value;
                  });
                }, //updated value
                // ignore: deprecated_member_use
                count: counterLimit, //must not be zero
                style: const CartStepperStyle(
                  activeBackgroundColor: Colors.purpleAccent,
                )),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Text(
              " ${widget.itemModel!.itemTitle!}: ",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.pinkAccent),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.04, left: width * 0.04),
            child: Text(
              "Description: ",
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Text(
              widget.itemModel!.itemDescription!,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 15.sp,
                  color: Colors.grey),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.04, left: width * 0.04),
            child: RichText(
              text: TextSpan(children: [
                const TextSpan(
                  text: 'Price: ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "${widget.itemModel!.itemPrice!}\$",
                  style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: width * 0.04,
                top: width * 0.04,
                right: width * 0.72,
                bottom: 50.h),
            child: Divider(
              height: 1.h,
              thickness: 2,
              color: Colors.pink,
            ),
          ),
        ]),
      ),
    );
  }
}
