import 'package:qregister/src/domain/repositories/file_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeviceFileRepository implements FileRepository {
  static final _instance = DeviceFileRepository._internal();

  DeviceFileRepository._internal();

  factory DeviceFileRepository() => _instance;

  @override
  Future<void> addReceiptIdToStorage(String receiptId) async {
    try {
      print(receiptId);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> receiptIdList = prefs.getStringList('receiptIds');
      if (receiptIdList != null &&
          receiptIdList.length != 0 &&
          !receiptIdList.contains(receiptId)) {
        receiptIdList.add(receiptId);
        prefs.setStringList('receiptIds', receiptIdList);
      } else {
        prefs.setStringList('receiptIds', [receiptId]);
      }
      print(prefs.getStringList('receiptIds'));
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
