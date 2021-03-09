import 'package:qregister/src/domain/entities/product.dart';
import 'package:qregister/src/domain/entities/receipt.dart';

class ReceiptMapper {
  static Receipt createReceiptFromMap(Map<String, dynamic> map) {
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

  static List<Product> createProductList(List<dynamic> param) {
    List<Product> list = [];
    param.forEach((element) {
      list.add(Product.fromMap(element));
    });
    return list;
  }

  static Map<String, dynamic> sanitizeReceiptMap(Map<String, dynamic> map) {
    return {
      'id': map['id'],
      'cashier-name': map['cashier-name'],
      'date': map['date'],
      'products': sanitizeProductList(map['products']),
      'store-location': map['store-location'],
      'store-location-address': map['store-location-address'],
      'store-name': map['store-name'],
      'store-slug': map['store-slug'],
      'total-price': map['total-price'].toDouble(),
      'total-tax': map['total-tax'].toDouble(),
    };
  }

  static List<dynamic> sanitizeProductList(List<dynamic> param) {
    List<dynamic> productList = [];
    param.forEach((p) {
      productList.add({
        'name': p['name'],
        'barcode': p['barcode'].toString(),
        'unit-of-measurement': p['unit-of-measurement'],
        'unit-price': p['unit-price'].toDouble(),
        'count': p['count'].toDouble(),
        'tax-rate': p['tax-rate'].toDouble(),
      });
    });
    return productList;
  }
}
