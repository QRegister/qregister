import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';

class SignIn extends UseCase<String, SignInParams> {
  final AuthRepository _authRepository;

  SignIn(this._authRepository);

  @override
  Future<Stream<String>> buildUseCaseStream(params) async {
    StreamController<String> controller = StreamController();
    try {
      final uid = await _authRepository.signIn(params.email, params.password);
      controller.add(uid);
      controller.close();
      logger.finest('SignIn Successful');
    } catch (error) {
      print(error);
      controller.addError(error);
      logger.severe('SignIn Unsuccessful');
    }
    return controller.stream;
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams(this.email, this.password);
}
