class Cinema {
  int? id;
  String? cinemaName;
  String? cinemaLink;
  String? cinemaAddress;
  String? cinemaImage;
  List<int>? movies;

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
        movies: (json['movies'].cast<int>() as List<int>?),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cinema_name': cinemaName,
        'cinema_link': cinemaLink,
        'movies': movies,
        'cinema_image': cinemaImage,
        'cinema_address': cinemaAddress,
      };
}
