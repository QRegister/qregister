import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/receipt_repository.dart';
import 'package:qregister/src/domain/repositories/user_repository.dart';
import 'package:qregister/src/domain/usecases/initialize_app.dart';

class SplashPresenter extends Presenter {
  Function initializeAppOnComplete;
  Function initializeAppOnError;

  final InitializeApp _initializeApp;

  SplashPresenter(
      UserRepository userRepository, ReceiptRepository receiptRepository)
      : _initializeApp = InitializeApp(receiptRepository, userRepository);

  @override
  void dispose() {
    _initializeApp.dispose();
  }

  void initializeApp() {
    _initializeApp.execute(InitializeAppObserver(this));
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
