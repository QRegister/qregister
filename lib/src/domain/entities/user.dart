class User {
  String uid;
  String firstName;
  String lastName;
  String email;
  List<dynamic> receipts;
  List<dynamic> archivedReceipts;

  User({
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    this.receipts,
    this.archivedReceipts,
  });

  @override
  String toString() {
    return 'firstName: $firstName, lastName: $lastName, email: $email, uid: $uid, receipts: ${receipts.toString()}, archivedReceipts: ${archivedReceipts.toString()}';
  }
}
