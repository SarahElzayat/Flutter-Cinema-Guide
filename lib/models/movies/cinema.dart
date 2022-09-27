class Cinema {
  int? id;
  String? cinemaName;
  String? cinemaLink;

  Cinema({this.id, this.cinemaName, this.cinemaLink});

  factory Cinema.fromJson(Map<String, dynamic> json) => Cinema(
        id: json['id'] as int?,
        cinemaName: json['cinema_name'] as String?,
        cinemaLink: json['cinema_link'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'cinema_name': cinemaName,
        'cinema_link': cinemaLink,
      };
}
