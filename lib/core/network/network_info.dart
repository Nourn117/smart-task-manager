import 'package:connectivity_plus/connectivity_plus.dart';

/// Reports whether the device has a network interface (Wi-Fi, mobile data…).
///
/// This does not prove the API is reachable; the sync engine also treats
/// failed requests as offline.
class NetworkInfo {
  const NetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  Future<bool> isConnected() async =>
      _hasConnection(await _connectivity.checkConnectivity());

  Stream<bool> get onStatusChanged =>
      _connectivity.onConnectivityChanged.map(_hasConnection).distinct();

  static bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);
}
