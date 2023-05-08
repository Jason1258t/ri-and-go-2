part of 'register_bloc.dart';



class RegisterState {
  final String name;
  final String email;
  final String phone;
  final String password;

  RegisterState(
      {this.name = '', this.email = '', this.phone = '', this.password = ''});

  RegisterState copyWith(
      {String? name, String? email, String? phone, String? password}) {
    return RegisterState(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}

class RegisterInitialState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterFailState extends RegisterState {}
class RegisterLoadingState extends RegisterState {}