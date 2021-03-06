import 'package:qregister/src/data/mappers/user_mapper.dart';
import 'package:qregister/src/domain/entities/user.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fireAuth;

class DataUserRepository extends UserRepository {
  static final _instance = DataUserRepository._internal();

  DataUserRepository._internal();

  factory DataUserRepository() => _instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final fireAuth.FirebaseAuth authInstance =
      fireAuth.FirebaseAuth.instance;

  User _currentUser;
  CollectionReference usersReference;

  @override
  User get currentUser => _currentUser;

  @override
  Future<void> initializeRepository() async {
    final firebaseUser = authInstance.currentUser;
    usersReference = _firestore.collection('users');
    final snapshot = await usersReference.doc(firebaseUser.uid).get();
    _currentUser =
        UserMapper.createUserFromMap(snapshot.data(), firebaseUser.uid);
  }
}
