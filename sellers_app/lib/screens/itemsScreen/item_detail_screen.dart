import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/models/items.dart';
import 'package:sellers_app/screens/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellers_app/common/widgets/flutter_toast.dart';
import 'package:sellers_app/screens/home/home_screen.dart';

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
  deleteItem() {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("brands")
        .doc(widget.itemModel!.brandId)
        .collection("items")
        .doc(widget.itemModel!.itemId)
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection("items")
          .doc(widget.itemModel!.itemId)
          .delete();
    });
    toastInfo(msg: "Item has been Deleted Successfully");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeScreens()));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: commonContainer(child: Container()),
        title: Text(widget.itemModel!.itemTitle!),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          deleteItem();
        },
        label: const Text("Delete This item"),
        icon: const Icon(Icons.delete_sweep_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.network(
            widget.itemModel!.itemImage!,
            fit: BoxFit.fill,
            height: 200.h,
            width: width,
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(width * 0.04),
            child: Text(
              widget.itemModel!.itemDescription!,
              textAlign: TextAlign.justify,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15.sp),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: width * 0.04, left: width * 0.04),
            child: RichText(
              text: TextSpan(children: [
                const TextSpan(
                  text: 'Price: ',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: "${widget.itemModel!.itemPrice!}\$",
                  style: const TextStyle(
                      color: Colors.pinkAccent, fontWeight: FontWeight.bold),
                ),
              ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: width * 0.04, top: width * 0.04, right: width * 0.72),
            child: Divider(
              height: 1.h,
              thickness: 2,
              color: Colors.pink,
            ),
          )
        ]),
      ),
    );
  }
}
