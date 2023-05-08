class Constants {
  Constants._();

  static const Duration buttonDuration = Duration(milliseconds: 300);
  static const Duration likeEventLoop = Duration(milliseconds: 17);
  static const Duration requestDuration = Duration(seconds: 3);

  static String passwordRegex =
      r"(?=.*[0-9])(?=.*[a-z]).{8,}$"; //(?=.*[A-Z])(?=.*[!@#$%^&()?,./\|*№;:])
  static String emailRegex = r"^[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+";
}
