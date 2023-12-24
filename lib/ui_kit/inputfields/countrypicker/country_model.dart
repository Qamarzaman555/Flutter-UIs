part of '../../local_pub.dart';

class CountryModel {
  String? countryName;
  String? countryCode;
  String? dialCode;

  CountryModel({this.countryName, this.countryCode, this.dialCode});

  CountryModel.fromMap(Map<String, dynamic> resp) {
    countryName = resp['name'];
    countryCode = resp['code'];
    dialCode = resp['dial_code'];
  }

  @override
  String toString() {
    String str = '';
    str = "$dialCode\n$countryCode\n$countryName";
    return str;
  }
}
