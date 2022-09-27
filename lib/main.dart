import 'package:cinema_app/dio_helper.dart';
import 'package:cinema_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_generator/material_color_generator.dart';

void main() {
  DioHelper.init();
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
        scaffoldBackgroundColor: Colors.black87,
        iconTheme: IconThemeData(color: Colors.white, size: 27),
        textTheme: TextTheme(
          headline1: GoogleFonts.roboto(
              color: Colors.white,
              // backgroundColor: Colors.black87,
              fontSize: 25),
          //headline2 for movies names
          headline2: GoogleFonts.roboto(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 17),
          headline3: GoogleFonts.roboto(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
          bodyText1: GoogleFonts.roboto(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 18),
        ),
        primarySwatch: generateMaterialColor(
          color: Color.fromARGB(255, 113, 34, 28),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
