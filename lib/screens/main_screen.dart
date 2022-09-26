import 'package:cinema_app/screens/cinemas.dart';
import 'package:cinema_app/screens/movies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.grey,
                labelStyle: Theme.of(context).textTheme.bodyText1,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(
                    text: 'Cinemas',
                  ),
                  Tab(
                    text: 'Movies',
                  ),
                ],
              ),
               Container(
                height: MediaQuery.of(context).size.height,
                 child: TabBarView(
                  
                   controller: _tabController,
                   children:const [
                     CinemasScreen(),
                     MoviesScreen()
                   ],
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
