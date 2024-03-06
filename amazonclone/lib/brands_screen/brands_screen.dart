import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:amazonclone/brands_screen/brands_ui_widget.dart';
import 'package:amazonclone/models/brands.dart';
import 'package:amazonclone/models/sellers.dart';
import 'package:amazonclone/sellers_screens/widgets/drawer.dart';
import 'package:amazonclone/sellers_screens/widgets/textDelegate_header.dart';

// ignore: must_be_immutable
class BrandsScreen extends StatefulWidget {
  Sellers? sellerMode;
  BrandsScreen({
    Key? key,
    required this.sellerMode,
  }) : super(key: key);

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.pink, Colors.purple],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp)),
        ),
        title: const Text("iShop"),
        automaticallyImplyLeading: true,
      ),
      drawer: const MyDrawar(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TextDelegateHeader(
                  title: "${widget.sellerMode!.name} Brand")),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(widget.sellerMode!.sellerId)
                  .collection("brands")
                  .orderBy("publishedDate", descending: true)
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
                            crossAxisCount: 1, childAspectRatio: 1.4),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        Brands model = Brands.fromJson(
                          dataSnapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                        );

                        return BrandUiDesignWidget(
                          model: model,
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
