import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';

class CheckIfUserRegistered
    extends UseCase<bool, CheckIfRegisteredUserRegisteredParams> {
  final AuthRepository _authRepository;

  CheckIfUserRegistered(this._authRepository);
  @override
  Future<Stream<bool>> buildUseCaseStream(
      CheckIfRegisteredUserRegisteredParams params) async {
    StreamController<bool> controller = StreamController();
    try {
      final isRegistered =
          await _authRepository.checkIfUserRegistered(params.email);
      controller.add(isRegistered);
      controller.close();
      logger.finest('CheckIfUserRegistered Successful');
    } catch (error) {
      print(error);
      controller.addError(error);
      logger.severe('CheckIfUserRegistered Unsuccessful');
    }
    return controller.stream;
  }
}

class CheckIfRegisteredUserRegisteredParams {
  final String email;

  CheckIfRegisteredUserRegisteredParams(this.email);
}
