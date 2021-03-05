import 'package:qregister/src/data/mappers/user_mapper.dart';
import 'package:qregister/src/domain/entities/user.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataUserRepository extends UserRepository {
  static final _instance = DataUserRepository._internal();

  DataUserRepository._internal();

  factory DataUserRepository() => _instance;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User _currentUser;
  CollectionReference usersReference;

  @override
  User get currentUser => _currentUser;

  @override
  Future<void> initializeRepository() async {
    usersReference = _firestore.collection('users');
    final snapshot = await usersReference.doc('78kE0m1VDwXdhQeDZnxM').get();
    _currentUser = UserMapper.createUserFromMap(snapshot.data());
    _currentUser.uid = '78kE0m1VDwXdhQeDZnxM';
  }
}
