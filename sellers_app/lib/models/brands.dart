import 'package:cloud_firestore/cloud_firestore.dart';

class Brands {
  String? brandId;
  String? brandImage;
  String? brandInfo;
  String? brandTitle;
  Timestamp? publishedDate;
  String? sellerId;
  String? status;
  Brands.fromJson(Map<String, dynamic> json) {
    brandId = json["brandId"];
    brandImage = json["brandImage"];
    brandInfo = json["brandInfo"];
    brandTitle = json["brandTitle"];
    publishedDate = json["publishedDate"];
    sellerId = json["sellerId"];
    status = json["status"];
  }
}
