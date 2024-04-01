import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/search_bar.dart';
import '../widgets/bottom_navigation_bar.dart';

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
           MySearchBar(_searchController,_performSearch), 
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
        ],
      ),
      bottomNavigationBar:Container(
        height: 100,
        child: CustomBottomNavigationBar(),
      )
        
    );
  }
}