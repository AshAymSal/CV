import 'package:connectivity/connectivity.dart';

class ConnectivityService {
  ConnectivityService._();

  static final instance = ConnectivityService._();

  /// `_isInitialized` is used to ensure that the listeners are only called once
  bool _isInitialized = false;

  /// Start listening to connectivity stream
  /// Connectivity stream is triggered whenever app connection to the internet method changed
  initializeConnectivityListeners() {
    if (_isInitialized) return;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print("Connection status changed : " + result.toString());
    });
    print("Connectivity stream has been initialized!!");
    _isInitialized = true;
  }

  /// Getting current connectivity status/method
  Future<bool> checkIfConnected() async {
    ConnectivityResult connectivityResult =
        (await Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}
