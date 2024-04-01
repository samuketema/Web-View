import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatefulWidget {
  final String initialUrl;

  WebViewScreen({required this.initialUrl});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  TextEditingController _searchController = TextEditingController();
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  
  String currentUrl = '';

  void initState(){
    super.initState();
    currentUrl = widget.initialUrl;
  }

  void _performSearch(String query){
    String searchUrl;
     if(Uri.tryParse(query)?.hasAbsolutePath??false){
      searchUrl = query;
     }
     else{
      searchUrl = 'https://facebook.com/search?q=$query';
     }
    setState(() {
      currentUrl = searchUrl;
    });

    _controller.future.then((value) {
      print('Loading URL: $currentUrl');
      
       value.loadUrl(Uri.parse(currentUrl).toString()); 
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebView App'), // Customize the title
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              initialUrl: currentUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onPageFinished: (url) {
                print('Page loaded: $url');
              },
              onWebResourceError: (error) {
                print('WebView error: ${error.description}');
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
                      _performSearch(value);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Trigger search action when the search icon is pressed
                    // You can use _searchController.text as the search query.
                    _performSearch(_searchController.text);
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