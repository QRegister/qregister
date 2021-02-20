import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:qreceipt/src/app/pages/home/home_presenter.dart';

class HomeController extends Controller {
  final HomePresenter _presenter;

  HomeController() : _presenter = HomePresenter();

  @override
  void initListeners() {}
}
