import 'User.dart';

class Message {

  String _text = "";
  String _time = "";
  User _user = new User("","");

  Message(String text, String time) {
    this._time = time;
    this._text = text;
  }


  String getText(){
    return this._text;
  }

  String getTime(){
    return this._time;
  }

  dynamic getData() {
    return {
      "message": this._text,
      "time": this._time
    };
  }

}