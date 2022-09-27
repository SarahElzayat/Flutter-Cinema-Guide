import 'package:cinema_app/constants/endpoints.dart';
import 'package:cinema_app/models/movies/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _expanded = false;
  var _isMovies = true;
  final movie_obj = Movie.fromJson(JSON);
  final _genres = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Family',
    'Fantasy',
    'History',
    'Horror',
    'Music',
  ];

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
                            child: MultiSelectBottomSheetField(
                              initialChildSize: 0.4,
                              backgroundColor: Colors.grey[700],
                              searchable: true,
                              buttonText: Text("Choose Genres",
                                  style: Theme.of(context).textTheme.bodyText1),
                              title: const Text("Genres"),
                              items: _genres
                                  .map((e) => MultiSelectItem(e, e))
                                  .toList(growable: false),
                              listType: MultiSelectListType.CHIP,
                              onConfirm: (values) {
                                print(values);
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
                              initialRating: 7,
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
                                setState(() {
                                  print(rating);
                                });
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
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.black26,
                      clipBehavior: Clip.antiAlias,
                      child: Container(
                        height: 120,
                        padding: const EdgeInsets.all(0),
                        color: Colors.black26,
                        child: Row(children: [
                          Expanded(
                            flex: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          movie_obj.movieImage ?? ''),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 20,
                            child: Container(
                              padding: const EdgeInsets.only(top: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(movie_obj.movieTitle ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              color: Colors.white
                                                  .withOpacity(.9))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    movie_obj.movieDescription ?? '',
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                          color: Colors.grey[500],
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          Expanded(
                            flex: 6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber[700],
                                  size: 50,
                                ),
                                Text(
                                  movie_obj.movieRating.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
