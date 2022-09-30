import 'dart:math';

import 'package:cinema_app/constants/endpoints.dart';
import 'package:cinema_app/helpers/dio_helper.dart';
import 'package:cinema_app/models/cinema/movie.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import '../models/cinema/cinema.dart';
import '../widgets/movie_card.dart';
import 'cinema_view.dart';

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
      resizeToAvoidBottomInset: false,
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
                color: Theme.of(context).primaryColor.withOpacity(.7),
                borderRadius: BorderRadius.circular(10),
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
                      child: Icon(
                    Icons.manage_search_rounded,
                    size: 150,
                    color: Colors.white70.withOpacity(.5),
                  )),
                );
              },
              builder: (context) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (_cinemasResults != null)
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(children: [
                              ...List.generate(
                                min(4, _cinemasResults!.length),
                                (index) => cinemaCard(
                                    _cinemasResults![index], context),
                              ),
                            ]),
                          ),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
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
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cinemaCard(Cinema c, BuildContext context) {
    return InkWell(
      onTap: () {
        // navigate to CinemaView
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CinemaView(
                      cinema: c,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        padding: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context)
                .primaryColor
                .withOpacity(.7) //const Color.fromARGB(255, 123, 33, 27),
            ),
        child: Row(
          children: [
            const Icon(Icons.movie_filter_outlined),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                c.cinemaName!,
                style: Theme.of(context).textTheme.headline2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 20,
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
