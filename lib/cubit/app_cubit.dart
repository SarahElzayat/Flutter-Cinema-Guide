import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cinema_app/screens/main_screen.dart';
import 'package:cinema_app/screens/search_screen.dart';

import '../constants/endpoints.dart';
import '../dio_helper.dart';
import '../models/cinema/cinema.dart';
import '../models/cinema/movie.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  int currentIndex = 0;
  List<Widget> bottomNavBarItems = [
    MainScreen(),
    SearchScreen(),
    SearchScreen()
  ];

  final List<Movie> _moviesList = [];
  final List<Cinema> _cinemasList = [];
  final Map<int, Movie> _moviesMap = {};
  final Map<int, Cinema> _cinemasMap = {};

  List<Movie> get moviesList => _moviesList;
  List<Cinema> get cinemasList => _cinemasList;
  Map<int, Movie> get moviesMap => _moviesMap;
  Map<int, Cinema> get cinemasMap => _cinemasMap;

  static AppCubit get(context) => BlocProvider.of(context);

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

  void getMoviesAndCinemaData() {
    // inserting
    DioHelper.getData(path: MOVIES).then((value) {
      value.data!.forEach((element) {
        var m = Movie.fromJson(element);
        _moviesList.add(m);
        _moviesMap[m.id!] = m;
      });
      emit(getMoviesDataSuccessState());
    }).catchError((err) {
      emit(getMoviesDataErrorState());
    });

    DioHelper.getData(path: CINEMAS).then((value) {
      value.data!.forEach((element) {
        var c = Cinema.fromJson(element);
        _cinemasList.add(c);
        _cinemasMap[c.id!] = c;
      });
      emit(getCinemasDataSuccessState());
    }).catchError((err) {
      emit(getCinemasDataErrorState());
    });
  }
}
