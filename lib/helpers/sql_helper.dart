import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String tableFavorites = 'favorites';
const String columnMovieId = 'movie_id';
const String columnMovieTitle = 'movie_title';

class Favorite {
  int? movieId;
  String? movieTitle;

  Favorite({
    this.movieId,
    this.movieTitle,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        movieId: json[columnMovieId] as int?,
        movieTitle: json[columnMovieTitle] as String?,
      );

  Map<String, dynamic> toJson() => {
        columnMovieId: movieId,
        columnMovieTitle: movieTitle,
      };
}

class FavoriteProvider {
  Database? db;

  Future open() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'favorites.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE $tableFavorites($columnMovieId INTEGER PRIMARY KEY, $columnMovieTitle TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<Favorite> insert(Favorite favorite) async {
    favorite.movieId = await db!.insert(tableFavorites, favorite.toJson());
    return favorite;
  }

  Future<Favorite> getFavorite(int id) async {
    List<Map<String, dynamic>> maps = await db!.query(
      tableFavorites,
      columns: [columnMovieId, columnMovieTitle],
      where: '$columnMovieId = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Favorite.fromJson(maps.first);
    } else {
      throw Exception('Favorite not found');
    }
  }

  Future<List<Favorite>> getAllFavorites() async {
    final List<Map<String, dynamic>> maps = await db!.query(tableFavorites);

    return List.generate(maps.length, (i) {
      return Favorite(
        movieId: maps[i][columnMovieId],
        movieTitle: maps[i][columnMovieTitle],
      );
    });
  }

  Future<int> delete(int id) async {
    return await db!.delete(
      tableFavorites,
      where: '$columnMovieId = ?',
      whereArgs: [id],
    );
  }

  // delete all rows
  Future<void> deleteAll() async {
    await db!.delete(tableFavorites);
  }

  Future<int> update(Favorite favorite) async {
    return await db!.update(
      tableFavorites,
      favorite.toJson(),
      where: '$columnMovieId = ?',
      whereArgs: [favorite.movieId],
    );
  }

  Future close() async => db!.close();
}
