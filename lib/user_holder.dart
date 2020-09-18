import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (!users.containsKey(user.login)) {
      users[user.login] = user;
    } else {
      throw Exception("User with this name already exists");
    }
  }

  User getUserByLogin(String login) => users[login];

  User registerUserByEmail(String fullName, String email) {
    email = User.checkEmail(email);
    User newUser = User(name: fullName, email: email);

    if (users.containsKey(newUser.login)) {
      throw Exception("A user with this email already exists");
    } else if (!email.contains('@')) {
      throw Exception("Invalid email");
    }
    users[newUser.login] = newUser;
    return newUser;
  }

  User registerUserByPhone(String fullName, String phone) {
    phone = User.checkPhone(phone);
    User newUser = User(name: fullName, phone: phone);

    for (User user in users.values) {
      if (user.phone == phone)
        throw Exception("A user with this phone already exists");
    }

    users[newUser.login] = newUser;
    return newUser;
  }

  void setFriends(String login, List<User> friends) {
    User user = users[login];
    user.friends.addAll(friends);
  }

  User findUserInFriends(String login, User friend) {
    if (login == null || login.isEmpty || friend == null)
      throw Exception("Invalid parameters");

    User user = users[login];
    if (user.friends.contains(friend)) {
      return friend;
    } else {
      throw Exception("${user.login} is not a friend of the login");
    }
  }

  List<User> importUsers(List<String> dataList) {
    return dataList.map((item) {
      List<String> userData =
          item.split(';').map((item) => item.trim()).toList();
      return User(name: userData[0], phone: userData[2], email: userData[1]);
    }).toList();
  }
}
