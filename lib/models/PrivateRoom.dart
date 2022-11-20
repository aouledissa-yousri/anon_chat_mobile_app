import 'Message.dart';
import 'Room.dart';
import 'User.dart';

class PrivateRoom extends Room{

  List<User> _users = <User>[];


  PrivateRoom(String name, List<Message> messages, List<User> users): super(name, messages) {
    this._users = users;
  }

  


}