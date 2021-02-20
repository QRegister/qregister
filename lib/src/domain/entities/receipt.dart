import 'package:qreceipt/src/domain/entities/product.dart';

class Receipt {
  final String id;
  final String cashierName;
  final DateTime date;
  final List<Product> products;
  final String storeLocation;
  final String storeLocationAddress;
  final String storeName;
  final String storeSlug;
  final double totalPrice;
  final double totalTax;

  Receipt({
    this.id,
    this.cashierName,
    this.date,
    this.products,
    this.storeLocation,
    this.storeLocationAddress,
    this.storeName,
    this.storeSlug,
    this.totalPrice,
    this.totalTax,
  });
}
