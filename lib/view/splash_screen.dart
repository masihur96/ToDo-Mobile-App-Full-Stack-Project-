import 'package:flutter/material.dart';
import 'package:todo_app/model/custom_size.dart';
import 'package:todo_app/model/user_model.dart';
import 'package:todo_app/view/login_screen.dart';

import '../controller/data_fetcher.dart';
import '../model/preferences.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splash_screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final DataFetcher _dataFetcher = DataFetcher();
  SharedPref pref = SharedPref();
  @override
  void initState() {
    navigate();
    // TODO: implement initState
    super.initState();
  }
  String? prefToken;
  String? prefUserId;
  navigate()async{
    if(prefToken != null){
      prefToken = await pref.getToken();
    }

    //
    // print("Print:  $prefToken");
    if(prefToken != null){
      prefUserId = await pref.getUserId();
     User? user = await  _dataFetcher.retrieveUserWithUid(customerUid: prefUserId!);
     if(user != null){
       Future.delayed(Duration(seconds: 2), () {
         Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen(user: user,),),);
       });

     }else{
       Future.delayed(Duration(seconds: 2), () {
         Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen(),),);
       });
     }
    }else{
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginScreen(),),);
      });

    }
    // print("Pref: $prefToken");
    // print("PrefUserId: $prefUserId");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/logo.png",height: screenSize(context, .5),width: screenSize(context, .5),),
      ),
    );
  }
}
