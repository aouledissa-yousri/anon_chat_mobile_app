import 'Message.dart';

class Room {


  String _name = "";
  String _type = "";
  int _id = 0;
  List<Message> _messages = <Message>[];


  Room(String name, String type){
    this._name = name;
    this._type = type;
  }

  static Room createRoomInstance(int id, String name, String type){
    Room room = Room(name, type);
    room.setId(id);
    return room;
  }

  String getName(){
    return this._name;
  }

  String getType(){
    return this._type;
  }

  int getId(){
    return this._id;
  }

  dynamic getData(){
    return{
      "name": this._name
    };
  }

  void setName(String name){
    this._name = name;
  }


  void setType(String type){
    this._type = type;
  }


  void setId(int id){
    this._id = id;
  }



}