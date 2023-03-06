
import 'package:flutter/material.dart';
import 'package:todo_app/view/widgets/todo_text_form_field.dart';

import '../controller/data_fetcher.dart';
import '../model/user_model.dart';
import 'home_screen.dart';


class AddTaskScreen extends StatefulWidget {
  final List<User> users;

  const AddTaskScreen({Key? key,required this.users}) : super(key: key);
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final DataFetcher _dataFetcher = DataFetcher();
  String? _titleText;
  String? _bodyText;
  String? _selectedEmployeeText;
  bool _isLoading = false;

  int? watchingRequiredCoin = 0;
  int? watchingRateCoin = 1;

  final _formKey = GlobalKey<FormState>();
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

                      Container(
                          width: size.width,
                          padding: EdgeInsets.fromLTRB(
                              size.width * .05, 20.0, size.width * .05, 0.0),
                          child: TODOTextFormField(
                            hintText: "Title",
                            validator: (String? value) {
                              if (value == null || value.trim() == "") {
                                return 'Title is Required';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _titleText = value?.trim();
                              });
                            },


                            labelText: "Title",

                          )
                      ),


                      Container(
                          width: size.width,
                          padding: EdgeInsets.fromLTRB(
                              size.width * .05, 20.0, size.width * .05, 0.0),
                          child: TODOTextFormField(
                            hintText: "Description",

                            validator: (String? value) {
                              if (value == null || value.trim() == "") {
                                return 'Description is Required';
                              }
                              return null;
                            },
                            onSaved: (String? value) {
                              setState(() {
                                _bodyText = value?.trim();
                              });
                            },


                            labelText: "Description",

                          )
                      ),

                      SizedBox(height: size.width * .02),
                      Container(
                          width: size.width,
                          padding: EdgeInsets.fromLTRB(
                              size.width * .05, 20.0, size.width * .05, 0.0),
                          child:
                          
                          GestureDetector(
                            onTap: (){
                              showAlertDialog(context);
                            },
                            child: TODOTextFormField(
                              textEditingController: TextEditingController(text: _selectedEmployeeText),
                              isEnable: false,
                              onTap: (){
                                showAlertDialog(context);
                              },
                              hintText: "Employee",
                              validator: (String? value) {
                                if (value == null || value.trim() == "") {
                                  return 'Employee is Required';
                                }
                                return null;
                              },
                              onSaved: (String? value) {
                                setState(() {
                                  _selectedEmployeeText = value?.trim();
                                });
                              },


                              labelText: "Employee",

                            ),
                          )
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


                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          if (_titleText !=null && _bodyText != null ) {

                            if (_selectedEmployeeText!.isNotEmpty &&  _titleText!.isNotEmpty){


                              setState(() {
                                _isLoading = true;
                              });
                              print(_selectedEmployeeText);
                              print(_titleText);
                              print(_bodyText);
                              // User? user = await _dataFetcher.login(
                              //   email: _emailText!,
                              //   password: _passwordText!,
                              // );
                              // if (user != null) {
                              //
                              //   setState(() {
                              //     _isLoading = false;
                              //   });
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text("Login Successful"),
                              //     ),
                              //   );
                              //   _emptyFieldCreator();
                              //
                              //   Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen(user: widget.users,),),);
                              //
                              // } else {
                              //   setState(() {
                              //     _isLoading = false;
                              //   });
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     const SnackBar(
                              //       content: Text("Something is Wrong"),
                              //     ),
                              //   );
                              // }
                              //
                              //




                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Name,Email & Password is required"),
                                ),
                              );

                            }
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Name,Email & Password is required"),
                              ),
                            );

                          }





                        }
                        print(_titleText);
                        print(_bodyText);
                        print(_selectedEmployeeText);
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
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop(); // dismiss dialog
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Add Task"),
      content: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: widget.users.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("${widget.users[index].userName}"),
                  onTap: () {

                    setState((){
                      _selectedEmployeeText = widget.users[index].userName;
                    });
                    Navigator.pop(context);

                    // do something when item is tapped
                  },
                );
              },
            ),
          )

        ],
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  _emptyFieldCreator() {
    setState((){
      _titleText = "";
      _bodyText = "";
    });

  }
}
