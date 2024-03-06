import 'package:flutter/material.dart';
import 'package:sellers_app/global/global.dart';

import 'package:sellers_app/models/brands.dart';
import 'package:sellers_app/models/items.dart';
import 'package:sellers_app/screens/itemsScreen/item_ui_widget.dart';
import 'package:sellers_app/screens/itemsScreen/uploaditem_screen.dart';
import 'package:sellers_app/screens/widgets/common_widgets.dart';
import 'package:sellers_app/screens/widgets/textDelegate_header.dart';
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
      appBar: AppBar(
        flexibleSpace: commonContainer(child: Container()),
        title: const Text("iShop"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UploadItemsScreen(
                      model: widget.model,
                    ))),
            icon: const Icon(Icons.add),
            tooltip: "add New item to your brand",
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TextDelegateHeader(
                  title: "My ${widget.model!.brandTitle}'s items")),
          //write a Query
          //model
          //design widget
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(sharedPreferences!.getString("uid"))
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
