import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';

class SignOut extends UseCase<void, void> {
  final AuthRepository _authRepository;

  SignOut(this._authRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(void params) async {
    StreamController<void> controller = StreamController();
    try {
      await _authRepository.signOut();
      controller.close();
      logger.finest('SignOut Successful');
    } catch (error) {
      print(error);
      controller.addError(error);
      logger.severe('SignOut Unsuccessful');
    }
    return controller.stream;
  }
}
