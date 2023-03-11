import 'package:flutter/material.dart';
import 'package:scroll_app_bar/scroll_app_bar.dart';
import 'package:todo_app/view/widgets/task_list_tile.dart';

import '../model/task_model.dart';
class AssignByScreen extends StatefulWidget {
  final  List<Task> tasks;
  const AssignByScreen({Key? key,required this.tasks}) : super(key: key);

  @override
  State<AssignByScreen> createState() => _AssignByScreenState();
}

class _AssignByScreenState extends State<AssignByScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Task'),
            bottom:  const TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Text("Assign Task",style: TextStyle(color: Colors.black),),
                ),
                Tab(
                  icon: Text("My Task",style: TextStyle(color: Colors.black),),
                ),

              ],
            ),
          ),
        body:   TabBarView(
          children: <Widget>[
            Center(
              child:     Column(
                children: [
                  const SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.tasks.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        print(widget.tasks[index].title);
                        return TaskListTile(
                          task: widget.tasks[index],
                          onTap: (){

                          },);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child:  Column(
                children: [
                  SizedBox(height: 10,),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.tasks.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        print(widget.tasks[index].title);
                        return TaskListTile(
                          task: widget.tasks[index],
                          onTap: (){

                          },);
                      },
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
