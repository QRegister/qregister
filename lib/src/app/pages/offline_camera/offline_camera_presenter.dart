import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/entities/receipt.dart';
import 'package:qregister/src/domain/repositories/file_repository.dart';
import 'package:qregister/src/domain/repositories/inventory_repository.dart';
import 'package:qregister/src/domain/usecases/add_receipt_id_to_storage.dart';
import 'package:qregister/src/domain/usecases/get_receipt_from_hash.dart';

class OfflineCameraPresenter extends Presenter {
  Function getReceiptFromHashOnNext;
  Function getReceiptFromHashOnError;

  Function addReceiptIdToStorageOnComplete;
  Function addReceiptIdToStorageOnError;

  final GetReceiptFromHash _getReceiptFromHash;
  final AddReceiptIdToStorage _addReceiptIdToStorage;

  OfflineCameraPresenter(
      FileRepository fileRepository, InventoryRepository inventoryRepository)
      : _getReceiptFromHash = GetReceiptFromHash(inventoryRepository),
        _addReceiptIdToStorage = AddReceiptIdToStorage(fileRepository);

  @override
  void dispose() {
    _getReceiptFromHash.dispose();
    _addReceiptIdToStorage.dispose();
  }

  void getReceiptFromHash(String hash) {
    _getReceiptFromHash.execute(
        GetReceiptFromHashObserver(this), GetReceiptFromHashParams(hash));
  }

  void addReceiptIdToStorage(String receiptId) {
    _addReceiptIdToStorage.execute(AddReceiptIdToStorageObserver(this),
        AddReceiptIdToStorageParams(receiptId));
  }
}

class GetReceiptFromHashObserver extends Observer<Receipt> {
  final OfflineCameraPresenter _presenter;

  GetReceiptFromHashObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.getReceiptFromHashOnError != null);
    _presenter.getReceiptFromHashOnError(e);
  }

  @override
  void onNext(Receipt response) {
    assert(_presenter.getReceiptFromHashOnNext != null);
    _presenter.getReceiptFromHashOnNext(response);
  }
}

class AddReceiptIdToStorageObserver extends Observer<void> {
  final OfflineCameraPresenter _presenter;

  AddReceiptIdToStorageObserver(this._presenter);
  @override
  void onComplete() {
    assert(_presenter.addReceiptIdToStorageOnComplete != null);
    _presenter.addReceiptIdToStorageOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.addReceiptIdToStorageOnError != null);
    _presenter.addReceiptIdToStorageOnError(e);
  }

  @override
  void onNext(_) {}
}
