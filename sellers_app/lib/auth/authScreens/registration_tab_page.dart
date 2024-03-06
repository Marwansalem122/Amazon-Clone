import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../screens/widgets/custom_text_form_field.dart';
import 'package:sellers_app/common/widgets/flutter_toast.dart';
import 'package:sellers_app/common/widgets/loading_dialog.dart';
import 'package:sellers_app/common/widgets/custom_Elevated_button.dart';
import 'package:sellers_app/auth/auth.dart';

class RegistrationTabScreen extends StatefulWidget {
  const RegistrationTabScreen({super.key});

  @override
  State<RegistrationTabScreen> createState() => _RegistrationTabScreenState();
}

class _RegistrationTabScreenState extends State<RegistrationTabScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  final GlobalKey<FormState> formkey1 = GlobalKey<FormState>(debugLabel: '_signupScreenkey');
  final ImagePicker picker = ImagePicker();
  File? image;
  final AuthHelper _auth = AuthHelper();
  var downloadUrlImage;
  uploadImagefromCameraorGallary(ImageSource source) async {
    var pickedimage = await picker.pickImage(source: source);
    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
      });
    }
  }

  dynamic openBottomSheet(BuildContext context) {
    return showAdaptiveActionSheet(
      bottomSheetColor: const Color.fromARGB(255, 153, 55, 140),
      context: context,
      androidBorderRadius: 30,
      actions: <BottomSheetAction>[
        BottomSheetAction(
            title: const Text('Camera'),
            onPressed: (context) {
              uploadImagefromCameraorGallary(ImageSource.camera);
            }),
        BottomSheetAction(
            title: const Text('Gallery'),
            onPressed: (context) {
              uploadImagefromCameraorGallary(ImageSource.gallery);
            }),
      ],
      cancelAction: CancelAction(
          title: const Text(
              'Cancel')), // onPressed parameter is optional by default will dismiss the ActionSheet
    );
  }

  fromValidation() async {
    //image not selected
    if (image == null) {
      toastInfo(msg: "Please Select an image");
    } else {
      //password not equal confirm password
      if (passwordController.text != confirmPasswordController.text) {
        toastInfo(msg: "Password isn't equal Confirm-Password");
      } else {
        //check email & name
        if (nameController.text.isNotEmpty &&
            emailController.text.isNotEmpty &&
            passwordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty &&
            phoneController.text.isNotEmpty &&
            locationController.text.isNotEmpty) {
          showDialog(
              context: context,
              builder: (context) {
                return const LoadingDialog(message: "Registering your account");
              });
          //Upload image
          downloadUrlImage = await _auth.uploadImage("sellersImages", image!);
          //save user Info
          // ignore: use_build_context_synchronously
          _auth.signUp(
              emailController.text.trim(),
              passwordController.text.trim(),
              context,
              nameController.text.trim(),
              downloadUrlImage,
              phoneController.text.trim(),
              locationController.text.trim());
        } else {
          Navigator.pop(context);
          toastInfo(msg: "Please Complete the Form");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.03,
          ),
          //get image from camera
          GestureDetector(
            onTap: () => openBottomSheet(context),
            child: CircleAvatar(
              radius: width * 0.2,
              backgroundColor: Colors.white,
              backgroundImage: image == null
                  ? null
                  : FileImage(
                      image!,
                    ),
              child: image == null
                  ? Icon(
                      Icons.add_photo_alternate,
                      color: Colors.grey,
                      size: width * .2,
                    )
                  : null,
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Form(
            key: formkey1,
            child: Column(children: [
              CustomTextFormField(
                hintText: 'Enter your name',
                controller: nameController,
                icon: Icons.person,
                enable: true,
                typefield: 'name',
                issecurse: false,
              ),
              CustomTextFormField(
                hintText: 'Enter your email',
                controller: emailController,
                icon: Icons.email,
                enable: true,
                issecurse: false,
                typefield: 'email',
              ),
              CustomTextFormField(
                hintText: 'Enter your Password',
                controller: passwordController,
                icon: Icons.lock,
                enable: true,
                issecurse: true,
                typefield: 'password',
              ),
              CustomTextFormField(
                hintText: 'Enter your confirm-password',
                controller: confirmPasswordController,
                icon: Icons.lock,
                enable: true,
                issecurse: true,
                typefield: 'password',
              ),
              CustomTextFormField(
                hintText: 'Enter your Phone',
                controller: phoneController,
                icon: Icons.phone,
                enable: true,
                issecurse: false,
                typefield: 'phone',
              ),
              CustomTextFormField(
                hintText: 'Enter your Location',
                controller: locationController,
                icon: Icons.location_on,
                enable: true,
                issecurse: false,
                typefield: 'location',
              ),
            ]),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomElevatedButton(
            text: "SignUp",
            buttonWidth: 150,
            buttonheight: 40,
            onpressed: () => fromValidation(),
            color: Colors.purple,
            textcolor: Colors.white,
          ),
          SizedBox(
            height: height * 0.04,
          ),
        ],
      ),
    );
  }
}
