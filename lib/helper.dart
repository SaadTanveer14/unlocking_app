import 'package:connectivity_plus/connectivity_plus.dart';

class Helper {
  Future<bool> checkInternetConnectivity() async {
    var isConnected = false;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      isConnected = true;
     } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
       isConnected = true;
     }
    return isConnected;
    //return true;
  }
}