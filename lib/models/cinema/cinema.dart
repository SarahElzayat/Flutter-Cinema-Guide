import 'movie.dart';

class Cinema {
  int? id;
  String? cinemaName;
  String? cinemaLink;
  String? cinemaAddress;
  String? cinemaImage;
  List<Movie>? movies;

  Cinema(
      {this.id,
      this.cinemaName,
      this.cinemaLink,
      this.movies,
      this.cinemaImage,
      this.cinemaAddress});

  factory Cinema.fromJson(Map<String, dynamic> json) => Cinema(
        id: json['id'] as int?,
        cinemaName: json['cinema_name'] as String?,
        cinemaLink: json['cinema_link'] as String?,
        cinemaAddress: json['cinema_address'] as String?,
        cinemaImage: json['cinema_image'] as String?,
        movies: (json['movies'] as List<dynamic>?)
            ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cinema_name': cinemaName,
        'cinema_link': cinemaLink,
        'movies': movies?.map((e) => e.toJson()).toList(),
        'cinema_image': cinemaImage,
        'cinema_address': cinemaAddress,
      };
}
