
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/custom_size.dart';
import 'package:todo_app/view/widgets/todo_text_form_field.dart';

import '../controller/data_fetcher.dart';
import '../model/preferences.dart';
import '../model/task_model.dart';
import '../model/user_model.dart';
import 'home_screen.dart';


class AddTaskScreen extends StatefulWidget {
  final List<User> users;
  final User user;

  const AddTaskScreen({Key? key,required this.users,required this.user}) : super(key: key);
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {

  final DataFetcher _dataFetcher = DataFetcher();
  String? _titleText;
  String? _bodyText;
  int? _selectedEmployeeId;
  String? _selectedEmployeeName;
  bool _isLoading = false;

  int? watchingRequiredCoin = 0;
  int? watchingRateCoin = 1;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: const Text('Add Task'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {

          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height:screenSize(context, .2),),
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
                    child: Form(
                      key: _formKey,
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
                                  textEditingController: TextEditingController(text: _selectedEmployeeName ),
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
                                      _selectedEmployeeName = value?.trim();
                                    });
                                  },


                                  labelText: "Employee",

                                ),
                              )
                          ),

                        ],
                      ),
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

                              if (_selectedEmployeeName!.isNotEmpty &&  _titleText!.isNotEmpty){


                                setState(() {
                                  _isLoading = true;
                                });
                               // final prefs = await SharedPreferences.getInstance();
                                SharedPref pref = SharedPref();
                             String   prefUserId = await pref.getUserId();
                               // print(prefUserId);
                               //  print(_selectedEmployeeText);
                               //  print(_titleText);
                               //  print(_bodyText);
                                bool? isCreated = await _dataFetcher.createTask(
                                   title: _titleText!,
                                  body: _bodyText!,
                                  isFinished: false,
                                  assignTo: _selectedEmployeeId! ,
                                  assignBy: int.parse(prefUserId) ,
                                );

                                if (isCreated!) {

                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Task Created Successfully"),
                                    ),
                                  );
                                  _emptyFieldCreator();

                                  Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen(user: widget.user,),),);

                                } else {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Something is Wrong"),
                                    ),
                                  );
                                }

                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Title, Body & Assigning an Employee is required"),
                                  ),
                                );

                              }
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Title, Body & Assigning an Employee is required"),
                                ),
                              );

                            }





                          }

                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                        ),
                        child: _isLoading?CircularProgressIndicator(color: Colors.white,): Text(
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
                      _selectedEmployeeId = widget.users[index].userId;
                      _selectedEmployeeName = widget.users[index].userName;
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
