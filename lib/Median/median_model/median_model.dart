class Median {
  int id;
  String firstname;
  String lastname;
  String email;
  String birthDate;
  Login login;
  Address address;
  String phone;
  String website;
  Company company;

  Median({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.birthDate,
    required this.login,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  factory Median.fromJson(Map<String, dynamic> json) {
    return Median(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      birthDate: json['birthDate'],
      login: Login.fromJson(json['login']),
      address: Address.fromJson(json['address']),
      phone: json['phone'],
      website: json['website'],
      company: Company.fromJson(json['company']),
    );
  }
}

class Login {
  String uuid;
  String username;
  String password;
  String md5;
  String sha1;
  String registered;

  Login({
    required this.uuid,
    required this.username,
    required this.password,
    required this.md5,
    required this.sha1,
    required this.registered,
  });

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      uuid: json['uuid'],
      username: json['username'],
      password: json['password'],
      md5: json['md5'],
      sha1: json['sha1'],
      registered: json['registered'],
    );
  }
}

class Address {
  String street;
  String suite;
  String city;
  String zipcode;
  Geo geo;

  Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    required this.geo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      street: json['street'],
      suite: json['suite'],
      city: json['city'],
      zipcode: json['zipcode'],
      geo: Geo.fromJson(json['geo']),
    );
  }
}

class Geo {
  String lat;
  String lng;

  Geo({
    required this.lat,
    required this.lng,
  });

  factory Geo.fromJson(Map<String, dynamic> json) {
    return Geo(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}

class Company {
  String name;
  String catchPhrase;
  String bs;

  Company({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      name: json['name'],
      catchPhrase: json['catchPhrase'],
      bs: json['bs'],
    );
  }
}
