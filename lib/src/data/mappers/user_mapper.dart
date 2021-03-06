import 'package:qregister/src/domain/entities/user.dart';

class UserMapper {
  static createUserFromMap(Map<String, dynamic> map, String uid) {
    return User(
      uid: uid,
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      receipts: map['receipts'] != null ? map['receipts'] : [],
      archivedReceipts:
          map['archivedReceipts'] != null ? map['archivedReceipts'] : [],
    );
  }
}
