// main.dart

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My WebView App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewScreen(initialUrl: 'https://www.github.com'), // Replace with your URL
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String initialUrl;

  WebViewScreen({required this.initialUrl});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My WebView App'), // Customize the title
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: widget.initialUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: (url) {
                // Handle page load completion (e.g., hide progress bar)
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                    ),
                    onSubmitted: (value) {
                      // Handle search action (e.g., load a new URL)
                      // You can use value (the search query) here.
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Trigger search action when the search icon is pressed
                    // You can use _searchController.text as the search query.
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
            icon: Icon(Icons.search),
            label: 'Search',
          ),
           
          // Add more items as needed
        ],
        // Handle navigation logic based on the selected item.
        // For example, navigate to different screens when an item is tapped.
        onTap: (index) {
          // Handle navigation based on the index (e.g., switch screens).
        },
      ),
    );
  }
}