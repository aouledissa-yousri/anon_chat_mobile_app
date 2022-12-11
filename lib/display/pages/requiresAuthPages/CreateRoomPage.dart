import 'dart:convert';

import 'package:anon_chat_mobile_app/services/ChatRoomManagementService.dart';
import 'package:flutter/material.dart';

import '../../../helpers/DirectoryHelper.dart';
import '../../../models/Room.dart';


class CreateRoomPage extends StatefulWidget {
  const CreateRoomPage({super.key});

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {

  String roomType = "Chat Room Type";
  int selectedRoomType = 0;
  late List<dynamic> roomTypes = ["Private", "Public"];
  bool submitButton = false;


  final TextEditingController roomNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text("Create chat room \n\n", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ListTile(
            leading: Text(roomType),
            trailing: IconButton(
              icon: Icon(Icons.arrow_drop_down, color: Color.fromARGB(255, 8, 221, 193)),
              onPressed: () => listRoomTypes()
            )
          ),

          Divider(color: Color.fromARGB(255, 39, 39, 39), endIndent: 16, indent: 16),

          

          TextField(
            decoration: InputDecoration(
                hintText: "Room name",
            ),
            controller: roomNameController, 
            onChanged: (value) => activateSubmit(),
          ),


          Text("\n\n\n"),

          SizedBox(
            width: double.infinity,
            height: 30,
            child:  ElevatedButton(
                
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 8, 221, 193)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius:  BorderRadius.circular(20))
              )
            ),
    
    
            child: Text("submit"),
              onPressed: this.submitButton ? () => this.submit() : null
            )
          ),

          
        ],
      )
    );
  }


  void listRoomTypes(){

    List<ListTile> optionsList = <ListTile>[];

      optionsList.add(
        ListTile(
          title: Text("Private"),
          leading: Radio(  
            value: 0,  
            groupValue: selectedRoomType,  
            onChanged: (value) => setState(() {
              setSelectedRoomType(value);
              activateSubmit();
            })
          )
        )
      );

      optionsList.add(
        ListTile(
          title: Text("Public"),
          leading: Radio(  
            value: 1,  
            groupValue: selectedRoomType,  
            onChanged: (value) => setState(() {
              setSelectedRoomType(value);
              activateSubmit();
            })
          )
        )
      );

    showDialog(context: context, builder: (context){
          
      return SimpleDialog(
        title: Text("Room Type"),
        children: optionsList
      );

    });
  }



  setSelectedRoomType(int? value){
    setState(() {
      this.selectedRoomType = value!;
      this.roomType = this.roomTypes[this.selectedRoomType];
    });
    Navigator.of(context).pop();
    listRoomTypes();
  }


  void submit() async {
    ChatRoomManagementService.createChatRoom(Room(this.roomNameController.text, this.roomType.toLowerCase()), await DirectoryHelper.getToken()).then((response) {
      this.reset();
      dynamic responseData = jsonDecode(response.body);
      showDialog(context: context, builder: (context){
          
          return AlertDialog(
            title: Text("Success"),
            content: Text(responseData["message"]),
            actions: [
              ElevatedButton(
                onPressed: Navigator.of(context).pop, 
                child: Text("OK"),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 8, 221, 193))
                )
              )
            ],
          );
        });
    });


  }

  void activateSubmit(){
    if(this.roomNameController.text != "" && this.roomType != "Chat Room Type") setState(() => this.submitButton = true);
    else setState(() => this.submitButton = false);
  }


  void reset(){
    setState(() {
      this.roomNameController.text = "";
    });
  }


}
  