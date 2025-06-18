import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

/// Simple utility to verify network connectivity before performing
/// remote requests.
class NetworkChecker {
  static Future<bool> get isConnected async {
    try {
      final realInternetAccess = InternetConnectionChecker.createInstance();
      final connectivity = await Connectivity().checkConnectivity();
      if (connectivity == ConnectivityResult.none) {}
      return connectivity.first == ConnectivityResult.none
          ? false
          : await realInternetAccess.hasConnection;
    } on SocketException {
      return false;
    }
  }
}

// void main() async {
//   final g = await NetworkChecker.isConnected;
//   log(g.toString());
// }
