// main file
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../widgets/search_bar.dart';
import '../widgets/bottom_navigation_bar.dart';
import '../utils.dart'; 

class WebViewScreen extends StatefulWidget {
  final String initialUrl;

  WebViewScreen({required this.initialUrl});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  TextEditingController _searchController = TextEditingController();
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final FocusNode focusNode = FocusNode();
  
  String currentUrl = '';
  double progress = 0;

  @override
  void initState() {
    super.initState();
    currentUrl = widget.initialUrl;
  }

  void _updateCurrentUrl(String newUrl) {
    setState(() {
      currentUrl = newUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
  preferredSize: Size.fromHeight(80.0), 
  child: AppBar(
    backgroundColor: Color.fromARGB(255, 246, 190, 107),
    foregroundColor: Colors.white,
    title: Text('WebView App'),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          focusNode.requestFocus();
        },
      ),
      PopupMenuButton(itemBuilder: (context) => [
        PopupMenuItem(child: Text("Option 1")),
        PopupMenuItem(child: Text('Option 2'))
      ]),
    ],
  ),
),

      body: Column(
        children: [
           MySearchBar(
              _searchController,
              (query) {
               performSearch(query, _controller, _updateCurrentUrl);
             },
              focusNode
           ), 
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
              onProgress: (int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),         
        ],
      ),
      bottomNavigationBar: Container(
        height: 85,
        child: CustomBottomNavigationBar(),
      ),
      floatingActionButton: FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context, AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FloatingActionButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () async {
                    if (await controller.data!.canGoBack()) {
                      controller.data!.goBack();
                    }
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () async {
                    if (await controller.data!.canGoForward()) {
                      controller.data!.goForward();
                    }
                  },
                ),
                FloatingActionButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    controller.data!.reload();
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
