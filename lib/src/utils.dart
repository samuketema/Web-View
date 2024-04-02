import 'dart:async';
import 'package:webview_flutter/webview_flutter.dart';

typedef UpdateUrlCallback = void Function(String url);

void performSearch(String query, Completer<WebViewController> controller, Function(String) updateUrl) {
  String searchUrl;
  if (Uri.tryParse(query)?.hasAbsolutePath ?? false) {
    searchUrl = query;
  } else {
    searchUrl = 'https://facebook.com/search?q=$query';
  }
  updateUrl(searchUrl);

  controller.future.then((value) {
    print('Loading URL: $searchUrl');
    value.loadUrl(Uri.parse(searchUrl).toString());
  });
}
