class Product {
  final String name;
  final String barcode;
  final String unitOfMeasurement;
  final double unitPrice;
  final double count;
  final double taxRate;

  double get totalPrice => unitPrice * count;

  Product({
    this.name,
    this.barcode,
    this.unitOfMeasurement,
    this.unitPrice,
    this.count,
    this.taxRate,
  });

  Product.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        barcode = map['barcode'],
        unitOfMeasurement = map['unit-of-measurement'],
        unitPrice = map['unit-price'].toDouble(),
        count = map['count'].toDouble(),
        taxRate = map['tax-rate'].toDouble();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'barcode': barcode,
      'unit-of-measurement': unitOfMeasurement,
      'unit-price': unitPrice,
      'count': count,
      'tax-rate': taxRate,
    };
  }
}

List<dynamic> toProductList(List<Product> param) {
  List list = [];
  param.forEach((element) {
    list.add(element.toMap());
  });
  return list;
}
