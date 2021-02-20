import 'package:qreceipt/src/domain/entities/receipt.dart';

class User {
  String uid;
  String firstName;
  String lastName;
  List<Receipt> receipts;
  List<Receipt> archivedReceipts;

  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.receipts,
    this.archivedReceipts,
  });
}
