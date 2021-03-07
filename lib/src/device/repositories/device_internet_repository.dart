import 'dart:io';

import 'package:qregister/src/domain/repositories/internet_repository.dart';

class DeviceInternetRepository implements InternetRepository {
  @override
  Future<bool> checkIfUserHasInternet() async {
    bool isOnline = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isOnline = true;
        print('WE ARE ONLINE');
      }
    } on SocketException catch (_) {
      isOnline = false;
      print('WE ARE NOT ONLINE');
    }
    return isOnline;
  }
}
