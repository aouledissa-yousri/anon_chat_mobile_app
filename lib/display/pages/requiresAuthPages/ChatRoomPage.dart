import 'dart:async';
import 'dart:convert';

import 'package:anon_chat_mobile_app/models/Message.dart';
import 'package:flutter/material.dart';

import '../../../helpers/DirectoryHelper.dart';
import '../../../services/ChatRoomManagementService.dart';


class ChatRoomPage extends StatefulWidget {
  final int roomId;

  const ChatRoomPage({super.key, required this.roomId});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {

  late List<ListTile> messageList = [];
  late List<Message> messages = [];
  Timer? timer;

  final TextEditingController sendMessageController = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    this.timer = Timer.periodic(Duration(seconds: 1), (Timer t) => this.getMessages());
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(0),
            child: IconButton(
              icon: Icon(Icons.arrow_back, size: 30),
              onPressed: () => back(context)
            ),
            margin: EdgeInsets.only(bottom: 50),
            alignment: Alignment.topLeft,
          ),

          Text("    "), 

          Expanded(child: 
            SizedBox(
              height: 50,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(color: Color.fromARGB(103, 0, 0, 0), endIndent: 16, indent: 16),
                itemCount: this.messageList.length,
                itemBuilder: (context, index) => this.messageList[index],
              )
            )
          ),

          Container(
            padding: EdgeInsets.all(20),
            height: 100,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Send Message",
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Color.fromARGB(255, 8, 221, 193)),
                  onPressed: () => this.sendMessage(),
                ),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 8, 221, 193)))
              ),
            controller: sendMessageController,
            ),
          )
        ]
      ),
    );;
  }


  void getMessages() async{

    ChatRoomManagementService.getMessages(widget.roomId, await DirectoryHelper.getToken()).then((response) {
      dynamic responseData = jsonDecode(response.body);
      this.messages = [];

      for(dynamic responseElement in responseData)
        setState(() => this.messages.add(Message(responseElement["text"], responseElement["time"])));
      
      setState(() => this.messageList = this.displayMessages());
      
    });
    
  }

  void sendMessage() async {
    ChatRoomManagementService.sendMessage(Message(this.sendMessageController.text, "4:00 AM"), widget.roomId, await DirectoryHelper.getToken());
    setState(() => this.sendMessageController.text = "");
  }

  List<ListTile> displayMessages() {
    List<ListTile> messageList = [];

    for(int i = 0; i < this.messages.length; i++)
      messageList.add(
        ListTile(
          leading: Text(this.messages[i].getText()),
        ),
      );


    return messageList;
  }

  void back(BuildContext context){
    Navigator.pop(context);
  }

}