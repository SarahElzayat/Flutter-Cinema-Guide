import 'package:cinema_app/cubit/app_cubit.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = AppCubit.get(context);

          return Scaffold(
            extendBody: true,
            backgroundColor: Colors.white,
            body: cubit.bottomNavBarItems[cubit.currentIndex],
            bottomNavigationBar: CurvedNavigationBar(
              color: Colors.blue,
              index: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              backgroundColor: Colors.transparent,
              height: 50,
              animationDuration: Duration(milliseconds: 300),
              items: const [
                Icon(Icons.theater_comedy_outlined),
                Icon(
                  Icons.movie_filter_outlined,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
