import 'package:bloc/bloc.dart';
import 'package:cinema_app/screens/main_screen.dart';
import 'package:cinema_app/screens/movies.dart';
import 'package:cinema_app/screens/cinemas.dart';
import 'package:cinema_app/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  int currentIndex = 0;
  List<Widget> bottomNavBarItems = const [MainScreen(),SearchScreen(),SearchScreen()];

    static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

}
