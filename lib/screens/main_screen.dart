import 'package:cinema_app/components/components.dart';
import 'package:cinema_app/constants/endpoints.dart';
import 'package:cinema_app/dio_helper.dart';
import 'package:cinema_app/models/cinema/cinema.dart';
import 'package:cinema_app/screens/cinemas.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../models/cinema/movie.dart';
import 'movies_screen_bgd.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  List? _moviesList;
  final int itemCount = 5;
  List<Movie>? list = [];
  List<Cinema>? cinemas = [];

  @override
  void initState() {
    super.initState();

    DioHelper.getData(path: MOVIES).then((value) {
      setState(() {
        _moviesList = value.data;
        value.data!.forEach((element) {
          list!.add(Movie.fromJson(element));
        });
      });
    });
    DioHelper.getData(path: CINEMAS).then((value) {
      setState(() {
        // _moviesList = value.data;
        value.data!.forEach((element) {
          cinemas!.add(Cinema.fromJson(element));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: ConditionalBuilder(
          condition: _moviesList != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 18),
                    child: MaterialButton(
                      // padding: EdgeInsets.all(15),
                      color: Theme.of(context).primaryColor.withOpacity(.7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Movies(allMoviesList: list!),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Now showing',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: itemCount,
                        shrinkWrap: true,
                        itemExtent: 200,
                        itemBuilder: (context, index) {
                          if (index == itemCount - 1) {
                            return showMoreMovies(context, list);
                          }
                          return movieBuilder(context, list![index]);
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 18),
                    child: MaterialButton(
                      // padding: EdgeInsets.all(15),
                      color: Theme.of(context).primaryColor.withOpacity(.7),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CinemasScreen(
                              cinemas: cinemas,
                            ),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Cinemas',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: cinemas!.length,
                        shrinkWrap: true,
                        // itemExtent: 200,
                        itemBuilder: (context, index) {
                          if (index == itemCount - 1) {
                            return showMoreCinemas(context, cinemas);
                          }
                          return cinemasBuilder(context, cinemas![index]);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
