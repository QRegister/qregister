import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';

class ArchiveReceiptOfUser extends UseCase<String, ArchiveReceiptOfUserParams> {
  final ReceiptRepository _receiptRepository;
  final UserRepository _userRepository;

  ArchiveReceiptOfUser(this._receiptRepository, this._userRepository);

  @override
  Future<Stream<String>> buildUseCaseStream(
      ArchiveReceiptOfUserParams params) async {
    StreamController<String> controller = StreamController();
    try {
      String uid = _userRepository.currentUser.uid;
      String receiptId =
          await _receiptRepository.archiveReceiptOfUser(params.receiptId, uid);
      logger.finest('ArchiveReceiptOfUser Successful');
      controller.add(receiptId);
      controller.close();
    } catch (error) {
      print(error);
      logger.severe('ArchiveReceiptOfUser Unsuccessful');
      controller.addError(error);
    }
    return controller.stream;
  }
}

class ArchiveReceiptOfUserParams {
  String receiptId;
  ArchiveReceiptOfUserParams(this.receiptId);
}
