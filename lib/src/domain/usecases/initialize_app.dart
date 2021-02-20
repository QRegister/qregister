import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class InitializeApp extends UseCase<void, void> {
  final ReceiptRepository _receiptRepository;
  final UserRepository _userRepository;

  InitializeApp(this._receiptRepository, this._userRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(void params) async {
    StreamController<void> controller = StreamController();
    try {
      await _userRepository.initializeRepository();
      _receiptRepository.initializeRepository(
        _userRepository.currentUser.receipts,
        _userRepository.currentUser.archivedReceipts,
      );
      logger.finest('InitializeApp Successful');
      controller.close();
    } catch (error) {
      print(error);
      logger.severe('InitializeApp Unsuccessful');
      controller.addError(error);
    }
    return controller.stream;
  }
}
