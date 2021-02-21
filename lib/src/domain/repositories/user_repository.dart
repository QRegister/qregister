import 'package:qregister/src/domain/entities/user.dart';

abstract class UserRepository {
  Future<void> initializeRepository();
  User get currentUser;
}
