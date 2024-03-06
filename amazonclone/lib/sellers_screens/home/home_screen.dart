import 'package:amazonclone/common/utils/const.dart';
import 'package:amazonclone/global/global.dart';
import 'package:amazonclone/models/sellers.dart';
import 'package:amazonclone/sellers_screens/home/sellers_ui_Design_widget.dart';
import 'package:amazonclone/sellers_screens/widgets/drawer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartMethods.clearCart(context);
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
      ),
      drawer: const MyDrawar(),
      body: CustomScrollView(slivers: [
        //image sliders
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(10.h),
            child: SizedBox(
              height: height * 0.3,
              width: width,
              child: CarouselSlider(
                  items: sliderImages
                      .map((index) => Builder(builder: (context) {
                            return Container(
                              width: width,
                              margin: EdgeInsets.symmetric(horizontal: 1.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(40),
                                child: Image.asset(
                                  index,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            );
                          }))
                      .toList(),
                  options: CarouselOptions(
                    height: height * 0.9,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  )),
            ),
          ),
        ),
        StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection("sellers").snapshots(),
            builder: ((context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) {
                //Data Exist

                //display brands
                /*here i controll of the card that hold image and title with childAspectRatio
                  that is make me controll with height
                     */
                return SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 1.3),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Sellers model = Sellers.fromJson(
                        dataSnapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );

                      return SellersUiDesignWidget(
                        sellerModel: model,
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
