import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zero_fitness/helper/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool backPressedOnce = false;
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(appUrl))
    ..setUserAgent(
      'Mozilla/5.0 (Linux; Android 10; WebView) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Mobile Safari/537.36',
    );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) => _onPopInvoked(context, didPop),
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: WebViewWidget(controller: controller),
          ),
        ),
      ),
    );
  }

  void _onPopInvoked(BuildContext context, bool didPop) {
    if (backPressedOnce) {
      // If pressed again, close the app
      SystemNavigator.pop();
    } else {
      // Show a toast message
      Fluttertoast.showToast(
        msg: "Press again to exit",
        toastLength: Toast.LENGTH_SHORT,
      );

      // Set a flag to track the first press
      backPressedOnce = true;

      // Reset the flag after a certain duration
      Future.delayed(const Duration(seconds: 2), () {
        backPressedOnce = false;
      });
    }
  }

  Future<void> checkInternetConnectivity(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showNoInternetToast("No Internet Connection", Colors.white,
          const Color.fromARGB(255, 255, 100, 88));

      // Retry after 5 seconds
      await Future.delayed(const Duration(seconds: 5));
      // ignore: use_build_context_synchronously
      await checkInternetConnectivity(context);
    } else {
      await Future.delayed(const Duration(seconds: 3));
    }
  }
}
