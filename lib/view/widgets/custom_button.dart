import 'package:flutter/material.dart';
import '../../model/constants.dart';
import '../../model/custom_size.dart';

class CardButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Function() onTap;
  const CardButton(
      {Key? key,
        required this.title,
        required this.icon,
        required this.bgColor,
        required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          //set border radius more than 50% of height and width to make circle
        ),
        child: SizedBox(
          height: screenSize(context, .35),
          width: screenSize(context, .35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: TodoColor.buttonColor,
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: TodoColor.buttonColor,
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}