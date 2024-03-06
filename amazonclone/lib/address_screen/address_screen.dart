import 'package:flutter/material.dart';
import 'package:amazonclone/sellers_screens/widgets/common_widgets.dart';
import 'package:amazonclone/address_screen/save_new_address_screen.dart';
import 'package:provider/provider.dart';
import 'package:amazonclone/assistant_method/address_changeer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amazonclone/global/global.dart';
import 'package:amazonclone/models/address.dart';
import 'package:amazonclone/address_screen/address_Design_Ui.dart';

// ignore: must_be_immutable
class AddressScreen extends StatefulWidget {
  String? sellerId;
  double? totalAmount;
  AddressScreen({
    Key? key,
    required this.sellerId,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: commonContainer(child: Container()),
          title: const Text("iShop"),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SaveNewAddressScreen(
                    sellerId: widget.sellerId,
                    totalAmount: widget.totalAmount)));
          },
          label: const Text("Add New Address"),
          icon: const Icon(Icons.add_location_sharp),
        ),
        body: Consumer<AddressChanger>(builder: (context, address, c) {
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(sharedPreferences!.getString("uid"))
                  .collection("userAddress")
                  .snapshots(),
              builder: ((context, AsyncSnapshot dataSnapshot) {
                if (dataSnapshot.hasData) {
                  //Data Exist

                  //display brands
                  /*here i controll of the card that hold image and title with childAspectRatio
                  that is make me controll with height
                     */
                  if (dataSnapshot.data.docs.length > 0) {
                    return ListView.builder(
                      itemCount: dataSnapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return AddressDesignUiWidget(
                            addressModel: Address.fromJson(
                              dataSnapshot.data!.docs[index].data()
                                  as Map<String, dynamic>,
                            ),
                            sellerUid: widget.sellerId,
                            value: index,
                            index: address.count,
                            addressId: dataSnapshot.data.docs[index].id,
                            totalAmount: widget.totalAmount);
                      },
                    );
                  } else {
                    return Container();
                  }
                } else {
                  //no data exist
                  return const Center(
                    child: Text("No Brands Exist"),
                  );
                }
              }));
        }));
  }
}
