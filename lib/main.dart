import 'package:cinema_app/cubit/app_cubit.dart';
import 'package:cinema_app/helpers/dio_helper.dart';
import 'package:cinema_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'bloc_observer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getMoviesAndCinemaData(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                scaffoldBackgroundColor: Colors.grey[900],
                iconTheme: const IconThemeData(color: Colors.white, size: 27),
                textTheme: TextTheme(
                  headline1:
                      GoogleFonts.roboto(color: Colors.white, fontSize: 25),
                  //headline2 for movies names
                  headline2: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 17),
                  headline3: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                  headline4: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 2),
                  bodyText1: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 18),
                  bodyText2: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                primarySwatch: generateMaterialColor(
                  color: const Color.fromARGB(255, 113, 34, 28),
                ),
                splashColor: Colors.black54),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
