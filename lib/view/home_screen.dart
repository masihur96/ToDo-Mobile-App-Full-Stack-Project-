import 'package:floating_chat_button/floating_chat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:todo_app/model/custom_size.dart';
import 'package:todo_app/view/add_task_screen.dart';
import 'package:todo_app/view/assign_screen.dart';
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
  final DataFetcher _dataFetcher = DataFetcher();

  @override
  void initState() {
 fetchTask();
 fetchUser();
    // TODO: implement initState
    super.initState();
  }
  List<Task> totalTask=[];
  List<Task> assignByMeTask=[];
  List<Task> assignToMeTask=[];
  List<Task> pendingTask=[];
  List<Task> finishedTask=[];

  fetchTask()async{
    assignByMeTask=[];
    assignToMeTask=[];
    totalTask=[];
     List<Task>?  tasks = await  _dataFetcher.retrieveAllTask();

     for(int i = 0;i<tasks!.length;i++){

       if(tasks[i].user_id==widget.user.userId){
         assignByMeTask.add(tasks[i]);
         totalTask.add(tasks[i]);
       }
       if(tasks[i].submitorId==widget.user.userId){
         assignToMeTask.add(tasks[i]);
         totalTask.add(tasks[i]);
       }
     }

    print(assignByMeTask.length);
    print(assignToMeTask.length);
    print(totalTask.length);
    finishedTask = [];
    pendingTask = [];
    for(int j = 0;j<totalTask.length;j++){
      if(totalTask[j].isFinished!){
        finishedTask.add(totalTask[j]);
      }else{
        pendingTask.add(totalTask[j]);
      }
    }
    print("Finished: ${finishedTask.length}");
    print("Pending: ${pendingTask.length}");
     setState(() {

     });

  }
  List<User> totalUser=[];

  fetchUser()async{

    totalUser=[];
    List<User>?  users = await  _dataFetcher.retrieveAllUser();
    totalUser = users!;
 print(users.length);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: (){
          //fetchUser();
         Navigator.push(context, MaterialPageRoute(builder: (_)=>AddTaskScreen(users: totalUser,)));
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
              CardButton(title: "Total Task",count: "${totalTask.length} Task",isVertical:true, icon:  Icons.all_inbox_outlined, bgColor: Colors.black12, onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=> AssignByScreen(tasks: totalTask,),),);
              }),
              Column(

                children: [
                CardButton(title: "Pending\nTask",
                    count: "${pendingTask.length} Task",
                    isVertical:false, icon:  Icons.pending_outlined, bgColor: Colors.black12, onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> AssignByScreen(tasks: pendingTask,),),);

                }),
                CardButton(title: "Finished\nTask",count: "${finishedTask.length}  Task",isVertical:false, icon:  Icons.pin_end_rounded, bgColor: Colors.black12, onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> AssignByScreen(tasks: finishedTask,),),);
                }),
              ],
              ),
            ],),
            SizedBox(height: 10,),
            Text("Your Task",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: screenSize(context, .04),fontWeight: FontWeight.bold),),
            Expanded(
              child: ListView.builder(
                itemCount: totalTask.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  print(totalTask[index].title);
                  return TaskListTile(
                    task: totalTask[index],
                    onTap: (){

                    },);
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
