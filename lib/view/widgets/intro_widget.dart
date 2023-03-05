import 'package:flutter/material.dart';
import 'package:intro/intro.dart';

class IntroWidget extends StatelessWidget {
  final IntroController controller;
  final Widget child;
  const IntroWidget({Key? key, required this.controller, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Intro(
        controller: controller,
        cardDecoration: IntroCardDecoration(
          tapBarrierToContinue: true,
          showPreviousButton: true,
          previousButtonStyle: ButtonStyle(
            backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.lightBlue),
            shape: MaterialStateProperty.resolveWith(
                    (states) => const RoundedRectangleBorder()),
          ),
          nextButtonStyle: ButtonStyle(
            backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.lightBlue),
            shape: MaterialStateProperty.resolveWith(
                    (states) => const RoundedRectangleBorder()),
          ),
          closeButtonStyle: ButtonStyle(
            backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.lime),
            shape: MaterialStateProperty.resolveWith(
                    (states) => const RoundedRectangleBorder()),
          ),
        ),
        topLayerBuilder: (context, controller) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, left: 20),
            child: TextButton(
              onPressed: controller.close,
              style: ButtonStyle(
                foregroundColor:
                MaterialStateColor.resolveWith((states) => Colors.white70),
                backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.white24),
              ),
              child: const Text("Stop Tour"),
            ),
          );
        },
        child: child);
  }
}

// Widget IntroWidget(IntroController controller, Widget child) {
//   return Intro(
//       controller: controller,
//       cardDecoration: IntroCardDecoration(
//         tapBarrierToContinue: true,
//         showPreviousButton: true,
//         previousButtonStyle: ButtonStyle(
//           backgroundColor:
//               MaterialStateColor.resolveWith((states) => Colors.lightBlue),
//           shape: MaterialStateProperty.resolveWith(
//               (states) => const RoundedRectangleBorder()),
//         ),
//         nextButtonStyle: ButtonStyle(
//           backgroundColor:
//               MaterialStateColor.resolveWith((states) => Colors.lightBlue),
//           shape: MaterialStateProperty.resolveWith(
//               (states) => const RoundedRectangleBorder()),
//         ),
//         closeButtonStyle: ButtonStyle(
//           backgroundColor:
//               MaterialStateColor.resolveWith((states) => Colors.lime),
//           shape: MaterialStateProperty.resolveWith(
//               (states) => const RoundedRectangleBorder()),
//         ),
//       ),
//       topLayerBuilder: (context, controller) {
//         return Padding(
//           padding: const EdgeInsets.only(top: 40, left: 20),
//           child: TextButton(
//             onPressed: controller.close,
//             style: ButtonStyle(
//               foregroundColor:
//                   MaterialStateColor.resolveWith((states) => Colors.white70),
//               backgroundColor:
//                   MaterialStateColor.resolveWith((states) => Colors.white24),
//             ),
//             child: const Text("Stop Tour"),
//           ),
//         );
//       },
//       child: child);
// }