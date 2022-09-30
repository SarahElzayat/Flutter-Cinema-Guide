import 'package:cinema_app/components/components.dart';
import 'package:cinema_app/models/cinema/cinema.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CinemasScreen extends StatelessWidget {
  const CinemasScreen({super.key, this.cinemas});
  final List<Cinema>? cinemas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: const [
              Text('Cinemas'),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.theater_comedy_rounded,
                size: 27,
              ),
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: cinemas!.length,
            itemExtent: 200,
            itemBuilder: (context, index) =>
                cinemasBuilder(context, cinemas![index])),
    );
  }
}
