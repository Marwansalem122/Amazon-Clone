import 'package:amazonclone/models/brands.dart';
import 'package:amazonclone/models/items.dart';
import 'package:amazonclone/sellers_screens/items_Screen/item_ui_widget.dart';
import 'package:amazonclone/sellers_screens/widgets/common_widgets.dart';
import 'package:amazonclone/sellers_screens/widgets/textDelegate_header.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ItemScreen extends StatefulWidget {
  Brands? model;
  ItemScreen({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: commonContainer(child: Container()),
        title: const Text("iShop"),
        automaticallyImplyLeading: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TextDelegateHeader(
                  title: "${widget.model!.brandTitle}'s items")),
          //write a Query
          //model
          //design widget
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.model!.sellerId)
                  .collection("brands")
                  .doc(widget.model!.brandId)
                  .collection("items")
                  .orderBy("publishedDate",
                      descending: true) //to appear product from new to old
                  .snapshots(),
              builder: ((context, AsyncSnapshot dataSnapshot) {
                if (dataSnapshot.hasData) {
                  //Data Exist

                  //display brands
                  /*here i controll of the card that hold image and title with childAspectRatio
                  that is make me controll with height
                     */
                  return SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1, childAspectRatio: 0.98),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        Items model = Items.fromJson(
                          dataSnapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                        );

                        return ItemUiDesignWidget(
                          model: model,
                          context: context,
                        );
                      },
                      childCount: dataSnapshot.data.docs.length,
                    ),
                  );
                } else {
                  //no data exist
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text("No Brands Exist"),
                    ),
                  );
                }
              }))
        ],
      ),
    );
  }
}
