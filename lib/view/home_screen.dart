import 'package:floating_chat_button/floating_chat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo_app/model/custom_size.dart';
import 'package:todo_app/view/add_task_screen.dart';
import 'package:todo_app/view/profile_screen.dart';
import 'package:todo_app/view/widgets/appbar.dart';
import 'package:todo_app/view/widgets/card_tile.dart';
import 'package:todo_app/view/widgets/task_list_tile.dart';

import '../controller/data_fetcher.dart';
import '../model/task_model.dart';
import '../model/user_model.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home_screen";
  final User user;
  const HomeScreen({Key? key,required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void initState() {
    fetchTask();
    // TODO: implement initState
    super.initState();
  }

  fetchTask()async{
    final DataFetcher _dataFetcher = DataFetcher();
     List<Task>?  tasks = await  _dataFetcher.retrieveAllTask();
    // print(tasks!.length);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: (){
          fetchTask();
         // Navigator.push(context, MaterialPageRoute(builder: (_)=>AddTaskScreen()));
        },
        child: const CircleAvatar(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),),
      ),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: customAppbar(isBackButton: false,isModeControlling: true,isNavigationButton: true,isInfoButton: true, onBackTap: () {  }, onInfoTap: () { Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileScreen(user: widget.user,),),); },)),


      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("Every Day Your \nTask Plan",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: screenSize(context, .06),fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              CardButton(title: "Total Task",count: "100 Task",isVertical:true, icon:  Icons.all_inbox_outlined, bgColor: Colors.black12, onTap: (){

              }),
              Column(

                children: [
                CardButton(title: "Pending\nTask",count: "40 Task",isVertical:false, icon:  Icons.pending_outlined, bgColor: Colors.black12, onTap: (){

                }),
                CardButton(title: "Finished\nTask",count: "60 Task",isVertical:false, icon:  Icons.pin_end_rounded, bgColor: Colors.black12, onTap: (){

                }),
              ],)
            ],),
            SizedBox(height: 10,),
            Text("Your Task",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: screenSize(context, .04),fontWeight: FontWeight.bold),),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return TaskListTile(title: 'Task One', status: 'Done',photo: "",onTap: (){},);
                },
              ),
            ),
            Container(

            ),
            // FloatingChatButton(
            //
            //   onTap: (_) {
            //
            //   },
            //   messageText: "I like this package",
            // )
          ],
        ),
      ),
    );
  }
}
