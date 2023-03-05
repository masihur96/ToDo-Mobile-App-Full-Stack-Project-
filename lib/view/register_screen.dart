
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view/widgets/todo_text_form_field.dart';

import '../controller/data_fetcher.dart';
import 'login_screen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // TextEditingController _usernameController = TextEditingController();
  // TextEditingController _emailAddressController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();
  // TextEditingController _confirmPasswordController = TextEditingController();
  final DataFetcher _dataFetcher = DataFetcher();
  final _formKey = GlobalKey<FormState>();

  String? _nameText="";
  String? _emailText="";
  String? _passwordText="";
  String? _confirmPasswordText="";

  bool passwordObscureText = true;
  bool confirmPasswordObscureText = true;
bool _isLoading = false;
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _bodyUI(context),
    );
  }

  Widget _bodyUI(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              Container(
                width: size.width,
                height: size.height * .17,
                padding: EdgeInsets.only(bottom: size.width * .05),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(size.width * .1),
                      bottomRight: Radius.circular(size.width * .1),
                    )),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                          'A community for Employee',
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
              ),
              Container(
                width: size.width,
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    right: size.width * .05,
                    top: size.width * .05,
                    left: size.width * .05,
                    bottom: size.width * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * .06,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: size.width * .02,
                    ),
                    Text(
                      'Get resister for better experience',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width * .032,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      padding: EdgeInsets.fromLTRB(
                          size.width * .05, 0, size.width * .05, 0.0),
                      child:TODOTextFormField(
                        hintText: "Name",
                        validator: (String? value) {
                          if (value == null || value.trim() == "") {
                            return 'Name is Required';
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          setState(() {
                            _nameText = value?.trim();
                          });
                        },


                        labelText: "Name",
                      )

                    ),
                    Container(
                        width: size.width,
                        padding: EdgeInsets.fromLTRB(
                            size.width * .05, size.width * .04, size.width * .05, 0.0),
                        child:  TODOTextFormField(
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
                            size.width * .05, size.width * .04, size.width * .05, 0.0),
                        child:TODOTextFormField(
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
                          labelText: "password",
                        )

                    ),

                    Container(
                        width: size.width,
                        padding: EdgeInsets.fromLTRB(
                            size.width * .05, size.width * .04, size.width * .05, 0.0),
                        child: TODOTextFormField(
                          validator: (String? value) {
                            if (value == null || value.trim() == "") {
                              return 'Confirm is Required';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            setState(() {
                              _confirmPasswordText = value?.trim();
                            });
                          },
                          labelText: "Confirm Password",
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
                  onPressed: () async{
                if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_passwordText !=null && _confirmPasswordText != null && _emailText != null) {

        if (_passwordText!.isNotEmpty && _confirmPasswordText!.isNotEmpty && _emailText!.isNotEmpty){
          if(_passwordText ==_confirmPasswordText){

            setState(() {
              _isLoading = true;
            });
            bool status = await _dataFetcher.register(
              name: _nameText!,
              email: _emailText!,
              password: _passwordText!,
            );
            if (status) {
              setState(() {
                _isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Registration Successful"),
                ),
              );
              _emptyFieldCreator();

              Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen(),),);

            } else {
              setState(() {
                _isLoading = false;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Email or Password Already Exist"),
                ),
              );
            }



          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Unmatched Password"),
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
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ))),
                  child:_isLoading?const CircularProgressIndicator(color: Colors.white,): Text(
                    'REGISTER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * .04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(
                  top: size.width * .1,
                  bottom: size.width * .1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have account?',
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
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Get logged in',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: size.width * .038,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          )),
    );
  }



  _emptyFieldCreator() {
    setState((){
      _nameText = "";
      _emailText= "";
      _passwordText= "";
      _confirmPasswordText= "";
    });
  }
}
