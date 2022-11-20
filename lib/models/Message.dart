import 'User.dart';

class Message {

  String _message = "";
  User _user = new User("","");

  Message(String message, User user) {
    this._user = user;
    this._message = message;
  }

}