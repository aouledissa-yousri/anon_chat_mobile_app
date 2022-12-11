import '../HOSTS.dart';
import '../models/User.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class UserManagementService {


  static Future<http.Response> signUp(User user) async {
    return await http.post(Uri.parse(Hosts.busUrl+"/signUp/"), headers: {"Content-type": "application/json"}, body: json.encode(user.getData()));
  }


  static Future<http.Response> login(User user) async{
    return await http.post(Uri.parse(Hosts.busUrl+"/login/"), headers: {"Content-type": "application/json"}, body: json.encode(user.getData()));
  }


  static Future<http.Response> logout(String token) async {
    return await http.delete(Uri.parse(Hosts.busUrl+"/logout/"), headers: {"Content-type": "application/json", "Token" : token});
  }

}