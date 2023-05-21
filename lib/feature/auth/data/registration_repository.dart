class RegistrationRepository {
  RegistrationInfo registrationInfo = RegistrationInfo();

  void addRegInfo(
      {String? name, String? email, String? phone, String? password}) {
    registrationInfo = RegistrationInfo(
      name: name?? registrationInfo.name,
      email: email?? registrationInfo.email,
      phone: phone?? registrationInfo.phone,
      password: password?? registrationInfo.password,
    );
  }

  RegistrationInfo getRegInfo() {
    return registrationInfo;
  }
}

class RegistrationInfo {
  String? name;
  String? phone;
  String? email;
  String? password;

  RegistrationInfo({this.name, this.email, this.phone, this.password});


  Map<String, dynamic> toJson() {
    return {
      'name': name!,
      'phoneNumber': phone!,
      'email': email!,
      'password': password!,
      'contactUrl': ''
    };
  }
}
