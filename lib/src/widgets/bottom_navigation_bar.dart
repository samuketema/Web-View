import 'package:flutter/material.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(data: Theme.of(context).copyWith(
      canvasColor: Color.fromARGB(255, 165, 165, 2),
    ),
    child:BottomNavigationBar(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'add',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
       BottomNavigationBarItem(
          icon: Icon(Icons.person ),
          label: 'profile',
        ),
      ],
      onTap: (index) {
        //  Handle navigation based on the index (e.g., switch screens).
      },
    ));
  }
}
