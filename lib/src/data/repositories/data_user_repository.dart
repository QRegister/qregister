import 'package:qreceipt/src/domain/entities/user.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class DataUserRepository extends UserRepository {
  @override
  // TODO: implement currentUser
  User get currentUser => throw UnimplementedError();

  @override
  Future<void> initializeRepository() {
    // TODO: implement initializeRepository
    throw UnimplementedError();
  }
}
