import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pmsn2024/screens/favorite_screen.dart';
import 'package:pmsn2024/screens/popular_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {



  List<Widget> _screen = <Widget>[
    PopularScreen(),
    FavoriteWidget(),
  ];
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: _selectedIndex == 0 ? true : false,
      extendBody: true,
      backgroundColor: Colors.black87,
      appBar: AppBar(
        
        backgroundColor: Colors.transparent,
        elevation: 5,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
            
          ),
        ),
        title: const Text(
          "RS Video",
          style: TextStyle(color: Colors.white),
        ),
        actions: const [
          Icon(
            Icons.search,
            color: Colors.white,
            
          )
          
        ],
      ),
      body: _screen.elementAt(_selectedIndex),
      bottomNavigationBar: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Container(
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                )
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Color.fromARGB(255, 236, 19, 19),
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              elevation: 0,
              unselectedItemColor: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
