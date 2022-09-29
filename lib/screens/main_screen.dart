// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:blur/blur.dart';
import 'package:cinema_app/components/components.dart';
import 'package:cinema_app/constants/endpoints.dart';
import 'package:cinema_app/dio_helper.dart';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

import '../models/movies/movie.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  // late TabController _tabController;
  List? movies_list;
  final int itemCount = 5;
  List<Movie>? list = [];

  @override
  void initState() {
    super.initState();

    DioHelper.getData(path: MOVIES).then((value) {
      setState(() {
        movies_list = value.data;
        value.data!.forEach((element) {
          list!.add(Movie.fromJson(element));
        });
      });
      print(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: ConditionalBuilder(
          condition: movies_list != null,
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
          builder: (context) => SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18, top: 18),
                    child: Text(
                      'Now showing',
                      style: Theme.of(context).textTheme.headline1,
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
                            return showMore(context, list);
                          }
                          return movieBuilder(context, list![index]);
                        }),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
