import 'package:qregister/src/domain/repositories/file_repository.dart';

class DeviceFileRepository implements FileRepository {
  @override
  Future<void> addReceiptIdToStorage(String receiptId) async {
    print('Receipt is added to storage');
  }
}
