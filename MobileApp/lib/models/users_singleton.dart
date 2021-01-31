class UsersSingleton {
  static final UsersSingleton _singleton = new UsersSingleton._internal();

  UsersSingleton._internal();

  static UsersSingleton get instance => _singleton;

  String _username;

  String get username => _username;

  void setUsername(String username) => _username = username;
}
