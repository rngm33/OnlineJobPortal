import 'package:flutter/material.dart';
import 'package:online_job_portal/Screens/profile_view.dart';
import 'package:online_job_portal/Screens/school_list.dart';
import 'package:online_job_portal/main.dart';

class HomeNavigator extends StatefulWidget {
  const HomeNavigator({super.key});

  @override
  State<HomeNavigator> createState() => _HomeNavigatorState();
}

class _HomeNavigatorState extends State<HomeNavigator> {
   @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              
              switch (settings.name) {
                case '/':
                  return const MyWidget();
                // case '/books2':
                //   return Books2();
              }
              throw '';
            
            });
      },
    );
  }
}


