import 'package:qregister/src/domain/entities/product.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/inventory_repository.dart';

class DataInventoryRepository implements InventoryRepository {
  @override
  Future<Receipt> getReceiptFromHash(String hash) async {
    print('receipt dehashed');
    return Receipt(
      cashierName: 'Humeyra',
      date: DateTime.now(),
      id: 'xxxxxxx',
      products: [
        Product(
          barcode: '1',
          count: 1.0,
          name: 'Carrot',
          taxRate: 18,
          unitOfMeasurement: 'KG',
          unitPrice: 1.60,
        ),
      ],
      storeLocation: 'Migros ODTU',
      storeLocationAddress: 'ODTU Dedik Ya',
      storeName: 'Migros',
      storeSlug: 'migros',
      totalPrice: 50,
      totalTax: 15,
    );
  }

  @override
  Future<void> readInventoryCsv() async {
    print("READING CSV");
  }
}
