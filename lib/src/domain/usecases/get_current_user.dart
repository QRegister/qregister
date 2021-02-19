import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/domain/entities/user.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class GetCurrentUser extends UseCase<User, void> {
  final UserRepository _userRepository;

  GetCurrentUser(this._userRepository);

  @override
  Future<Stream<User>> buildUseCaseStream(void params) async {
    StreamController<User> controller = StreamController();
    try {
      User user = _userRepository.currentUser;
      logger.finest('GetCurrentUser Successful');
      controller.add(user);
      controller.close();
    } catch (error) {
      print(error);
      logger.severe('GetCurrentUser Unsuccessful');
      controller.addError(error);
    }
    return controller.stream;
  }
}
