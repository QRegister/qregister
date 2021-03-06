import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';

class CheckIfUserSignedIn extends UseCase<bool, void> {
  final AuthRepository _authRepository;

  CheckIfUserSignedIn(this._authRepository);
  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    StreamController<bool> controller = StreamController();
    try {
      final isSignedIn = await _authRepository.checkIfUserSignedIn();
      controller.add(isSignedIn);
      controller.close();
      logger.finest('CheckIfUserSignedIn Successful');
    } catch (error) {
      print(error);
      controller.addError(error);
      logger.severe('CheckIfUserSignedIn Unsuccessful');
    }
    return controller.stream;
  }
}
