import 'package:cinema_app/cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

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
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(5),
                child: GNav(
                    selectedIndex: cubit.currentIndex,
                    onTabChange: (index) {
                      cubit.changeIndex(index);
                    },
                    backgroundColor: Colors.transparent,
                    // rippleColor:Colors.grey[800]!, // tab button ripple color when pressed
                    hoverColor: Colors.grey[700]!, // tab button hover color
                    tabBorderRadius: 15,
                    curve: Curves.easeInExpo, // tab animation curves
                    duration: const Duration(
                        milliseconds: 500), // tab animation duration
                    gap: 8, // the tab button gap between icon and text
                    color: Colors.grey[800], // unselected icon color
                    activeColor: Colors.blue, // selected icon and text color
                    iconSize: 24, // tab button icon size
                    tabBackgroundColor: Colors.blue
                        .withOpacity(0.1), // selected tab background color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8), // navigation bar padding
                    tabs: const [
                      GButton(
                        icon: LineIcons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: LineIcons.heart,
                        text: 'Likes',
                      ),
                      GButton(
                        icon: LineIcons.search,
                        text: 'Search',
                      ),
                    ]),
              ));
        },
      ),
    );
  }
}
