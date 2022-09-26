import 'package:cinema_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.white, size: 27),
        textTheme: TextTheme(
            headline1: GoogleFonts.roboto(
                color: Colors.white,
                backgroundColor: Colors.transparent,
                fontSize: 20)),

        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
