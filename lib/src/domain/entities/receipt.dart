import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qregister/src/domain/entities/product.dart';

class Receipt {
  String id;
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cashier-name': cashierName,
      'date': Timestamp.fromDate(date),
      'products': toProductList(products),
      'store-location': storeLocation,
      'store-location-address': storeLocationAddress,
      'store-name': storeName,
      'store-slug': storeSlug,
      'total-price': totalPrice,
      'total-tax': totalTax,
    };
  }
}
