import 'package:amazonclone/common/widgets/flutter_toast.dart';
import 'package:amazonclone/global/global.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:amazonclone/sellers_screens/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:amazonclone/sellers_screens/widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class SaveNewAddressScreen extends StatefulWidget {
  String? sellerId;
  double? totalAmount;
  SaveNewAddressScreen({
    Key? key,
    this.sellerId,
    this.totalAmount,
  }) : super(key: key);

  @override
  State<SaveNewAddressScreen> createState() => _SaveNewAddressScreenState();
}

class _SaveNewAddressScreenState extends State<SaveNewAddressScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController streetNumber = TextEditingController();
  TextEditingController flatHouseNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController stateCountry = TextEditingController();
  String completeAddress = "";
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: "Addresskey");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          flexibleSpace: commonContainer(child: Container()),
          title: const Text("iShop"),
          automaticallyImplyLeading: true,
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              completeAddress =
                  "${streetNumber.text.trim()}, ${flatHouseNumber.text.trim()}, ${city.text.trim()}, ${stateCountry.text.trim()}.";

              FirebaseFirestore.instance
                  .collection("users")
                  .doc(sharedPreferences!.getString("uid"))
                  .collection("userAddress")
                  .doc(DateTime.now().millisecondsSinceEpoch.toString())
                  .set({
                "name": name.text.trim(),
                "phoneNumber": phoneNumber.text.trim(),
                "streetNumber": streetNumber.text.trim(),
                "flatHouseNumber": flatHouseNumber.text.trim(),
                "city": city.text.trim(),
                "stateCountry": stateCountry.text.trim(),
                "completeAddress": completeAddress,
              }).then((value) {
                toastInfo(msg: "New Shipment Address has been saved.");
                formKey.currentState!.reset();
              });
            }
          },
          label: const Text("Save"),
          icon: const Icon(Icons.save),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text("Save New Address",
                style: TextStyle(fontSize: 22.sp, color: Colors.grey)),
          ),
          Form(
              key: formKey,
              child: Column(children: [
                CustomTextFormField(
                  valider: (value) =>
                      value!.isEmpty ? "Field Can't be Empty" : null,
                  hintText: 'name',
                  controller: name,
                  issecurse: false,
                  icon: Icons.person,
                  enable: true,
                  typefield: 'name',
                ),
                CustomTextFormField(
                  valider: (value) =>
                      value!.isEmpty ? "Field Can't be Empty" : null,
                  hintText: 'Phone Number',
                  controller: phoneNumber,
                  issecurse: false,
                  icon: Icons.phone,
                  enable: true,
                  typefield: 'phone',
                ),
                CustomTextFormField(
                  valider: (value) =>
                      value!.isEmpty ? "Field Can't be Empty" : null,
                  hintText: 'stateCountry',
                  controller: stateCountry,
                  issecurse: false,
                  icon: Icons.flag,
                  enable: true,
                  typefield: 'stateCountry',
                ),
                CustomTextFormField(
                  valider: (value) =>
                      value!.isEmpty ? "Field Can't be Empty" : null,
                  hintText: 'city',
                  controller: city,
                  issecurse: false,
                  icon: Icons.location_on,
                  enable: true,
                  typefield: 'city',
                ),
                CustomTextFormField(
                  valider: (value) =>
                      value!.isEmpty ? "Field Can't be Empty" : null,
                  hintText: 'Street',
                  controller: streetNumber,
                  issecurse: false,
                  icon: Icons.streetview,
                  enable: true,
                  typefield: 'street',
                ),
                CustomTextFormField(
                  valider: (value) =>
                      value!.isEmpty ? "Field Can't be Empty" : null,
                  hintText: 'HouseNumber',
                  controller: flatHouseNumber,
                  issecurse: false,
                  icon: Icons.house,
                  enable: true,
                  typefield: 'flatHouseNumber',
                ),
              ]))
        ])));
  }
}
