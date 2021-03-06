import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/entities/user.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';

class RegisterUser extends UseCase<User, RegisterUserParams> {
  final AuthRepository _authRepository;

  RegisterUser(this._authRepository);

  @override
  Future<Stream<User>> buildUseCaseStream(RegisterUserParams params) async {
    StreamController<User> controller = StreamController();
    try {
      final user = await _authRepository.registerUser(
          params.email, params.password, params.firstName, params.lastName);
      controller.add(user);
      controller.close();
      logger.finest('RegisterUser Successful');
    } catch (error) {
      print(error);
      controller.addError(error);
      logger.severe('RegisterUser Unsuccessful');
    }
    return controller.stream;
  }
}

class RegisterUserParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  RegisterUserParams({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  });
}
