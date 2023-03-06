import 'package:flutter/material.dart';

import '../../model/constants.dart';
import '../../model/custom_size.dart';

class CardButton extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final Color bgColor;
  final bool isVertical;

  final Function() onTap;
  const CardButton(
      {Key? key,
        required this.title,
        required this.count,
        required this.icon,
        required this.bgColor,
        required this.isVertical,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(screenSize(context,.1),),topRight:Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
          //set border radius more than 50% of height and width to make circle
        ),
        child: SizedBox(
          height: screenSize(context,isVertical? .5:.25),
          width: screenSize(context, isVertical? .35:.45),
          child:isVertical? Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Transform.rotate(


                  angle: 45,
                  child: Container(
                    decoration: const BoxDecoration(       color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(5),),),


                    child: Transform.rotate(
                      angle: -45,
                      child: Padding(
                        padding:  const EdgeInsets.all(10.0),
                        child: Icon(
                          icon,
                          size:  screenSize(context, isVertical? .13:.3),
                          color: TodoColor.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),

                cardInfo(),
              ],
            ),
          ): Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: 45,
                  child: Container(
                    decoration: const BoxDecoration(       color: Colors.black,
                      borderRadius: BorderRadius.all(Radius.circular(5),),),
                    child: Transform.rotate(
                      angle: -45,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          icon,
                          color: TodoColor.buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),

                cardInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget cardInfo(){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: TodoColor.buttonColor,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold),
        ),

        Text(
          count,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: TodoColor.buttonColor,
              fontFamily: "Roboto",
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}