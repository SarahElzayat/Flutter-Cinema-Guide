import 'package:cinema_app/components/components.dart';
import 'package:cinema_app/cubit/app_cubit.dart';
import 'package:cinema_app/models/cinema/movie.dart';
import 'package:cinema_app/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(title: const Text("Watchlist")),
            body: cubit.favorites.isEmpty?
            const Center(
              child: Icon(
              LineIcons.thList
              , size: 100,
              color: Colors.grey,),
            ):
            ListView.builder(
              itemBuilder: (context, index) => saraMovieCard(
                  context, cubit.moviesMap[cubit.favorites[index]]!),
              itemCount: cubit.favorites.length,
            ));
      },
    );
  }
}
