import 'package:cinema_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_flutter/bottom_sheet/multi_select_bottom_sheet_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../constants/endpoints.dart';
import '../dio_helper.dart';
import '../models/movies/movie.dart';

class Movies extends StatefulWidget {
  Movies({super.key, required this.allMoviesList});
  final List<Movie> allMoviesList;

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<String?> _chosenGenres = [];
  double _chosenRating = 7.0;
  final List<String> _genres = [];

  @override
  void initState() {
    super.initState();
    DioHelper.getData(path: GENRES).then((value) {
      for (var element in value.data) {
        _genres.add(element as String);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Movies'),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.movie_filter_outlined),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => tailingContainer(context));
              },
              icon: const FaIcon(FontAwesomeIcons.filter))
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, index) =>
            SaraMovieCard(context, widget.allMoviesList[index]),
      ),
    );
  }

  Dialog tailingContainer(BuildContext context) {
    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: Container(
        height: 300,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 123, 33, 27),
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: MultiSelectBottomSheetField<String?>(
                  initialChildSize: 0.4,
                  backgroundColor: const Color.fromARGB(255, 101, 101, 101),
                  searchable: true,
                  buttonText: Text("Choose Genres",
                      style: Theme.of(context).textTheme.bodyText1),
                  title: const Text("Genres"),
                  items: _genres.map((e) => MultiSelectItem(e, e)).toList(),
                  listType: MultiSelectListType.CHIP,
                  onConfirm: (values) {
                    _chosenGenres = values;
                  },
                  chipDisplay: MultiSelectChipDisplay(
                    // the displayed chips after selection
                    onTap: (value) {},
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text("  Min Rating",
                  style: Theme.of(context).textTheme.bodyText1),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: RatingBar.builder(
                  initialRating: _chosenRating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 10,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemSize: 30.0,
                  onRatingUpdate: (rating) {
                    _chosenRating = rating;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Movie>> getMoviesResults(
      {required String? title,
      required List<String?>? genres,
      required double? rating}) async {
    List<Movie> movies = [];
    Map<String, dynamic> q = {'movie_title': title, 'order': '-rating'};
    if (genres != null) q['movie_genres'] = genres;
    if (rating != null) q['movie_rating'] = rating;

    await DioHelper.getData(path: MOVIES, query: q).then((value) {
      for (var e in value.data) {
        movies.add(Movie.fromJson(e));
      }
      return movies;
    });
    return movies;
  }
}
