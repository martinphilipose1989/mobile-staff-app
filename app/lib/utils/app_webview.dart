import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class MyInAppWebView extends StatefulWidget {
  const MyInAppWebView({super.key});

  @override
  MyInAppWebViewState createState() => MyInAppWebViewState();
}

class MyInAppWebViewState extends State<MyInAppWebView> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("In-App WebView"),
      ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: WebUri(
                "https://frontend-gate-management-219111640528.us-central1.run.app")),
        onWebViewCreated: (controller) {
          webViewController = controller;
        },
        onLoadStart: (controller, url) {
          log("Started loading: $url");
        },
        onLoadStop: (controller, url) async {
          log("Finished loading: $url");
        },
        onProgressChanged: (controller, progress) {
          log("Progress: $progress%");
        },
      ),
    );
  }
}
