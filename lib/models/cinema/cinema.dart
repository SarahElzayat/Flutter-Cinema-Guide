import 'movie.dart';

class Cinema {
  String? cinemaName;
  String? cinemaLink;
  List<Movie>? movies;

  Cinema({this.cinemaName, this.cinemaLink, this.movies});

  factory Cinema.fromJson(Map<String, dynamic> json) => Cinema(
        cinemaName: json['cinema_name'] as String?,
        cinemaLink: json['cinema_link'] as String?,
        movies: (json['movies'] as List<dynamic>?)
            ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'cinema_name': cinemaName,
        'cinema_link': cinemaLink,
        'movies': movies?.map((e) => e.toJson()).toList(),
      };
}