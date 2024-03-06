class Sellers{
  String?name;
  String?sellerId;
  String?email;
  // String?location;
  String?photoUrl;
  // String?phone;
  String?ratings;//we don't implement this yet

  Sellers.fromJson(Map<String,dynamic>json){
    name=json["name"];
    sellerId=json["uid"];
    email=json["email"];
    photoUrl=json["photoUrl"];
    ratings=json["ratings"];
    // phone=json["phon"];
    // location=json["location"];
  }
}