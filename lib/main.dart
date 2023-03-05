import 'package:flutter/material.dart';
import 'package:intro/intro.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view/home_screen.dart';
import 'package:todo_app/view/splash_screen.dart';
import 'package:todo_app/view/widgets/intro_widget.dart';

import 'model/provider/data_provider.dart';
import 'model/provider/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider()),
          ChangeNotifierProvider(create: (context) => DataProvider()),
        ],
        child: IntroWidget(
          controller: IntroController(stepCount: 6),
          child: const MyApp(),
        )),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo APP',
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.black,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith(
                (states) => Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black),
          color: Colors.white,
          foregroundColor: Colors.black,
        ),
        cardColor: Colors.white,
        colorScheme: const ColorScheme.light(),
        iconTheme: const IconThemeData(opacity: 0.8, color: Colors.black),
      ),
      themeMode: Provider.of<ThemeProvider>(context).themeMode,
      darkTheme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              side: BorderSide(width: 1, color: Colors.black),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
          ),
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateColor.resolveWith(
                (states) => Colors.white,
          ),
        ),
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white),
          color: Colors.black,
        ),
        cardColor: Colors.black,
        primaryColor: Colors.white,
        colorScheme: const ColorScheme.dark(),
        iconTheme: const IconThemeData(opacity: 0.8, color: Colors.white),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        // HomeScreen.id: (context) =>  HomeScreen(),
        SplashScreen.id: (context) => const SplashScreen(),
      },
    );
  }
}


