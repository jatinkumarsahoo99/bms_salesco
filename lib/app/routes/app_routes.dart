part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static List<String> listRoutes = [];
  static const CHANGE_R_O_NUMBER = _Paths.CHANGE_R_O_NUMBER;
  static const SAME_DAY_COLLECTION = _Paths.SAME_DAY_COLLECTION;
  static const TAPE_I_D_CAMPAIGN = _Paths.TAPE_I_D_CAMPAIGN;
}

abstract class RoutesList {
  RoutesList._();

  static List<String> listRoutes = [
    _Paths.HOME,
    _Paths.CHANGE_R_O_NUMBER,
    _Paths.SAME_DAY_COLLECTION,
  ];
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const CHANGE_R_O_NUMBER = '/Frmchangereference';
  static const SAME_DAY_COLLECTION = '/frmSamedayCancellation';
  static const TAPE_I_D_CAMPAIGN = '/tape-i-d-campaign';
}
