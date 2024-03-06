import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_app/auth/auth.dart';
import 'package:sellers_app/common/widgets/custom_Elevated_button.dart';
import 'package:sellers_app/screens/splashScreen/splashview_page.dart';
import 'package:sellers_app/screens/widgets/common_widgets.dart';

import '../../common/widgets/flutter_toast.dart';
import 'package:sellers_app/screens/widgets/prograss_bar.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/screens/home/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadBrandsScreen extends StatefulWidget {
  const UploadBrandsScreen({super.key});

  @override
  State<UploadBrandsScreen> createState() => _UploadBrandsScreenState();
}

class _UploadBrandsScreenState extends State<UploadBrandsScreen> {
  final ImagePicker picker = ImagePicker();
  File? image;
  TextEditingController brandInfoController = TextEditingController();
  TextEditingController brandTitleController = TextEditingController();
  final AuthHelper _auth = AuthHelper();
  // ignore: prefer_typing_uninitialized_variables
  var downloadImageUrl;
  String brandUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: '_uploadNewBrandScreenkey');
  bool uploading = false;
  saveBrandInfo() {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("brands")
        .doc(brandUniqueId)
        .set({
      "brandId": brandUniqueId,
      "sellerId": sharedPreferences!.getString("uid"),
      "brandInfo": brandInfoController.text.trim(),
      "brandTitle": brandTitleController.text.trim(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "brandImage": downloadImageUrl
    });
    setState(() {
      uploading = false;
      brandUniqueId = DateTime.now().millisecondsSinceEpoch.toString();
    });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomeScreens()));
  }

  validateUploadForm() async {
    //image not selected
    if (image != null) {
      if (brandInfoController.text.isNotEmpty &&
          brandTitleController.text.isNotEmpty) {
        setState(() {
          uploading = true;
        });
        //Upload image
        downloadImageUrl =
            await _auth.uploadImage("SellersBrandImages", image!);

        //save Info to fireStore
        saveBrandInfo();
        print("done=======================================");
      } else {
        toastInfo(msg: "Please Write the Brand Info and Brand Title");
      }
    } else {
      toastInfo(msg: "Please Select an image for your Brand");
    }
  }

  uploadFormScreen() {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: commonContainer(child: Container()),
        title: resuableText(
            text: "Upload New Brand",
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
              title: _textFormField(width, "Brand Info", brandInfoController),
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
              title: _textFormField(width, "Brand Title", brandTitleController),
            ),
            Divider(
              color: Colors.pinkAccent,
              thickness: 1.h,
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
            text: "Add New Brand",
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
                Icons.add_photo_alternate_outlined,
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
              "Brand Image",
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
