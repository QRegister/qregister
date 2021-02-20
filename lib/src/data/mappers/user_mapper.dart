import 'package:qreceipt/src/domain/entities/user.dart';

class UserMapper {
  static createUserFromMap(Map<String, dynamic> map) {
    return User(
      firstName: map['firstName'],
      lastName: map['lastName'],
      receipts: map['receipts'] != null ? map['receipts'] : [],
      archivedReceipts:
          map['archivedReceipts'] != null ? map['archivedReceipts'] : [],
    );
  }
}
