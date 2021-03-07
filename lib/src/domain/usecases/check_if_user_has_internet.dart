import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/internet_repository.dart';

class CheckIfUserHasInternet extends UseCase<bool, void> {
  final InternetRepository _internetRepository;

  CheckIfUserHasInternet(this._internetRepository);
  @override
  Future<Stream<bool>> buildUseCaseStream(void params) async {
    StreamController<bool> controller = StreamController();
    try {
      final isOnline = await _internetRepository.checkIfUserHasInternet();
      controller.add(isOnline);
      controller.close();
      logger.finest('CheckIfUserHasInternet Successful');
    } catch (error) {
      print(error);
      logger.severe('CheckIfUserHasInternet Unsuccessful');
      controller.addError(error);
    }
    return controller.stream;
  }
}
