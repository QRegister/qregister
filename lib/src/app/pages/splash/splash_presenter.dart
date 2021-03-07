import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';
import 'package:qregister/src/domain/repositories/internet_repository.dart';
import 'package:qregister/src/domain/repositories/inventory_repository.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/domain/usecases/check_if_user_has_internet.dart';
import 'package:qregister/src/domain/usecases/check_if_user_signed_in.dart';
import 'package:qregister/src/domain/usecases/initialize_app.dart';
import 'package:qregister/src/domain/usecases/read_inventory_csv.dart';

class SplashPresenter extends Presenter {
  Function initializeAppOnComplete;
  Function initializeAppOnError;

  Function checkIfUserSignedInOnNext;
  Function checkIfUserSignedInOnError;

  Function checkIfUserHasInternetOnNext;
  Function checkIfUserHasInternetOnError;

  Function readInventoryCsvOnComplete;
  Function readInventoryCsvOnError;

  final InitializeApp _initializeApp;
  final CheckIfUserSignedIn _checkIfUserSignedIn;
  final CheckIfUserHasInternet _checkIfUserHasInternet;
  final ReadInventoryCsv _readInventoryCsv;

  SplashPresenter(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
    AuthRepository authRepository,
    InternetRepository internetRepository,
    InventoryRepository inventoryRepository,
  )   : _initializeApp = InitializeApp(receiptRepository, userRepository),
        _checkIfUserSignedIn = CheckIfUserSignedIn(authRepository),
        _checkIfUserHasInternet = CheckIfUserHasInternet(internetRepository),
        _readInventoryCsv = ReadInventoryCsv(inventoryRepository);

  @override
  void dispose() {
    _initializeApp.dispose();
    _checkIfUserSignedIn.dispose();
    _checkIfUserHasInternet.dispose();
    _readInventoryCsv.dispose();
  }

  void initializeApp() {
    _initializeApp.execute(InitializeAppObserver(this));
  }

  void checkIfUserSignedIn() {
    _checkIfUserSignedIn.execute(CheckIfUserSignedInObserver(this));
  }

  void checkIfUserHasInternet() {
    _checkIfUserHasInternet.execute(CheckIfUserHasInternetObserver(this));
  }

  void readInventoryCsv() {
    _readInventoryCsv.execute(ReadInventoryCsvObserver(this));
  }
}

class InitializeAppObserver extends Observer<void> {
  final SplashPresenter _presenter;

  InitializeAppObserver(this._presenter);

  @override
  void onComplete() {
    assert(_presenter.initializeAppOnComplete != null);
    _presenter.initializeAppOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.initializeAppOnError != null);
    _presenter.initializeAppOnError(e);
  }

  @override
  void onNext(_) {}
}

class CheckIfUserSignedInObserver extends Observer<bool> {
  final SplashPresenter _presenter;

  CheckIfUserSignedInObserver(this._presenter);
  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.checkIfUserSignedInOnError != null);
    _presenter.checkIfUserSignedIn();
  }

  @override
  void onNext(bool response) {
    assert(_presenter.checkIfUserSignedInOnNext != null);
    _presenter.checkIfUserSignedInOnNext(response);
  }
}

class CheckIfUserHasInternetObserver extends Observer<bool> {
  final SplashPresenter _presenter;

  CheckIfUserHasInternetObserver(this._presenter);
  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.checkIfUserHasInternetOnError != null);
    _presenter.checkIfUserHasInternetOnError();
  }

  @override
  void onNext(bool response) {
    assert(_presenter.checkIfUserHasInternetOnNext != null);
    _presenter.checkIfUserHasInternetOnNext(response);
  }
}

class ReadInventoryCsvObserver extends Observer<void> {
  final SplashPresenter _presenter;

  ReadInventoryCsvObserver(this._presenter);
  @override
  void onComplete() {
    assert(_presenter.readInventoryCsvOnComplete != null);
    _presenter.readInventoryCsvOnComplete();
  }

  @override
  void onError(e) {
    assert(_presenter.readInventoryCsvOnError != null);
    _presenter.readInventoryCsvOnError();
  }

  @override
  void onNext(_) {}
}
