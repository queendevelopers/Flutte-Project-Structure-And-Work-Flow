import 'package:connectivity/connectivity.dart';
import 'package:entry_assignment/core/enum/ConnectivityStatus.dart';
import 'package:flutter/cupertino.dart';

class ConnectivityService extends ChangeNotifier {
  Future getCurrentNetworkState() async {
    return await Connectivity().checkConnectivity();
    /*var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
        // I am connected to a mobile network.
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
    }*/
  }

  ConnectivityService() {
    Connectivity().onConnectivityChanged.listen((event) {
      _getStatusFromResult(event);
      notifyListeners();
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.WiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
      default:
        return ConnectivityStatus.Offline;
    }
  }
}
