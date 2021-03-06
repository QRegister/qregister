import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';
import 'package:qregister/src/domain/usecases/sign_in.dart';

class SignInPresenter extends Presenter {
  Function signInOnNext;
  Function signInOnError;

  final SignIn _signIn;

  SignInPresenter(AuthRepository authRepository)
      : _signIn = SignIn(authRepository);

  @override
  void dispose() {
    _signIn.dispose();
  }

  void signIn(String email, String password) {
    _signIn.execute(SignInObserver(this), SignInParams(email, password));
  }
}

class SignInObserver extends Observer<String> {
  final SignInPresenter _presenter;

  SignInObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.signInOnError != null);
    _presenter.signInOnError(e);
  }

  @override
  void onNext(String response) {
    assert(_presenter.signInOnNext != null);
    _presenter.signInOnNext(response);
  }
}
