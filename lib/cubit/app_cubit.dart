import 'package:cinema_app/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cinema_app/screens/main_screen.dart';
import 'package:cinema_app/screens/search_screen.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/endpoints.dart';
import '../helpers/dio_helper.dart';
import '../models/cinema/cinema.dart';
import '../models/cinema/movie.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  int currentIndex = 0;
  List<Widget> bottomNavBarItems = [
    const MainScreen(),
    const SearchScreen(),
    const WatchlistScreen()
  ];

  final List<Movie> _moviesList = [];
  final List<Cinema> _cinemasList = [];
  final Map<int, Movie> _moviesMap = {};
  List<int> favorites = [];
  final Map<int, Cinema> _cinemasMap = {};

  List<Movie> get moviesList => _moviesList;
  List<Cinema> get cinemasList => _cinemasList;
  Map<int, Movie> get moviesMap => _moviesMap;
  Map<int, Cinema> get cinemasMap => _cinemasMap;

  late Database database;

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

  void createDatabase() {
    openDatabase('favorites.db', version: 1, onCreate: (database, version) {
      print('created');
      database
          .execute(
              'CREATE TABLE favorites (id INTEGER PRIMARY KEY)') //, title TEXT, date TEXT,time TEXT, status TEXT )')
          .then((value) {
        print('table creted');
      }).catchError((onError) {
        print('error');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('Opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertIntoDatabase({
    required int id,
    // required String date,
    // required String time,
  }) async {
    await database.transaction((txn) {
      txn.rawInsert('INSERT INTO favorites(id) VALUES ("$id")').then((value) {
        print('${value.toString()} inserted successfully');
        emit(AppInsertIntoDataState());
        getDataFromDatabase(database);
      }).catchError((onError) {
        print('error occurred {$onError.toString()}');
      });
      return Future(() => null);
    });
  }

  void getDataFromDatabase(database) {
    favorites.clear();
    emit(AppLoadingState());
    List<Map> favs;
    database.rawQuery("SELECT * FROM favorites").then((value) {
      favs = value;
      print(value.toString());
      emit(AppGetDatabaseState());
      // favorites.addAll(favs);
      favs.forEach((element) {
        favorites.add(element['id']);
      });

    });
  }

  // void updateData({required String status, required int id}) async {
  //   database.rawUpdate(
  //       'UPDATE tasks SET status = ? WHERE id = ?', [status, id]).then((value) {
  //     getDataFromDatabase(database);
  //     emit(AppUpdateDatabaseState());
  //   });
  // }

  void deleteData({required int id}) async {
    database
        .rawDelete('DELETE FROM favorites WHERE id = ?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
