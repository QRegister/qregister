import 'package:qregister/src/domain/entities/receipt.dart';

abstract class InventoryRepository {
  Future<void> readInventoryCsv();
  Future<Receipt> getReceiptFromHash(String hash);
}
