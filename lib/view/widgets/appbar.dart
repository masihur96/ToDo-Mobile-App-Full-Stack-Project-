import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intro/intro.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/constants.dart';
import '../../model/custom_size.dart';
import '../../model/provider/theme_provider.dart';


class customAppbar extends StatefulWidget {
  final bool isBackButton;
  final bool isModeControlling;
  final bool isNavigationButton;
  final bool isInfoButton;

  final Function() onBackTap;
  final Function() onInfoTap;
  customAppbar({
    Key? key,
    required this.isBackButton,
    required this.isModeControlling,
    required this.isNavigationButton,
    required this.isInfoButton,
    required this.onBackTap,
    required this.onInfoTap,
  }) : super(key: key);

  @override
  State<customAppbar> createState() => _customAppbarState();
}

class _customAppbarState extends State<customAppbar> {
   IntroController get controller => Intro.of(context).controller;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: AppBar(
        elevation: 0,

        leadingWidth: 20,
        leading: widget.isBackButton?IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back)):SizedBox(),

        title: FittedBox(
          child: Text(
            "ToDo Manager",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenSize(context, .04),
                fontFamily: "Roboto"),
          ),
        ),
        actions: [
          Row(
            children: [
              widget.isModeControlling
                  ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: IntroStepTarget(
                  step: 1,
                  controller: controller,
                  cardContents: const TextSpan(
                    text: "Switch to Light or Dark",
                  ),
                  child: Switch(
                    value: themeProvider.isDark,
                    onChanged: (bool value) async{
                      final SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                      setState(() {
                        themeProvider.isDark = value;

                        final provider = Provider.of<ThemeProvider>(context,
                            listen: false);
                        provider.toggleTheme(value);

                        print(value);
                        prefs.setBool("isDark", value);
                      });
                    },
                  )
                ),
              )
                  : const SizedBox(),
              widget.isNavigationButton
                  ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onTap: (){},
                  child: Padding(
                    padding: EdgeInsets.all(screenSize(context, .02)),
                    child: NeumorphicIcon(FeatherIcons.send,
                        style: NeumorphicStyle(
                          color: themeProvider.isDark
                              ? Color(0xffF5F5F5)
                              : TodoColor.iconColor,
                        ),
                        size: screenSize(context, .06)),
                  ),
                ),
              )
                  : const SizedBox(),
              widget.isInfoButton
                  ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: widget.onInfoTap,
                  child: Padding(
                    padding: EdgeInsets.all(screenSize(context, .02)),
                    child: IntroStepTarget(
                      step: 2,
                      controller: controller,
                      cardContents: const TextSpan(
                        text: "About IK",
                      ),
                      child: NeumorphicIcon(
                          style: NeumorphicStyle(
                              color: themeProvider.isDark
                                  ? Color(0xffF5F5F5)
                                  : TodoColor.iconColor),
                          FeatherIcons. user,
                          size: screenSize(context, .06)),
                    ),
                  ),
                ),
              )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}