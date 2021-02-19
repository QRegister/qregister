import 'dart:async';

import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/domain/entities/receipt.dart';
import 'package:qreceipt/src/domain/repositories/receipt_repository.dart';
import 'package:qreceipt/src/domain/repositories/user_repository.dart';

class AddReceiptToUser extends UseCase<String, AddReceiptToUserParams> {
  final ReceiptRepository _receiptRepository;
  final UserRepository _userRepository;

  AddReceiptToUser(this._receiptRepository, this._userRepository);

  @override
  Future<Stream<String>> buildUseCaseStream(
      AddReceiptToUserParams params) async {
    StreamController<String> controller = StreamController();
    try {
      String userId = _userRepository.currentUser.uid;
      String receiptId =
          await _receiptRepository.addReceiptToUser(params.receipt, userId);
      logger.finest('AddReceiptToUser Successful');
      controller.add(receiptId);
      controller.close();
    } catch (error) {
      print(error);
      controller.addError(error);
      logger.severe('AddReceiptToUser Unsuccessful');
    }
    return controller.stream;
  }
}

class AddReceiptToUserParams {
  Receipt receipt;
  AddReceiptToUserParams(this.receipt);
}
