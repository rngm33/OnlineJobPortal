import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_job_portal/Navigators/home_navigator.dart';
import 'package:online_job_portal/Screens/profile_view.dart';
import 'package:online_job_portal/Screens/school_list.dart';

class SchoolList extends StatefulWidget {
  SchoolList({Key? key}) : super(key: key);

  _SchoolListState createState() => _SchoolListState();
}

class _SchoolListState extends State<SchoolList> {
  final TextStyle dropdownMenuItem =
      const TextStyle(color: Colors.black, fontSize: 18);
  int _selectedIndex = 0;
  final primary = const Color(0xff696b9e);
  final secondary = const Color(0xfff29a94);
  var ctime;
  List<Widget> widgetList = [
    MyWidget(),
    myProfile(),
  ];

  Future<bool> _onWillPop() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          bottomNavigationBar: _buildBottomBar(),
          backgroundColor: const Color(0xfff0f0f0),
          body: IndexedStack(index: _selectedIndex, children: widgetList
              // children: <Widget>[
              //   HomeNavigator(),
              //   ProfileNavigator()
              // ],
              )),
    );
  }

  _onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _buildBottomBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: primary,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
      onTap: _onTappedItem,
    );
  }
}
