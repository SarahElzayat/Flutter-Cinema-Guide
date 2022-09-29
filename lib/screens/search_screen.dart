import 'dart:math';

import 'package:cinema_app/constants/endpoints.dart';
import 'package:cinema_app/dio_helper.dart';
import 'package:cinema_app/models/movies/movie.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import '../models/cinema/cinema.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _expanded = false;
  var _isMovies = true;
  String _chosenTitle = "";
  List<String?> _chosenGenres = [];
  double _chosenRating = 7.0;

  final List<String> _genres = [];
  List<Movie>? _moviesResults;
  List<Cinema>? _cinemasResults;
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
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              // margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(left: 10),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 123, 33, 27),
                borderRadius: _expanded
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))
                    : BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search Cinemas and Movies',
                        hintStyle: TextStyle(color: Colors.white70),
                        icon: Icon(
                          Icons.search,
                          color: Colors.white70,
                        ),
                      ),
                      onChanged: (value) {
                        _chosenTitle = value;
                        setState(() {
                          getSearchResults();
                        });
                      },
                      onSubmitted: (value) {
                        getSearchResults();
                      },
                    ),
                  ),
                ],
              ),
            ),
            ConditionalBuilder(
              condition: _chosenTitle.isNotEmpty,
              fallback: (context) {
                return Expanded(
                    child: Center(
                        child: Text("Start Typing to Search",
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(fontSize: 16))));
              },
              builder: (context) => Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (_cinemasResults != null)
                        ListView.separated(
                            primary: false,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemBuilder: (_, ind) =>
                                cinemaCard(_cinemasResults![ind], context),
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 1,
                              );
                            },
                            itemCount: _cinemasResults!.length),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          itemCount: _moviesResults == null
                              ? 0
                              : _moviesResults!.length,
                          itemBuilder: (context, index) {
                            return movieCard(context, _moviesResults![index]);
                          })
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cinemaCard(Cinema c, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      clipBehavior: Clip.antiAlias,
      color: const Color.fromARGB(100, 18, 18, 18),
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.black26,
        child: Row(
          children: [
            const Icon(Icons.movie_filter_outlined),
            const SizedBox(
              width: 10,
            ),
            Flexible(
              child: Text(
                c.cinemaName!,
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container tailingContainer(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 123, 33, 27),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            // clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 150,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          backgroundColor: _isMovies
                              ? Theme.of(context).primaryColor
                              : const Color.fromARGB(255, 30, 30, 30)),
                      onPressed: () {
                        if (!_isMovies) {
                          setState(() {
                            _isMovies = true;
                          });
                        }
                      },
                      child: const Text(
                        "Movies",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          backgroundColor: _isMovies
                              ? const Color.fromARGB(255, 30, 30, 30)
                              : Theme.of(context).primaryColor),
                      onPressed: () {
                        if (_isMovies) {
                          setState(() {
                            _isMovies = false;
                          });
                        }
                      },
                      child: const Text(
                        "Cinames",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
          if (_isMovies)
            Container(
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
                      itemSize: 35.0,
                      onRatingUpdate: (rating) {
                        _chosenRating = rating;
                      },
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void getSearchResults() {
    if (_chosenTitle.isEmpty) return;
    getCinemaResults(title: _chosenTitle).then(
      (value) {
        setState(() {
          _cinemasResults = value;
        });
      },
    );

    getMoviesResults(
            title: _chosenTitle,
            genres: _expanded ? _chosenGenres : null,
            rating: _expanded ? _chosenRating : null)
        .then((value) {
      setState(() {
        _moviesResults = value;
      });
    });
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

  Future<List<Cinema>> getCinemaResults({required String title}) async {
    List<Cinema> ret = [];
    await DioHelper.getData(path: CINEMAS, query: {'search': title})
        .then((value) {
      for (var e in value.data) {
        ret.add(Cinema.fromJson(e));
      }
      return ret;
    });
    return ret;
  }
}
