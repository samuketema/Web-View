import 'package:flutter/material.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color.fromARGB(255, 146, 146, 2),
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
          label: 'Search',
        ),
      ],
      onTap: (index) {
        // Handle navigation based on the index (e.g., switch screens).
      },
    );
  }
}
