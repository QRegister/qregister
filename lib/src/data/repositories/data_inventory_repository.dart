import 'package:csv/csv.dart';
import 'package:qregister/src/domain/entities/product.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/inventory_repository.dart';
import 'package:flutter/services.dart';

class DataInventoryRepository implements InventoryRepository {
  static final _instance = DataInventoryRepository._internal();

  DataInventoryRepository._internal();

  factory DataInventoryRepository() => _instance;

  List<List<dynamic>> csvData;

  @override
  Future<Receipt> getReceiptFromHash(String hash) async {}

  @override
  Future<void> readInventoryCsv() async {
    final csvString = await rootBundle.loadString('assets/files/inventory.csv');
    final List<List<dynamic>> convertedCsvData =
        CsvToListConverter().convert(csvString);

    this.csvData = convertedCsvData;
  }
}
