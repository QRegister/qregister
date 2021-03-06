import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qregister/src/domain/entities/user.dart';
import 'package:qregister/src/domain/repositories/auth_repository.dart';
import 'package:qregister/src/domain/usecases/check_if_user_registered.dart';
import 'package:qregister/src/domain/usecases/register_user.dart';

class RegistrationPresenter extends Presenter {
  Function checkIfUserRegisteredOnNext;
  Function checkIfUserRegisteredOnError;

  Function registerUserOnNext;
  Function registerUserOnError;

  final CheckIfUserRegistered _checkIfUserRegistered;
  final RegisterUser _registerUser;

  RegistrationPresenter(AuthRepository authRepository)
      : _checkIfUserRegistered = CheckIfUserRegistered(authRepository),
        _registerUser = RegisterUser(authRepository);

  @override
  void dispose() {
    _checkIfUserRegistered.dispose();
    _registerUser.dispose();
  }

  void checkIfUserRegistered(String email) {
    _checkIfUserRegistered.execute(
      CheckIfUserRegisteredObserver(this),
      CheckIfRegisteredUserRegisteredParams(email),
    );
  }

  void registerUser(
      String email, String password, String firstName, String lastName) {
    _registerUser.execute(
      RegisterUserObserver(this),
      RegisterUserParams(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      ),
    );
  }
}

class CheckIfUserRegisteredObserver extends Observer<bool> {
  final RegistrationPresenter _presenter;

  CheckIfUserRegisteredObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.checkIfUserRegisteredOnError != null);
    _presenter.checkIfUserRegisteredOnError(e);
  }

  @override
  void onNext(bool response) {
    assert(_presenter.checkIfUserRegisteredOnNext != null);
    _presenter.checkIfUserRegisteredOnNext(response);
  }
}

class RegisterUserObserver extends Observer<User> {
  final RegistrationPresenter _presenter;

  RegisterUserObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    assert(_presenter.registerUserOnError != null);
    _presenter.registerUserOnError(e);
  }

  @override
  void onNext(User response) {
    assert(_presenter.registerUserOnNext != null);
    _presenter.registerUserOnNext(response);
  }
}
