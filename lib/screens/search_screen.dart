import 'package:cinema_app/constants/endpoints.dart';
import 'package:cinema_app/dio_helper.dart';
import 'package:cinema_app/models/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _expanded = false;
  var _isMovies = true;
  String _chosenTitle = "";
  List<String?> _chosenGenres = [];
  double _chosenRating = 7.0;

  final List<String> _genres = [];
  List<Movie>? _moviesResults;
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
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search ${_isMovies ? "Movies" : "Cinames"}',
                        icon: const Icon(Icons.search),
                      ),
                      onChanged: (value) {
                        _chosenTitle = value;
                      },
                      onSubmitted: (value) {
                        getMoviesResults(
                                title: _chosenTitle,
                                genres: _chosenGenres,
                                rating: _chosenRating)
                            .then((value) {
                          setState(() {
                            _moviesResults = value;
                          });
                        });
                      },
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          _expanded = !_expanded;
                        });
                      },
                      icon: Icon(
                          _expanded ? Icons.expand_less : Icons.expand_more,
                          color: Colors.grey[600],
                          size: 30))
                ],
              ),
            ),
            if (_expanded)
              Column(
                children: [
                  Container(
                    // clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: _isMovies
                                        ? Theme.of(context).primaryColor
                                        : const Color.fromARGB(
                                            255, 30, 30, 30)),
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
                                ))),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
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
                                child: Text(
                                  "Cinames",
                                  style: TextStyle(color: Colors.white),
                                ))),
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
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: MultiSelectBottomSheetField<String?>(
                              initialChildSize: 0.4,
                              backgroundColor: Colors.grey[700],
                              searchable: true,
                              buttonText: Text("Choose Genres",
                                  style: Theme.of(context).textTheme.bodyText1),
                              title: const Text("Genres"),
                              items: _genres
                                  .map((e) => MultiSelectItem(e, e))
                                  .toList(),
                              listType: MultiSelectListType.CHIP,
                              onConfirm: (values) {
                                _chosenGenres = values;
                                print(_chosenGenres);
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
            Expanded(
              child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount:
                      _moviesResults == null ? 0 : _moviesResults!.length,
                  itemBuilder: (context, index) {
                    return movieCard(context, _moviesResults![index]);
                  }),
            )
          ],
        ),
      ),
    );
  }

//GET /api/movies/?movie_title=ah&movie_genres=Science+Fiction&movie_genres=Thriller&movie_genres=Musical&movie_rating=5.0

  Future<List<Movie>> getMoviesResults(
      {required String? title,
      required List<String?> genres,
      required double? rating}) async {
    List<Movie> movies = [];
    await DioHelper.getData(path: MOVIES, query: {
      'movie_title': title,
      'movie_genres': genres,
      'movie_rating': rating
    }).then((value) {
      for (var e in value.data) {
        print(e);
        movies.add(Movie.fromJson(e));
      }
      print(movies);
      return movies;
    });
    return movies;
  }
}
