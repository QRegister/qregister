import 'package:csv/csv.dart';
import 'package:qregister/src/domain/entities/product.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/inventory_repository.dart';
import 'package:flutter/services.dart';

class DataInventoryRepository implements InventoryRepository {
  static final _instance = DataInventoryRepository._internal();

  DataInventoryRepository._internal();

  factory DataInventoryRepository() => _instance;

  List<List<dynamic>> inventoryCsvData;
  List<List<dynamic>> storeCsvData;

  @override
  Future<Receipt> getReceiptFromHash(String hash) async {
    try {
      List<String> itemCodeList = [];
      List<double> itemAmountList = [];
      List<String> otherInfosList = [];
      int index = 0;

      for (int x = 0; x < hash.length; x++) {
        if (hash[x] == "#") {
          otherInfosList.add(hash.substring(index, x));
          index = x + 1;
        } else if (hash[x] == "?") {
          itemCodeList.add(hash.substring(index, x));
          index = x + 1;
        } else if (hash[x] == "%") {
          itemAmountList.add(double.tryParse(hash.substring(index, x)));
          index = x + 1;
        }
      }

      List<Product> productList = [];

      if (itemCodeList != null && itemCodeList.length != 0) {
        itemCodeList.forEach((itemCode) {
          inventoryCsvData.forEach((data) {
            if (data[0].toString() == itemCode) {
              productList.add(
                Product(
                  barcode: data[1].toString(),
                  name: data[2],
                  unitPrice: data[3].toDouble(),
                  unitOfMeasurement: data[4],
                  taxRate: data[5].toDouble(),
                  count: itemAmountList
                      .elementAt(itemCodeList.indexOf(itemCode))
                      .toDouble(),
                ),
              );
            }
          });
        });
      }

      double totalPrice = 0;
      double totalTax = 0;

      productList.forEach((product) {
        double productTotalPrice = product.unitPrice * product.count;
        totalPrice += productTotalPrice;
        totalTax += productTotalPrice * product.taxRate / 100;
      });

      DateTime date =
          DateTime.fromMillisecondsSinceEpoch(int.tryParse(otherInfosList[0]));
      int storeId = int.parse(otherInfosList[1]);
      String cashierName = otherInfosList[2];
      String receiptId = otherInfosList[3];

      int storeIndex;

      storeCsvData.forEach((store) {
        if (store[0] == storeId) {
          storeIndex = storeCsvData.indexOf(store);
        }
      });

      String storeSlug = storeCsvData.elementAt(storeIndex).elementAt(1);
      String storeName = storeCsvData.elementAt(storeIndex).elementAt(2);
      String storeLocation = storeCsvData.elementAt(storeIndex).elementAt(3);
      String storeLocationAddress =
          storeCsvData.elementAt(storeIndex).elementAt(4);

      return Receipt(
        id: receiptId,
        cashierName: cashierName,
        storeName: storeName,
        storeSlug: storeSlug,
        date: date,
        products: productList,
        storeLocation: storeLocation,
        storeLocationAddress: storeLocationAddress,
        totalPrice: totalPrice,
        totalTax: totalTax,
      );
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> readInventoryCsv() async {
    final inventoryCsvString =
        await rootBundle.loadString('assets/files/inventory.csv');
    final List<List<dynamic>> convertedInventoryCsvData =
        CsvToListConverter().convert(inventoryCsvString);

    final storeCsvString =
        await rootBundle.loadString('assets/files/stores.csv');
    final List<List<dynamic>> convertedStoresCsvData =
        CsvToListConverter().convert(storeCsvString);

    this.inventoryCsvData = convertedInventoryCsvData;
    this.storeCsvData = convertedStoresCsvData;
  }
}
