
import 'package:flutter/material.dart';


class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  //watch field
  final TextEditingController _videoTitle = TextEditingController();
  final TextEditingController _videoLink = TextEditingController();
  final TextEditingController _watchedTime = TextEditingController();



  int? watchingRequiredCoin = 0;
  int? watchingRateCoin = 1;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text('Add Task'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add Task',
                style: TextStyle(
                    fontSize: size.width * .05),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10),),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 18),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      TextFormField(
                        controller: _videoTitle,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Task Title',
                        ),
                      ),
                      TextFormField(
                        controller: _videoLink,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter Task Description',
                        ),
                      ),
                      SizedBox(height: size.width * .02),
                      TextFormField(
                        controller: _videoLink,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Assign An Employee',
                        ),
                      ),
                      // Container(
                      //   width: size.width,
                      //   height: size.width * .3,
                      //   decoration: BoxDecoration(
                      //       border: Border.all(color: Colors.red, width: 1.3),
                      //       borderRadius: BorderRadius.all(
                      //           Radius.circular(size.width * .01),),),
                      //   child: Padding(
                      //     padding: EdgeInsets.all(size.width * .02),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Padding(
                      //           padding: EdgeInsets.symmetric(
                      //               vertical: size.width * .03),
                      //           child: Row(
                      //             children: [
                      //               Text(
                      //                 'Watch Rate: $watchingRateCoin ',
                      //                 style:
                      //                 TextStyle(fontSize: size.width * .04),
                      //               ),
                      //               Image.asset(
                      //                 'assets/images/logo.png',
                      //                 height: size.width * .04,
                      //                 width: size.width * .04,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         Divider(
                      //           height: size.width * .03,
                      //           color: Colors.red,
                      //         ),
                      //         Padding(
                      //           padding: EdgeInsets.symmetric(
                      //               vertical: size.width * .02),
                      //           child: Row(
                      //             children: [
                      //               Text(
                      //                 'Required Coin: $watchingRequiredCoin',
                      //                 style: TextStyle(
                      //                     fontSize: size.width * .04,
                      //                     fontWeight: FontWeight.w500),
                      //               ),
                      //               Image.asset(
                      //                 'assets/images/logo.png',
                      //                 height: size.width * .04,
                      //                 width: size.width * .04,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.width * .04),
                    child: ElevatedButton(
                      onPressed: () async {
                        // if (watchingRequiredCoin! >=
                        //     int.parse(firebaseProvider
                        //         .userModel.currentBalance!)) {
                        //   showToast('You do not have enough balance.');
                        // } else {
                        //   await firebaseProvider
                        //       .submitWatchVideoData(
                        //           firebaseProvider.userModel.id!,
                        //           _videoTitle.text,
                        //           _videoLink.text,
                        //           _watchedTime.text)
                        //       .then((value) {
                        //     _updateDeposit(firebaseProvider);
                        //     _videoTitle.clear();
                        //     _videoLink.clear();
                        //     _watchedTime.clear();
                        //     showToast('Successfully Uploaded ');
                        //   });
                        // }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                      ),
                      child: Text(
                        'Post',
                        style: TextStyle(fontSize: size.width * .05),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
