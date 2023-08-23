import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService();

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();

  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  bool _isConnected = false;

  static Future<ConnectivityService> getInstance() async {
    return _instance;
  }

  Future initialise() async {
    // Add the following line
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionState);
  }

  StreamSubscription<bool> listen(void Function(bool result)? onData) {
    return _controller.stream.listen(onData);
  }

  bool isConnected() {
    return _isConnected;
  }

  Future<void> _updateConnectionState(ConnectivityResult result) async {
    _isConnected = result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
    _controller.add(_isConnected);
  }
}
