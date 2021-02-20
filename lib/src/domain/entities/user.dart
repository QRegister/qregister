class User {
  String uid;
  String firstName;
  String lastName;
  List<dynamic> receipts;
  List<dynamic> archivedReceipts;

  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.receipts,
    this.archivedReceipts,
  });

  @override
  String toString() {
    return 'firstName: $firstName, lastName: $lastName, uid: $uid, receipts: ${receipts.toString()}, archivedReceipts: ${archivedReceipts.toString()}';
  }
}
