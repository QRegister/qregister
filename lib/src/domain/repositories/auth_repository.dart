import 'package:qregister/src/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> registerUser(
      String email, String password, String firstName, String lastName);
  Future<String> signIn(String email, String password);
  Future<bool> checkIfUserRegistered(String email);
  Future<bool> checkIfUserSignedIn();
  Future<void> signOut();
}
