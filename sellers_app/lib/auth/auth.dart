import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sellers_app/common/widgets/flutter_toast.dart';
import 'package:sellers_app/global/global.dart';

class AuthHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  Future<void> signUp(
      String email,
      String password,
      BuildContext context,
      String name,
      String downloadUrlImage,
      String phone,
      String address) async {
    // ignore: unused_local_variable
    User? currentUser;
    await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((auth) async {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      toastInfo(msg: "Error Ocuured:n$errorMessage");
    });
    if (currentUser != null) {
      //save info to Database & locally
      // ignore: use_build_context_synchronously
      saveInfoToFirebaseAndLocally(
          currentUser!, name, context, downloadUrlImage, phone, address);

      // Send email verification
      await currentUser?.sendEmailVerification();
      await currentUser?.updateDisplayName(name);
      toastInfo(
          msg:
              "An email has been sent to your registered email to active Check your email box and click on the link");
      await currentUser!.reload();
      if (currentUser!.emailVerified) {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushNamedAndRemoveUntil("splashview", (route) => false);
      } else {
        toastInfo(msg: "Please verify your email before accessing the app.");
      }
    }
  }

  saveInfoToFirebaseAndLocally(
      User currentUser,
      String name,
      BuildContext context,
      String downloadUrlImage,
      String phone,
      String address) async {
    //to fireStore
    FirebaseFirestore.instance.collection("sellers").doc(currentUser.uid).set({
      "uid": currentUser.uid,
      "email": currentUser.email,
      "name": name,
      "photoUrl": downloadUrlImage,
      "phon": phone,
      "location": address,
      "status": "approved",
      "earnings": 0.0
    });
    //to save locally
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString("uid", currentUser.uid);
    sharedPreferences!.setString("email", currentUser.email!);
    sharedPreferences!.setString("name", name);
    sharedPreferences!.setString("photoUrl", downloadUrlImage);
    // ignore: use_build_context_synchronously
    Navigator.of(context)
        .pushNamedAndRemoveUntil("splashview", (route) => false);
  }
  // Add more authentication methods as needed

  // For example, a login method
  Future<void> signIn(
      String email, String password, BuildContext context) async {
    User? currentUser;
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((auth) async {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      toastInfo(msg: "Error Ocuured:n$errorMessage");
    });
    if (currentUser != null) {
      // ignore: use_build_context_synchronously
      checkIfSellerRecordsExist(currentUser!, context);
    }
  }

  checkIfSellerRecordsExist(User currentUser, BuildContext context) async {
    print("--------------------------------");
    print("check");
    print("--------------------------------");
    await FirebaseFirestore.instance
        .collection("sellers")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) {
        print("--------------------------------");
        print("Exist");
        print("--------------------------------");
        if (currentUser.emailVerified) {
          //check is status approved
          if (record.data()!["status"] == "approved") {
            // sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences!.setString("uid", record.data()!["uid"]);
            sharedPreferences!.setString("email", record.data()!["email"]);
            sharedPreferences!.setString("name", record.data()!["name"]);
            sharedPreferences!
                .setString("photoUrl", record.data()!["photoUrl"]);

            //send seller to Home

            // ignore: use_build_context_synchronously
            Navigator.of(context)
                .pushNamedAndRemoveUntil("splashview", (route) => false);
          } else {
            FirebaseAuth.instance.signOut();
            Navigator.pop(context);
            toastInfo(
                msg:
                    "you have BLOCKED by admin.\ncontact Admin: admin@ishop.com");
          }
        } else {
          toastInfo(msg: "Please vertified account from email");
        }
      } else {
        _auth.signOut();
        Navigator.pop(context);
        toastInfo(msg: "This seller's record don't Exist");
      }
    });
  }

  Future<String?> uploadImage(String namefolderimage, File imageFile) async {
    // ignore: unused_local_variable
    String downloadUrlImage = "";

    //to given a unique name
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
        .ref()
        .child(namefolderimage)
        .child(fileName);
    fStorage.UploadTask uploadImageTask = storageRef.putFile(imageFile);

    fStorage.TaskSnapshot tasksnapshot =
        await uploadImageTask.whenComplete(() {});
    await tasksnapshot.ref.getDownloadURL().then((urlImage) {
      downloadUrlImage = urlImage;
      // print("==================================");
      // print(downloadUrlImage);
      // print("==================================");
    });
    return downloadUrlImage;
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      // Show a success message or navigate to a success screen
      toastInfo(msg: "Password reset email sent successfully");
    } catch (error) {
      // Handle errors such as invalid email, user not found, etc.
      toastInfo(msg: "Error sending password reset email: $error");
    }
  }

  Future<void> signout() async {
    await _auth.signOut();
  }
}
