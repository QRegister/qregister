import 'package:qregister/src/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> registerUser(String email, String password);
  Future<User> signIn(String email, String password);
  Future<bool> checkIfUserRegistered();
  Future<bool> checkIfUserSignedIn();
  Future<void> signOut();
}
