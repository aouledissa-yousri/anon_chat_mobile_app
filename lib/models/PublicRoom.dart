import 'Message.dart';
import 'Room.dart';
import 'User.dart';

class PublicRoom extends Room {


  List<User> _users = <User>[];


  PublicRoom(String name, List<Message> messages, List<User> users): super(name, messages) {
    this._users = users;
  }

  
}