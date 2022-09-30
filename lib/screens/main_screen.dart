import 'dart:math';

import 'package:cinema_app/components/components.dart';
import 'package:cinema_app/constants/endpoints.dart';
import 'package:cinema_app/cubit/app_cubit.dart';
import 'package:cinema_app/dio_helper.dart';
import 'package:cinema_app/models/cinema/cinema.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/cinema/movie.dart';
import 'movies_screen_bgd.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});
  final int itemCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            List<Movie> moviesList = AppCubit.get(context).moviesList;
            List<Cinema> cinemasList = AppCubit.get(context).cinemasList;
            var cinemaMap = AppCubit.get(context).cinemasMap;
            return ConditionalBuilder(
              condition: moviesList.isNotEmpty,
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
                                builder: (context) =>
                                    Movies(allMoviesList: moviesList),
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
                            itemCount: min(itemCount, moviesList.length),
                            shrinkWrap: true,
                            itemExtent: 200,
                            itemBuilder: (context, index) {
                              if (index == itemCount - 1) {
                                return showMore(context, moviesList);
                              }
                              return moviescrollCard(
                                  context, moviesList[index]);
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
                                builder: (context) =>
                                    Movies(allMoviesList: moviesList),
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
                            itemCount: min(itemCount, cinemasList.length),
                            shrinkWrap: true,
                            // itemExtent: 200,
                            itemBuilder: (context, index) {
                              if (index == itemCount - 1) {
                                return showMore(context, moviesList);
                              }
                              return cinemaScrollCard(
                                  context, cinemasList[index]);
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
