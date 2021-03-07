import 'dart:io';

import 'package:qregister/src/domain/repositories/internet_repository.dart';

class DeviceInternetRepository implements InternetRepository {
  static final _instance = DeviceInternetRepository._internal();

  DeviceInternetRepository._internal();

  factory DeviceInternetRepository() => _instance;

  @override
  Future<bool> checkIfUserHasInternet() async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
      }
    } on SocketException catch (_) {
      isOnline = false;
    }
    return isOnline;
  }
}
