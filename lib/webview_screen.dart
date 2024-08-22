import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({super.key});

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {

  InAppWebViewController? _webViewController;
  WebUri? url;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('InAppWebView Example'),
      ),
      body: Container(
          child: Column(children: <Widget>[
            Container(
                padding: EdgeInsets.all(10.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10.0),
                decoration:
                BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: InAppWebView(
                  initialUrlRequest: URLRequest(
                    url: WebUri("https://flutter.dev/")
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    _webViewController = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, WebUri? url) {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onLoadStop: (InAppWebViewController controller, WebUri? url) async {
                    setState(() {
                      this.url = url;
                    });
                  },
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController!.goBack();
                    }
                  },
                ),
                ElevatedButton(
                  child: Icon(Icons.arrow_forward),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController!.goForward();
                    }
                  },
                ),
                ElevatedButton(
                  child: Icon(Icons.refresh),
                  onPressed: () {
                    if (_webViewController != null) {
                      _webViewController!.reload();
                    }
                  },
                ),
              ],
            ),
          ])),
    );
  }
}
