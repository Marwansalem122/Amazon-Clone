class Address
{
  String? name;
  String? phoneNumber;
  String? streetNumber;
  String? flatHouseNumber;
  String? city;
  String? stateCountry;
  String? completeAddress;



  Address.fromJson(Map<String, dynamic> json)
  {
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    streetNumber = json['streetNumber'];
    flatHouseNumber = json['flatHouseNumber'];
    city = json['city'];
    stateCountry = json['stateCountry'];
    completeAddress = json['completeAddress'];
  }
}