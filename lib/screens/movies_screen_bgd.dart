import 'package:cinema_app/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../constants/endpoints.dart';
import '../dio_helper.dart';
import '../models/cinema/movie.dart';

class Movies extends StatefulWidget {
  const Movies({super.key, required this.allMoviesList});
  final List<Movie> allMoviesList;

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<String?> _chosenGenres = [];
  double _chosenRating = 7.0;
  final List<String> _genres = [];
  List<Movie> _moviesList = [];
  bool _isFiltered = false;
  @override
  void initState() {
    super.initState();
    // copy content of the original List
    _moviesList = [...widget.allMoviesList];
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
          if (_isFiltered)
            IconButton(
                onPressed: () {
                  setState(() {
                    _isFiltered = false;
                    _moviesList = [...widget.allMoviesList];
                    _chosenGenres.clear();
                    _chosenRating = 7.0;
                  });
                },
                icon: const FaIcon(FontAwesomeIcons.filterCircleXmark)),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => filterDialog(context));
              },
              icon: const FaIcon(FontAwesomeIcons.filter)),
        ],
      ),
      body: ListView.builder(
        itemCount: _moviesList.length,
        itemBuilder: (context, index) =>
            saraMovieCard(context, _moviesList[index]),
      ),
    );
  }

  Dialog filterDialog(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 123, 33, 27),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: Theme.of(context).splashColor,
                  width: 1,
                ),
              ),
              child: MultiSelectBottomSheetField<String?>(
                initialChildSize: 0.5,
                initialValue: _chosenGenres,
                decoration: const BoxDecoration(),
                backgroundColor: const Color.fromARGB(255, 101, 101, 101),
                separateSelectedItems: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
            Text("  Min Rating", style: Theme.of(context).textTheme.bodyText1),
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
                itemSize: 25.0,
                onRatingUpdate: (rating) {
                  _chosenRating = rating;
                },
              ),
            ),
            // const Spacer(),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).splashColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ),
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                  flex: 5,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).splashColor,
                    ),
                    onPressed: () {
                      getMoviesResults(
                              genres: _chosenGenres, rating: _chosenRating)
                          .then((value) {
                        setState(() {
                          _moviesList = value;

                          _isFiltered = true;
                        });
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Apply"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Movie>> getMoviesResults(
      {required List<String?>? genres, required double? rating}) async {
    List<Movie> movies = [];
    Map<String, dynamic> q = {};
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
