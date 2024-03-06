import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_app/auth/auth.dart';
import 'package:sellers_app/common/widgets/custom_Elevated_button.dart';
import 'package:sellers_app/models/brands.dart';
import 'package:sellers_app/screens/splashScreen/splashview_page.dart';
import 'package:sellers_app/screens/widgets/common_widgets.dart';

import '../../common/widgets/flutter_toast.dart';
import 'package:sellers_app/screens/widgets/prograss_bar.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class UploadItemsScreen extends StatefulWidget {
  Brands? model;
  UploadItemsScreen({super.key, required this.model});

  @override
  State<UploadItemsScreen> createState() => _UploadItemsScreenState();
}

class _UploadItemsScreenState extends State<UploadItemsScreen> {
  final ImagePicker picker = ImagePicker();
  File? image;
  TextEditingController itemInfoController = TextEditingController();
  TextEditingController itemTitleController = TextEditingController();
  TextEditingController itemDescriptionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  final AuthHelper _auth = AuthHelper();
  // ignore: prefer_typing_uninitialized_variables
  var downloadImageUrl;
  String itemUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: '_uploadNewBrandScreenkey');
  bool uploading = false;
  saveBrandInfo() {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("brands")
        .doc(widget.model!.brandId)
        .collection("items")
        .doc(itemUniqueId)
        .set({
      "itemId": itemUniqueId,
      "brandId": widget.model!.brandId,
      "sellerId": sharedPreferences!.getString("uid"),
      "sellerName": sharedPreferences!.getString("name"),
      "itemInfo": itemInfoController.text.trim(),
      "itemTitle": itemTitleController.text.trim(),
      "itemDescription": itemDescriptionController.text.trim(),
      "itemPrice": itemPriceController.text.trim(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "itemImage": downloadImageUrl
    }).then((value) {
      FirebaseFirestore.instance.collection("items").doc(itemUniqueId).set({
        "itemId": itemUniqueId,
        "brandId": widget.model!.brandId,
        "sellerId": sharedPreferences!.getString("uid"),
        "sellerName": sharedPreferences!.getString("name"),
        "itemInfo": itemInfoController.text.trim(),
        "itemTitle": itemTitleController.text.trim(),
        "itemDescription": itemDescriptionController.text.trim(),
        "itemPrice": itemPriceController.text.trim(),
        "publishedDate": DateTime.now(),
        "status": "available",
        "itemImage": downloadImageUrl
      });
    });
    setState(() {
      uploading = false;
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeScreens()));
  }

  validateUploadForm() async {
    //image not selected
    if (image != null) {
      if (itemInfoController.text.isNotEmpty &&
          itemTitleController.text.isNotEmpty &&
          itemDescriptionController.text.isNotEmpty &&
          itemPriceController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });
        //Upload image
        downloadImageUrl =
            await _auth.uploadImage("SellersItemsImages", image!);

        //save Info to fireStore
        saveBrandInfo();
        print("done=======================================");
      } else {
        toastInfo(msg: "Please Write the Item Info and Item Title");
      }
    } else {
      toastInfo(msg: "Please Select an image for your Item");
    }
  }

  uploadFormScreen() {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: commonContainer(child: Container()),
        title: resuableText(
            text: "Upload New Item",
            fontsize: 20.sp,
            letterspacing: 1,
            color: Colors.white,
            fontweight: FontWeight.bold),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MySplashScreen()));
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
                onPressed: () => uploading
                    ? null
                    : validateUploadForm(), // Validate Upload Form

                icon: const Icon(
                  Icons.cloud_upload,
                )),
          )
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            uploading ? linearPrograssBar() : Container(),
            SizedBox(
              height: 230,
              width: width * 0.8,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: FileImage(image!))),
                ),
              ),
            ),
            Divider(
              color: Colors.pinkAccent,
              thickness: 1.h,
            ),
            //brand Info
            ListTile(
              leading: const Icon(
                Icons.perm_device_information,
                color: Colors.deepPurple,
              ),
              title: _textFormField(width, "Item Info", itemInfoController),
            ),
            Divider(
              color: Colors.pinkAccent,
              thickness: 1.h,
            ),
            //brand title
            ListTile(
              leading: const Icon(
                Icons.title,
                color: Colors.deepPurple,
              ),
              title: _textFormField(width, "Item Title", itemTitleController),
            ),
            Divider(
              color: Colors.pinkAccent,
              thickness: 1.h,
            ),
            //Description
            ListTile(
              leading: const Icon(
                Icons.description,
                color: Colors.deepPurple,
              ),
              title: _textFormField(
                  width, "Item Description", itemDescriptionController),
            ),
            Divider(
              color: Colors.pinkAccent,
              thickness: 1.h,
            ),
            //Price
            ListTile(
              leading: const Icon(
                Icons.attach_money,
                color: Colors.deepPurple,
              ),
              title: _textFormField(width, "Item Price", itemPriceController),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textFormField(
      double width, String hinttext, TextEditingController controller) {
    return SizedBox(
      width: width * 0.6,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hinttext,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return image == null ? defaultScreen() : uploadFormScreen();
  }

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: commonContainer(child: Container()),
        title: resuableText(
            text: "Add New Item",
            fontsize: 20.sp,
            letterspacing: 1,
            color: Colors.white,
            fontweight: FontWeight.bold),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.pink, Colors.purple],
                begin: FractionalOffset(0.0, 0.0),
                end: FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_photo_alternate,
                color: Colors.white,
                size: 200.h,
              ),
              SizedBox(
                height: 150.h,
              ),
              CustomElevatedButton(
                  text: "Add New Brand",
                  buttonWidth: 180.w,
                  buttonheight: 50.h,
                  onpressed: () => obtainImageDialogBox(),
                  color: Colors.purple,
                  textcolor: Colors.white)
            ],
          ),
        ),
      ),
    );
  }

  obtainImageDialogBox() {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: Colors.purple,
            title: const Text(
              "Item Image",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  uploadImagefromCameraorGallary(ImageSource.camera);
                },
                child: const Text(
                  "Capture image with Camera",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  uploadImagefromCameraorGallary(ImageSource.gallery);
                },
                child: const Text(
                  "Select image from Gallery",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {},
                child: const Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }

  uploadImagefromCameraorGallary(ImageSource source) async {
    var pickedimage = await picker.pickImage(source: source);
    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
        Navigator.pop(context);
      });
    }
  }
}
