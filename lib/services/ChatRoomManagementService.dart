import 'dart:convert';

import 'package:anon_chat_mobile_app/models/Room.dart';

import '../HOSTS.dart';
import 'package:http/http.dart' as http;

import '../models/Message.dart';


abstract class ChatRoomManagementService {


  static dynamic createChatRoom(Room room, String token) async {
    return await http.post(Uri.parse(Hosts.busUrl+"/room/"+room.getType()+"/create/"), headers: {"Content-type": "application/json", "Token" : token}, body: jsonEncode(room.getData()));
  }


  static dynamic joinChatRoom(Room room, String token) async{
    return await http.patch(Uri.parse(Hosts.busUrl+"/room/"+room.getType()+"/"+room.getId().toString()+"/join/"), headers: {"Content-type": "application/json", "Token" : token}, body: jsonEncode(room.getData()));
  }

  static dynamic leaveChatRoom(Room room, String token) async{
    return await http.patch(Uri.parse(Hosts.busUrl+"/room/"+room.getType()+"/"+room.getId().toString()+"/leave/"), headers: {"Content-type": "application/json", "Token" : token});
  }


  static Future<dynamic> getRooms(String token) async {
    return await http.get(Uri.parse(Hosts.busUrl+"/room/"), headers: {"Content-type": "application/json", "Token" : token});
  }



  static dynamic getSubscribedRoomList(String token) async {
    return await http.get(Uri.parse(Hosts.busUrl+"/user/rooms/"), headers: {"Content-type": "application/json", "Token" : token});
  }



  static dynamic getMessages(int roomId, String token) async {
    return await http.get(Uri.parse(Hosts.busUrl+"/room/"+roomId.toString()+"/message"), headers: {"Content-type": "application/json", "Token" : token});
  }

  static dynamic sendMessage(Message message, int roomId, String token) async {
    return await http.post(Uri.parse(Hosts.busUrl+"/room/"+roomId.toString()+"/message/"), headers: {"Content-type": "application/json", "Token" : token}, body: jsonEncode(message.getData()));
  }

}