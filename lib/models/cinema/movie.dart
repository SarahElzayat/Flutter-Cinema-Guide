import 'cinema.dart';

class Movie {
  String? movieTitle;
  String? movieDescription;
  String? movieImage;
  List<String>? movieGenres;
  String? movieLinkId;
  double? movieRating;
  List<Cinema>? cinema;

  Movie({
    this.movieTitle,
    this.movieDescription,
    this.movieImage,
    this.movieGenres,
    this.movieLinkId,
    this.movieRating,
    this.cinema,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        movieTitle: json['movie_title'] as String?,
        movieDescription: json['movie_description'] as String?,
        movieImage: json['movie_image'] as String?,
        movieGenres: json['movie_genres'] as List<String>?,
        movieLinkId: json['movie_link_id'] as String?,
        movieRating: (json['movie_rating'] as num?)?.toDouble(),
        cinema: (json['cinema'] as List<dynamic>?)
            ?.map((e) => Cinema.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'movie_title': movieTitle,
        'movie_description': movieDescription,
        'movie_image': movieImage,
        'movie_genres': movieGenres,
        'movie_link_id': movieLinkId,
        'movie_rating': movieRating,
        'cinema': cinema?.map((e) => e.toJson()).toList(),
      };
}
