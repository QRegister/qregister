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
  Future<Receipt> getReceiptFromHash(String hash) async {List<String> backwards_num_item=[];
List<String> backwards_amount_item=[];
int start_index=0;
List<String> the_rest=[];

for(int x=0; x<hesh.length; x++){
    
    if(hesh[x]=="#"){
        the_rest.add(hesh.substring(start_index,x));
        start_index=x+1;
    
    
    }
  
    else if (hesh[x]=="?"){
        backwards_num_item.add(hesh.substring(start_index,x));
        start_index=x+1;}


    else if (hesh[x]=="%"){
        backwards_amount_item.add(hesh.substring(start_index,x));
        start_index=x+1;}
}

print(backwards_num_item);
print(backwards_amount_item);
 
int date= int.parse(the_rest[0]);
int store_id=int.parse(the_rest[1]);
int cashier_id=int.parse(the_rest[2]);
String receipt_id=the_rest[3];

print("Cahier ID: ${cashier_id}");
print("Cashier Name is: ${cashier_names[cashier_id-1]}");
print(date);
print(store_id); 
print("receipt ID: ${receipt_id}");

double total=0;


for(int x=0; x<cashier_names.length; x++){}



for(int x=0; x<backwards_num_item.length; x++){
    for(int y=0; y<item_code.length; y++){
        if ((item_code[y]) == int.parse(backwards_num_item[x])){

            print("item name: ${item_name[y]}");
            print("price: ${item_prize[y].toString()}  ${item_prize_type[y].toString()}, amount: ${backwards_amount_item[x]}");
            total=total+double.parse(backwards_amount_item[x])*item_prize[y];
}}}

print("Your TOTAL is: ${total.toString()} TL");

}}

  @override
  Future<void> readInventoryCsv() async {
    final csvString = await rootBundle.loadString('assets/files/inventory.csv');
    final List<List<dynamic>> convertedCsvData =
        CsvToListConverter().convert(csvString);

    this.csvData = convertedCsvData;
  }
}
