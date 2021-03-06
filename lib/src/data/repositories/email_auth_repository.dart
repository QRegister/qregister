import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireAuth;
import 'package:qregister/src/domain/entities/user.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';

class EmailAuthRepository extends AuthRepository {
  static final _instance = EmailAuthRepository._internal();

  EmailAuthRepository._internal()
      : authInstance = fireAuth.FirebaseAuth.instance;

  factory EmailAuthRepository() => _instance;

  final fireAuth.FirebaseAuth authInstance;

  Future<void> _addUserToDatabase(User user) async {
    try {
      final firestore = FirebaseFirestore.instance;
      await firestore.collection('users').doc(user.uid).set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'email': user.email,
        'archivedReceipts': [],
        'receipts': [],
      });
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<bool> checkIfUserRegistered(String email) async {
    try {
      final snapshot = FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();
      return snapshot != null ? true : false;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<bool> checkIfUserSignedIn() async {
    try {
      final currentUser = authInstance.currentUser;
      return currentUser != null ? true : false;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<User> registerUser(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      final credentials = await authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = User(
        firstName: firstName,
        lastName: lastName,
        email: email,
        uid: credentials.user.uid,
      );
      await this._addUserToDatabase(user);
      return user;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<String> signIn(String email, String password) async {
    try {
      final credentials = await authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      return credentials.user.uid;
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await authInstance.signOut();
    } catch (e, st) {
      print(e);
      print(st);
      rethrow;
    }
  }
}
