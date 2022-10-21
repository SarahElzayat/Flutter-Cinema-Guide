part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class ChangeBottomNavBarState extends AppState {}

class getMoviesDataSuccessState extends AppState {}

class getMoviesDataErrorState extends AppState {}

class getCinemasDataSuccessState extends AppState {}

class getCinemasDataErrorState extends AppState {}

class getFavoritesDataSuccessState extends AppState {}

class getFavoritesDataErrorState extends AppState {}


class AppCreateDatabaseState extends AppState {}



class AppInsertIntoDataState extends AppState {}

class AppLoadingState extends AppState {}

class AppGetDatabaseState extends AppState {}

class AppDeleteDatabaseState extends AppState {}
