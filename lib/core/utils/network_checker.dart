import 'dart:io';

/// Simple utility to verify network connectivity before performing
/// remote requests.
class NetworkChecker {
  static Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }
}
