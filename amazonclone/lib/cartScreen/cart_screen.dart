import 'package:amazonclone/assistant_method/cart_item_counter.dart';
import 'package:amazonclone/sellers_screens/splashview/splashview_page.dart';
import 'package:amazonclone/sellers_screens/widgets/appbar_cart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amazonclone/global/global.dart';
import 'package:amazonclone/models/items.dart';
import 'package:amazonclone/cartScreen/cart_item_design_ui.dart';
import 'package:provider/provider.dart';
import 'package:amazonclone/assistant_method/total_ammount.dart';
import 'package:amazonclone/address_screen/address_screen.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  String? sellerUId;
  CartScreen({super.key, required this.sellerUId});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalAmount = 0.0;
  List<int>? itemQuantitiesList;
  @override
  void initState() {
    super.initState();
    itemQuantitiesList = cartMethods.separateItemsQuantitiesFromUserCartList();
    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false)
        .showTotalAmountOfCartItem(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBarWithCartBadge(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 30.w,
          ),
          FloatingActionButton.extended(
              onPressed: () {
                cartMethods.clearCart(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const MySplashScreen()));
              },
              heroTag: "bt1",
              icon: const Icon(Icons.clear),
              label: Text(
                "Clear Cart",
                style: TextStyle(fontSize: 17.sp),
              )),
          SizedBox(
            width: 25.w,
          ),
          FloatingActionButton.extended(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddressScreen(
                        sellerId: widget.sellerUId, totalAmount: totalAmount)));
              },
              heroTag: "bt2",
              icon: const Icon(Icons.clear),
              label: Text(
                "Check Out",
                style: TextStyle(fontSize: 17.sp),
              )),
        ],
      ),
      body: CustomScrollView(slivers: [
        //  SliverPersistentHeader(
        //         pinned: true,
        //         delegate: TextDelegateHeader(
        //             title: "${widget.model!.brandTitle}'s items")),
        SliverToBoxAdapter(child: Consumer2<TotalAmount, CartItemCounter>(
          builder: (context, amountProvider, cartProvider, c) {
            return Center(
              child: cartProvider.count == 0
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text(
                        "Total Price : ${amountProvider.tAmount}",
                        style: const TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            );
          },
        )),
        //write a Query
        //model
        //design widget
        StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where("itemId",
                    whereIn: cartMethods.separateItemIDsFromUserCartList())
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: ((context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) {
                //Data Exist

                //display
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 2.4),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Items model = Items.fromJson(
                        dataSnapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );
                      if (index == 0) {
                        totalAmount = 0;
                        totalAmount += (double.parse(model.itemPrice!) *
                            itemQuantitiesList![index]);
                      } else {
                        totalAmount += (double.parse(model.itemPrice!) *
                            itemQuantitiesList![index]);
                      }
                      if (dataSnapshot.data.docs.length - 1 == index) {
                        WidgetsBinding.instance
                            .addPostFrameCallback((timeStamp) {
                          Provider.of<TotalAmount>(context, listen: false)
                              .showTotalAmountOfCartItem(totalAmount);
                        });
                      }

                      return CartItemDesignUi(
                        model: model,
                        quantityNumber: itemQuantitiesList![index],
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
      ]),
    );
  }
}
