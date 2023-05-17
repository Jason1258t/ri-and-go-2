
class User {
  final String name;
  final String? contactUrl;
  final String imageUrl = '';
  final String email;
  final String phoneNumber;

  User({required this.name, required this.contactUrl, required this.email, required this.phoneNumber});
}