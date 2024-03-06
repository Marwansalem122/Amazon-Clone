import 'package:cloud_firestore/cloud_firestore.dart';

class Items{
String? brandId;
String? itemId;
String? itemInfo;
String? itemTitle;
String? itemDescription;
String? itemImage;
Timestamp? publishedDate;
String? itemPrice;
String? sellerName;
String? sellerId;
String? status;

Items.fromJson(Map<String,dynamic>json){
 brandId=json["brandId"];
 itemId=json["itemId"];
 itemInfo=json["itemInfo"];
 itemTitle=json["itemTitle"];
 itemDescription=json["itemDescription"];
 itemImage=json["itemImage"];
 publishedDate=json["publishedDate"];
 itemPrice=json["itemPrice"];
 sellerName=json["sellerName"];
 sellerId=json["sellerId"];
 status=json["status"];
}
}