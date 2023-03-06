import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../model/constants.dart';
import '../../model/custom_size.dart';
import '../../model/task_model.dart';

class TaskListTile extends StatelessWidget {
  final Task? task;
  final Function() onTap;
  const TaskListTile({Key? key,required this.task,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Card(
color: Colors.grey,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Stack(
          children: [
            SizedBox(
              height: screenSize(context,.25),

              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Transform.rotate(
                          angle: 45,
                          child: Container(
                            decoration: const BoxDecoration(       color: Colors.black,
                              borderRadius: BorderRadius.all(Radius.circular(5),),),
                            child: Transform.rotate(
                              angle: -45,
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.ac_unit,
                                  color: TodoColor.buttonColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 15,),

                        cardInfo(context,task!),
                      ],
                    ),

                    const Icon(Icons.more_vert_outlined,color: Colors.white,)
                  ],
                ),
              ),
            ),

             Positioned(
              right: 10,
                top: 5,
            child: CircleAvatar(
              radius: 13,

                backgroundColor: Colors.black,
                child: Icon(FeatherIcons.user,color: Colors.white,size: screenSize(context, .05),)))
          ],
        ),
      ),
    );
  }

  Widget cardInfo(BuildContext context,Task task){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        FittedBox(
          child: Text(
            task.title!,
            textAlign: TextAlign.center,
            style:  TextStyle(
                color: TodoColor.buttonColor,
                fontFamily: "Roboto",
                fontSize: screenSize(context, .05),
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          task.isFinished! ? "Done":"Pending",
          textAlign: TextAlign.center,
          style:  TextStyle(
              color: TodoColor.buttonColor,
              fontSize: screenSize(context, .03),
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
