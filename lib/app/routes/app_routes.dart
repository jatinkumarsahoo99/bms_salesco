part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static List<String> listRoutes = [];
  static const CHANGE_R_O_NUMBER = _Paths.CHANGE_R_O_NUMBER;
  static const SAME_DAY_COLLECTION = _Paths.SAME_DAY_COLLECTION;
  static const TAPE_I_D_CAMPAIGN = _Paths.TAPE_I_D_CAMPAIGN;
  static const RO_RECEIVED = _Paths.RO_RECEIVED;
  static const MAKE_GOOD_REPORT = _Paths.MAKE_GOOD_REPORT;
  static const MARK_R_OS_FLAG = _Paths.MARK_R_OS_FLAG;
  static const AUTO_TIME_LOCK = _Paths.AUTO_TIME_LOCK;
  static const MONTHLY_REPORT = _Paths.MONTHLY_REPORT;
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
  static const TAPE_I_D_CAMPAIGN = '/frmTapeIDCampaign';
  static const RO_RECEIVED = '/frmROReceived';
  static const MAKE_GOOD_REPORT = '/frmmakegoodreport';
  static const MARK_R_OS_FLAG = '/frmMarkROsFlag';
  static const AUTO_TIME_LOCK = '/frmAutoLock';
  static const MONTHLY_REPORT = '/frmmonthlyreport';
}
