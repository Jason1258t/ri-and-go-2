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
      phone: name ?? this.phone,
      email: name ?? this.email,
      password: name ?? this.password,
    );
  }
}

class RegisterInitialState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
