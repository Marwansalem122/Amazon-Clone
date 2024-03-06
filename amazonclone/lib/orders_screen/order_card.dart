import 'package:amazonclone/models/items.dart';
import 'package:amazonclone/orders_screen/order_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class OrderCard extends StatefulWidget {
  int? itemCount;
  List<DocumentSnapshot>? data;
  String? orderID;
  List<String>? seperateQuantitiesList;

  OrderCard(
      {super.key,
      required this.itemCount,
      required this.data,
      required this.orderID,
      required this.seperateQuantitiesList});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => OrderDetailsScreen(
                  orderID: widget.orderID,
                )));
      },
      child: Card(
        color: Colors.black,
        shadowColor: Colors.white54,
        elevation: 10,
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          height: widget.itemCount! * 125,
          child: ListView.builder(
              itemCount: widget.itemCount,
              itemBuilder: (context, index) {
                Items model = Items.fromJson(
                    widget.data![index].data() as Map<String, dynamic>);
                return placeOrersItemsDesignWidget(
                    model, context, widget.seperateQuantitiesList![index]);
              }),
        ),
      ),
    );
  }
}

Widget placeOrersItemsDesignWidget(
    Items items, BuildContext context, itemQuantity) {
  return Container(
    padding: const EdgeInsets.all(8),
    width: MediaQuery.of(context).size.width,
    height: 120.h,
    color: Colors.transparent,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            items.itemImage!,
            width: 120.w,
          ),
        ),
        SizedBox(
          width: 10.w,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      items.itemTitle.toString(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16.sp,
                          overflow: TextOverflow.clip),
                    ),
                  ),
                  Text("\$",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 16.sp,
                      )),
                  Text(
                    items.itemPrice!,
                    style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 16.sp,
                        overflow: TextOverflow.clip),
                  ),
                ],
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                children: [
                  Text("X",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 16.sp,
                      )),
                  Text(
                    itemQuantity,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 28.sp,
                        overflow: TextOverflow.clip),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );
}
