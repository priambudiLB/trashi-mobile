import 'package:flutter/material.dart';
import 'package:trashi/components/layout_redesign.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  static const String PATH = 'paymentWebView';
  final String url;

  const PaymentWebViewScreen({
    Key key,
    this.url,
  }) : super(key: key);

  @override
  _PaymentWebViewScreenState createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      title: Text(
        'Pembayaran',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: widget.url,
      ),
    );
  }
}
