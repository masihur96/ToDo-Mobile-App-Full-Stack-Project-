import 'package:flutter/material.dart';
import 'package:todo_app/view/register_screen.dart';
import 'package:todo_app/view/widgets/todo_text_form_field.dart';

import '../controller/data_fetcher.dart';
import '../model/preferences.dart';
import '../model/user_model.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final DataFetcher _dataFetcher = DataFetcher();
  String? _emailText;
  String? _passwordText;
  bool obscureText = true;

  int counter = 0;
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey,
      body: _bodyUI(context),
    );
  }

  Widget _bodyUI(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        // dismiss the keyboard when the user taps outside of it
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  top: 30.0,
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height * .15,
                        padding: EdgeInsets.only(bottom: size.width * .06),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'ToDo Manager',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * .1,
                                  fontFamily: 'MateSC',
                                  fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.online_prediction,
                                    size: size.width * .04, color: Colors.white),
                                SizedBox(width: size.width * .03),
                                Text(
                                  'A community for Youtuber',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * .045,
                                  ),
                                ),
                                SizedBox(width: size.width * .03),
                                Icon(Icons.online_prediction,
                                    size: size.width * .04, color: Colors.white),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: size.height * .70,
                    width: size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size.width * .30),
                          // topLeft: Radius.circular(size.width * .15),
                        ),
                      ),
                      margin: EdgeInsets.all(0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * .05, size.width * .10, 0.0, 0.0),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * .09,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                size.width * .05, size.width * .02, 0.0, 0.0),
                            child: Text(
                              'Get logged in for better experience',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: size.width * .032,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.width * .05,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  width: size.width,
                                  padding: EdgeInsets.fromLTRB(
                                      size.width * .05, 20.0, size.width * .05, 0.0),
                                  child: TODOTextFormField(
                                    hintText: "Email",
                                    validator: (String? value) {
                                      if (value == null || value.trim() == "") {
                                        return 'Email is Required';
                                      }
                                      return null;
                                    },
                                    onSaved: (String? value) {
                                      setState(() {
                                        _emailText = value?.trim();
                                      });
                                    },


                                    labelText: "Email",

                                  )
                                ),
                                Container(
                                    width: size.width,
                                    padding: EdgeInsets.fromLTRB(
                                        size.width * .05, 20.0, size.width * .05, 0.0),
                                    child: TODOTextFormField(
                                      hintText: "Password",
                                      validator: (String? value) {
                                        if (value == null || value.trim() == "") {
                                          return 'Password is Required';
                                        }
                                        return null;
                                      },
                                      onSaved: (String? value) {
                                        setState(() {
                                          _passwordText = value?.trim();
                                        });
                                      },


                                      labelText: "Password",
                                    )
                                ),
                              ],
                            ),
                          ),

                          Container(
                            width: size.width,
                            height: size.width * .18,
                            padding: EdgeInsets.fromLTRB(
                                size.width * .05, 20.0, size.width * .05, 0.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();

                                  if (_passwordText !=null && _emailText != null ) {

                                    if (_passwordText!.isNotEmpty &&  _emailText!.isNotEmpty){


                                        setState(() {
                                          _isLoading = true;
                                        });
                                        User? user = await _dataFetcher.login(
                                          email: _emailText!,
                                          password: _passwordText!,
                                        );
                                        if (user != null) {

                                          setState(() {
                                            _isLoading = false;
                                          });
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text("Login Successful"),
                                            ),
                                          );
                                          _emptyFieldCreator();

                                          Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen(user: user,),),);

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


                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.black),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ))),
                              child:_isLoading?const CircularProgressIndicator(): Text(
                                'LOG IN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * .04,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: size.width * .04),
                              width: size.width,
                              child: TextButton(
                                child: Text(
                                  'Forget password?',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: size.width * .038,
                                  ),
                                ),
                                onPressed: () async{
                                  SharedPref pref = SharedPref();
                                  String v = await pref.getToken();
                                  print("Pref: $v");
                                },
                              )),
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: EdgeInsets.only(
                                bottom: size.width * .1,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Do not have account?',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: size.width * .038,
                                    ),
                                  ),
                                  SizedBox(
                                    width: size.width * .02,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Register()));
                                    },
                                    child: Text(
                                      'Register here',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: size.width * .038,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  _emptyFieldCreator() {
    setState((){
      _emailText = "";
      _passwordText = "";
    });

  }
}
