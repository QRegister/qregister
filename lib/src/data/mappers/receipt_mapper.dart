import 'package:qregister/src/domain/entities/product.dart';
import 'package:qregister/src/domain/entities/receipt.dart';

class ReceiptMapper {
  static createReceiptFromMap(Map<String, dynamic> map) {
    return Receipt(
      id: map['id'],
      cashierName: map['cashier-name'],
      date: map['date'].toDate(),
      products: createProductList(map['products']),
      storeLocation: map['store-location'],
      storeLocationAddress: map['store-location-address'],
      storeName: map['store-name'],
      storeSlug: map['store-slug'],
      totalPrice: map['total-price'].toDouble(),
      totalTax: map['total-tax'].toDouble(),
    );
  }

  static createProductList(List<dynamic> param) {
    List<Product> list = [];
    param.forEach((element) {
      list.add(Product.fromMap(element));
    });
    return list;
  }
}
