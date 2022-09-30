class Movie {
  int? id;
  String? movieTitle;
  String? movieDescription;
  String? movieImage;
  List<String>? movieGenres;
  String? movieLinkId;
  double? movieRating;
  List<int>? cinema;

  Movie({
    this.id,
    this.movieTitle,
    this.movieDescription,
    this.movieImage,
    this.movieGenres,
    this.movieLinkId,
    this.movieRating,
    this.cinema,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] as int?,
        movieTitle: json['movie_title'] as String?,
        movieDescription: json['movie_description'] as String?,
        movieImage: json['movie_image'] as String?,
        movieGenres: json['movie_genres'].cast<String>() as List<String>?,
        movieLinkId: json['movie_link_id'] as String?,
        movieRating: (json['movie_rating'] as num?)?.toDouble(),
        cinema: json['cinema'].cast<int>() as List<int>?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'movie_title': movieTitle,
        'movie_description': movieDescription,
        'movie_image': movieImage,
        'movie_genres': movieGenres,
        'movie_link_id': movieLinkId,
        'movie_rating': movieRating,
        'cinema': cinema,
      };
}
