import 'package:amazonclone/models/items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CartItemDesignUi extends StatefulWidget {
  Items? model;
  int? quantityNumber;
  CartItemDesignUi(
      {super.key, required this.model, required this.quantityNumber});

  @override
  State<CartItemDesignUi> createState() => _CartItemDesignUiState();
}

class _CartItemDesignUiState extends State<CartItemDesignUi> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.black,
      shadowColor: Colors.white54,
      elevation: 10,
      child: SizedBox(
          height: 100.h,
          width: width,
          child: Row(
            children: [
              SizedBox(
                width: 10.h,
              ),
              Image.network(
                widget.model!.itemImage!,
                width: 120.w,
                height: 120.h,
                fit: BoxFit.fill,
              ),
              SizedBox(
                width: 30.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width * 0.5,
                    child: Text(
                      widget.model!.itemTitle!,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  //Price
                  Row(
                    children: [
                      Text(
                        "Price:",
                        style:
                            TextStyle(fontSize: 15.sp, color: Colors.white54),
                      ),
                      Text(
                        "\$",
                        style: TextStyle(
                            fontSize: 15.sp, color: Colors.purpleAccent),
                      ),
                      Text(
                        widget.model!.itemPrice!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                  //Quantity
                  Row(
                    children: [
                      Text(
                        "Quantity:",
                        style:
                            TextStyle(fontSize: 18.sp, color: Colors.white54),
                      ),
                      Text(
                        "${widget.quantityNumber}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }
}
