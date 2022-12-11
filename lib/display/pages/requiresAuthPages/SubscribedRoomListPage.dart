import 'dart:convert';

import 'package:anon_chat_mobile_app/display/pages/requiresAuthPages/ChatRoomPage.dart';
import 'package:flutter/material.dart';

import '../../../helpers/DirectoryHelper.dart';
import '../../../models/Room.dart';
import '../../../services/ChatRoomManagementService.dart';


class SubscribeRoomListPage extends StatefulWidget {
  const SubscribeRoomListPage({super.key});

  @override
  State<SubscribeRoomListPage> createState() => _SubscribeRoomListPageState();
}

class _SubscribeRoomListPageState extends State<SubscribeRoomListPage> {

  late List<Room> rooms = [];
  late List<ListTile> displayedRooms = [];

  final TextEditingController roomNameController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getSubscribedRooms();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(20),

      child: Column(
        children: [

          TextField(
            decoration: InputDecoration(
              hintText: "Room name",
              icon: Icon(Icons.search, color: Color.fromARGB(255, 8, 221, 193)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 8, 221, 193)))
            ),
            controller: roomNameController,
            onChanged: (value) => this.searchRoom(),
          ),

          Text("    "), 

          Expanded(child: 
            SizedBox(
              height: 50,
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(color: Colors.black, endIndent: 16, indent: 16),
                itemCount: this.displayedRooms.length,
                itemBuilder: (context, index) => this.displayedRooms[index],
              )
            )
          )

        ],
      ),
    );
  }


  void getSubscribedRooms() async {
    
    ChatRoomManagementService.getSubscribedRoomList(await DirectoryHelper.getToken()).then((response) {
      dynamic responseData = jsonDecode(response.body);

      for(dynamic responseElement in responseData["publicSubscribers"])
        setState(() => this.rooms.add(Room.createRoomInstance(int.parse(responseElement["id"]), responseElement["name"], responseElement["type"])));
      
      for(dynamic responseElement in responseData["privateSubscribers"])
        setState(() => this.rooms.add(Room.createRoomInstance(int.parse(responseElement["id"]), responseElement["name"], responseElement["type"])));
      
      this.displayedRooms = this.listRooms();
      
    });
  }


  void searchRoom(){

    if(this.roomNameController.text == ""){
      this.rooms = [];
      this.getSubscribedRooms();
      
    }else { 

      List<Room> rooms = [];

      for(Room room in this.rooms)
        if(room.getName().toLowerCase().contains(this.roomNameController.text.toLowerCase()))
          rooms.add(room);
      

      
      setState(() {
        this.rooms = rooms;
        this.displayedRooms = this.listRooms();
      });

    }

  }


  List<ListTile> listRooms(){

    List<ListTile> rooms = [];

    for(int i = 0; i < this.rooms.length; i++)
      rooms.add(
        ListTile(
          leading: Text(this.rooms[i].getName()),
          trailing: ElevatedButton(
            child: Text("Details"),

            style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 8, 221, 193))
            ), 

            onPressed: ()  {
              
              showDialog(context: context, builder: (context){
          
                return SimpleDialog(
                  title: Text("Recycle Request Details", textAlign: TextAlign.center),
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(children: [Text("id: ", style: TextStyle(fontWeight: FontWeight.bold),), Text(this.rooms[i].getId().toString())]),
                          Row(children: [Text("name: ", style: TextStyle(fontWeight: FontWeight.bold),), Text(this.rooms[i].getName())]),
                          Row(children: [Text("type: ", style: TextStyle(fontWeight: FontWeight.bold),), Text(this.rooms[i].getType())]),
                        ],
                      ),
                    ),

                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 60),
                      child: Row(
                        children: [
                          ElevatedButton( onPressed: () => this.goToChatRoom(this.rooms[i].getId()), child: Text("Check Messages"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 8, 221, 193)))),
                          Text("       "),
                          ElevatedButton( onPressed: () => this.leaveRoom(this.rooms[i], i), child: Text("Leave Room"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 187, 31, 20))))

                        ],
                      )
                    )
                  ]
                );
              });


            }
          ),
        ),
      );


    return rooms;

  }




  void goToChatRoom(int roomId){
    Navigator.of(context).pop();
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatRoomPage(roomId: roomId,)));
  }

  void leaveRoom(Room room, int index) async{

    ChatRoomManagementService.leaveChatRoom(room, await DirectoryHelper.getToken()).then((response) {
      dynamic responseData = jsonDecode(response.body);
      setState(() => this.displayedRooms.removeAt(index));

      Navigator.of(context).pop();
      
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




}