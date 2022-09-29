import 'package:cinema_app/constants/endpoints.dart';
import 'package:cinema_app/dio_helper.dart';
import 'package:cinema_app/models/cinema/movie.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../models/cinema/cinema.dart';
import '../widgets/movie_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _expanded = false;
  String _chosenTitle = "";

  List<Movie>? _moviesResults;
  List<Cinema>? _cinemasResults;

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

  void getSearchResults() {
    if (_chosenTitle.isEmpty) return;
    getCinemaResults(title: _chosenTitle).then(
      (value) {
        setState(() {
          _cinemasResults = value;
        });
      },
    );

    getMoviesResults(title: _chosenTitle).then((value) {
      setState(() {
        _moviesResults = value;
      });
    });
  }

  Future<List<Movie>> getMoviesResults({
    required String? title,
  }) async {
    List<Movie> movies = [];
    Map<String, dynamic> q = {'movie_title': title, 'order': '-rating'};

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
