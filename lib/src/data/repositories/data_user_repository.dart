import 'package:qreceipt/src/domain/entities/user.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class DataUserRepository extends UserRepository {
  @override
  User get currentUser => User(firstName: 'Murat', lastName: 'Kas', uid: '0');

  @override
  Future<void> initializeRepository() async {
    print('User repo initalized');
  }
}
