import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/screens/brands/upload_brands_screen.dart';
import 'package:sellers_app/screens/widgets/drawer.dart';
import 'package:sellers_app/screens/widgets/textDelegate_header.dart';
import 'package:sellers_app/models/brands.dart';
import 'package:sellers_app/screens/brands/brands_ui_widget.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UploadBrandsScreen()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      drawer: const MyDrawar(),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true, delegate: TextDelegateHeader(title: "My Brands")),

          //write a Query
          //model
          //design widget

          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("sellers")
                  .doc(sharedPreferences!.getString("uid"))
                  .collection("brands")
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
                            crossAxisCount: 1, childAspectRatio: 1.16),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        Brands model = Brands.fromJson(
                          dataSnapshot.data!.docs[index].data()
                              as Map<String, dynamic>,
                        );

                        return BrandUiDesignWidget(
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
