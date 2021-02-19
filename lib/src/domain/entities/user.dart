import 'package:qreceipt/src/domain/entities/receipt.dart';

class User {
  String uid;
  String firstName;
  String lastName;
  List<Receipt> receipts;
  List<Receipt> archivedReceipts;
}
