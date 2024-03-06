import 'package:amazonclone/place_order_screen/place_order_screen.dart';
import 'package:flutter/material.dart';

import 'package:amazonclone/models/address.dart';
import 'package:provider/provider.dart';
import 'package:amazonclone/assistant_method/address_changeer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amazonclone/common/widgets/custom_Elevated_button.dart';

// ignore: must_be_immutable
class AddressDesignUiWidget extends StatefulWidget {
  Address? addressModel;
  String? sellerUid;
  double? totalAmount;
  String? addressId;
  int? value;
  int? index;

  AddressDesignUiWidget({
    Key? key,
    required this.sellerUid,
    required this.totalAmount,
    required this.addressId,
    required this.addressModel,
    required this.value,
    required this.index,
  }) : super(key: key);

  @override
  State<AddressDesignUiWidget> createState() => _AddressDesignUiWidgetState();
}

class _AddressDesignUiWidgetState extends State<AddressDesignUiWidget> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Card(
        color: Colors.black,
        child: Column(
          children: [
            //address Info
            Row(
              children: [
                Radio(
                    value: widget.value,
                    groupValue: widget.index,
                    activeColor: Colors.pink,
                    onChanged: (val) {
                      Provider.of<AddressChanger>(context, listen: false)
                          .showSelectedAddress(val!);
                    }),
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(10),
                        width: width * 0.8,
                        child: Table(
                          children: [
                            TableRow(children: [
                              const Text(
                                "Name",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.addressModel!.name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ]),
                            TableRow(children: [
                              SizedBox(height: 10.h),
                              SizedBox(height: 10.h),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Phone Number",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.addressModel!.phoneNumber!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ]),
                            TableRow(children: [
                              SizedBox(height: 10.h),
                              SizedBox(height: 10.h),
                            ]),
                            TableRow(children: [
                              const Text(
                                "Full Address",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.addressModel!.completeAddress!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                            TableRow(children: [
                              SizedBox(height: 10.h),
                              SizedBox(height: 10.h),
                            ]),
                          ],
                        ))
                  ],
                )
              ],
            ),
            //button
            widget.value ==
                    Provider.of<AddressChanger>(context, listen: false).count
                ? CustomElevatedButton(
                    textcolor: Colors.white,
                    text: "Procceed",
                    buttonWidth: 108.w,
                    onpressed: () {
                      //send user to place order screen finally
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PlaceOrderScreen(
                                addressId: widget.addressId,
                                totalAmount: widget.totalAmount,
                                sellerUid: widget.sellerUid,
                              )));
                    },
                    color: Colors.pink,
                    buttonheight: 40.h,
                  )
                : Container()
          ],
        ));
  }
}
