class Address {
  String street;
  String suite;
  String city;
  String zipCode;

  Address.fromJson(Map<String, dynamic> json)
      : street = json['street'],
        suite = json['suite'],
        city = json['city'],
        zipCode = json['zipcode'];
}
