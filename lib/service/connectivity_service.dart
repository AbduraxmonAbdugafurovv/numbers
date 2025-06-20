import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  /// Hozirgi internet holatini tekshiradi
   Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    // ignore: unrelated_type_equality_checks
    return result != ConnectivityResult.none;
  }

  /// Internet holatini doimiy kuzatish uchun Stream
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      _connectivity.onConnectivityChanged;
}
