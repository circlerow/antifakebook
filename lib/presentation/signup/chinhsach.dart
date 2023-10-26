import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChinhSach extends StatefulWidget {
  ChinhSach({super.key});

  @override
  _ChinhSachState createState() => _ChinhSachState();
}

class _ChinhSachState extends State<ChinhSach> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadFlutterAsset('assets/chinhsach.html');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Chính Sách'),
        ),
        body: Column(
          children: [
            Container(
              height: 400,
              width: 400,
              child: WebViewWidget(
                controller: controller,
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Tiếp'),
            )
          ],
        ));
  }
}
