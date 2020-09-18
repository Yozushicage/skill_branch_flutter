import '../string_utils.dart';

enum LoginType { email, phone }

class User {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;
  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email})
      : this._firstName = firstName,
        this._lastName = lastName,
        this.phone = phone,
        this.email = email {
    print("User is created.");
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty.");
    if ((phone != null && phone.isEmpty) || (email != null && email.isEmpty))
      throw Exception("Phone or email is empty.");

    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: phone != null ? checkPhone(phone) : "",
        email: email != null ? checkEmail(email) : "");
  }

  static String _getLastName(String userName) => userName.split(" ")[1];
  static String _getFirstName(String userName) => userName.split(" ")[0];

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";

    if (phone == null || phone.isEmpty)
      throw Exception("Enter don't empty phone number");

    phone = phone.replaceAll(RegExp("[^+\\d]"), "");

    if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception(
          "Enter a valid phone number starting with a + and containing 11 digits");
    }

    return phone;
  }

  static String checkEmail(String email) {
    if (email == null || email.isEmpty) {
      throw Exception("The email must not be empty.");
    }

    return email;
  }

  String get login {
    return _type == LoginType.phone ? phone : email;
  }

  String get name => "${"".capitalize(_firstName)} ${"".capitalize(_lastName)}";

  @override
  // ignore: missing_return
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }

    if (object is User) {
      return _lastName == object._lastName &&
          _firstName == object._firstName &&
          (phone == object.phone || email == object.email);
    }
  }

  void addFriends(Iterable<User> newFriends) {
    friends.addAll(newFriends);
  }

  void removeFriend(User user) {
    friends.remove(user);
  }

  @override
  String toString() {
    return '''
    name: $name
    email: $email
    firstName: $_firstName
    lastName: $_lastName
    friends: ${friends.toList()}
    ''';
  }

  @override
  int get hashCode => super.hashCode;
}
