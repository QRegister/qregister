import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/domain/usecases/check_if_user_signed_in.dart';
import 'package:qregister/src/domain/usecases/initialize_app.dart';

class SplashPresenter extends Presenter {
  Function initializeAppOnComplete;
  Function initializeAppOnError;

  Function checkIfUserSignedInOnNext;
  Function checkIfUserSignedInOnError;

  final InitializeApp _initializeApp;
  final CheckIfUserSignedIn _checkIfUserSignedIn;

  SplashPresenter(
    UserRepository userRepository,
    ReceiptRepository receiptRepository,
    AuthRepository authRepository,
  )   : _initializeApp = InitializeApp(receiptRepository, userRepository),
        _checkIfUserSignedIn = CheckIfUserSignedIn(authRepository);

  @override
  void dispose() {
    _initializeApp.dispose();
    _checkIfUserSignedIn.dispose();
  }

  void initializeApp() {
    _initializeApp.execute(InitializeAppObserver(this));
  }

  void checkIfUserSignedIn() {
    _checkIfUserSignedIn.execute(CheckIfUserSignedInObserver(this));
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
