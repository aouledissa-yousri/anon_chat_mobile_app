import 'Message.dart';

abstract class Room {


  String _name = "";
  List<Message> _messages = <Message>[];


  Room(String name, List<Message> messages){
    this._name = name;
    this._messages = messages;
  }

}