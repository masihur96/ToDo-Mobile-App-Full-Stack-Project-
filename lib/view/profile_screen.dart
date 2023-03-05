
import 'package:flutter/material.dart';
import 'package:todo_app/model/custom_size.dart';
import 'package:todo_app/view/login_screen.dart';
import 'package:todo_app/view/widgets/appbar.dart';

import '../model/preferences.dart';
import '../model/user_model.dart';


class ProfileScreen extends StatefulWidget {
  final   User? user;
  const ProfileScreen({Key? key,required this.user}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  SharedPref pref = SharedPref();




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: customAppbar(isBackButton: true,isModeControlling: false,isNavigationButton: false,isInfoButton: false,onBackTap: (){

      },onInfoTap: (){

      },),
      ),
      body: SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                     Text(
                      "Profile",style: TextStyle(fontSize: screenSize(context, .07),fontWeight: FontWeight.bold),

                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey),

                            shape: BoxShape.circle),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset("assets/images/logo.png",height: screenSize(context, .2),width: screenSize(context, .2),),
                        ),
                      ),
                    ),

                     SizedBox(
                      height: screenSize(context, .1),
                    ),
                     Text(
                      "Name: ${widget.user!.userName}",
                    ),
                    SizedBox(
                      height: screenSize(context, .05),
                    ),

                    const Divider(
                      color: Color(0xffeaeaea),
                    ),
                     Padding(
                      padding: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Email: ${widget.user!.email}",

                      ),
                    ),
                    SizedBox(
                      height: screenSize(context, .1),
                    ),
                    const Divider(
                      color: Color(0xffeaeaea),
                    ),

                    ElevatedButton(
                      child: const Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 28.0,vertical: 8),
                        child:  Text(
                          "Logout",

                        ),
                      ),

                      onPressed: () async{

                      await  pref.removeToken().then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Registration Successful"),
                            ),
                          );
                        });
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen()),);


                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
            ],
          )
      )
    );
  }

}