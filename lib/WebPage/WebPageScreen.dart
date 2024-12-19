import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../Components/theme.dart';
import '../Utils/BottomNavBarScreen.dart';

class WenView extends StatefulWidget {
  final String webURL;

  const WenView(this.webURL);

  @override
  State<WenView> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<WenView> {
  // final Completer<WebViewController> _controller = Completer<WebViewController>();
  int _stackIndex = 1;

  @override
  Widget build(BuildContext context) {
    print(widget.webURL);
    WebViewController controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webURL));

    return Scaffold(
      backgroundColor: AppTheme.App_color,
      appBar: AppBar(
        backgroundColor: AppTheme.App_color,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
                  (route) => false,
            );          },
          child: const Icon(
            Icons.keyboard_arrow_left,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: Text(
          "Schedule",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontFamily: GoogleFonts.lato().fontFamily,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
