import 'package:flutter/material.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:zero_fitness/helper/constants.dart';
import 'package:zero_fitness/screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    checkInternetConnectivity(context);
    return Scaffold(
      key: _scaffoldKey,
       body: Container(
          color: primaryColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png', 
                  width: 150, 
                  height: 150, 
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator( 
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ],
            ),
          ),
        ),
    );
  }

  Future<void> checkInternetConnectivity(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      showNoInternetToast("No Internet Connection", Colors.white, const Color.fromARGB(255, 255, 100, 88));
      
      // Retry after 5 seconds
      await Future.delayed(const Duration(seconds: 5));
      // ignore: use_build_context_synchronously
      await checkInternetConnectivity(context);
    } else {
      await Future.delayed(const Duration(seconds: 3));

      Navigator.pushReplacement(
        _scaffoldKey.currentContext!,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }
}
