import "Room.dart";


class User {


  String _username = "";
  String _password = "";
  List<Room> _rooms = <Room>[];


  User(String username, String password) {
    this._username = username;
    this._password = password;
  }


  String getUsername(){
    return this._username;
  }

  String getPassword(){
    return this._password;
  }

  dynamic getData(){
    return {
      "username": this._username,
      "password": this._password
    };
  }

}