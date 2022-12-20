import '../HOSTS.dart';
import 'package:http/http.dart' as http;


abstract class TimeService {

  static Future<dynamic> getCurrentTime() async {
    dynamic response = await http.get(Uri.parse(Hosts.timeApiUrl+"/Time/current/zone?timeZone=Europe/Amsterdam"), headers: {"Content-type": "application/json"});
    return response["time"];
  }
  
}