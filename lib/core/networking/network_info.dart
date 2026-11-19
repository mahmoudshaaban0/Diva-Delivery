import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;

  /// Emits each time the device goes from offline back to online.
  Stream<void> get onReconnected;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl({Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  @override
  Stream<void> get onReconnected => _connectivity.onConnectivityChanged
      .map((results) => !results.contains(ConnectivityResult.none))
      .distinct()
      .where((isOnline) => isOnline);
}
