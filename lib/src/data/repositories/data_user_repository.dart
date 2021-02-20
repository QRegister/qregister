import 'package:qreceipt/src/data/mappers/user_mapper.dart';
import 'package:qreceipt/src/domain/entities/user.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';
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
    final snapshot = await usersReference.doc('fyOeMsaNUO7AwxCaibx8').get();
    print('SNAPSHOT DATA: ');
    _currentUser = UserMapper.createUserFromMap(snapshot.data());
  }
}
