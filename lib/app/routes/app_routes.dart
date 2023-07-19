part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static List<String> listRoutes = [];
  static const RO_RECEIVED = _Paths.RO_RECEIVED;
  static const EDI_RO_BOOKING = _Paths.EDI_RO_BOOKING;
}

abstract class RoutesList {
  RoutesList._();

  static List<String> listRoutes = [
    // _Paths.HOME,
    _Paths.HOME,
  ];
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const RO_RECEIVED = '/frmROReceived';
  static const EDI_RO_BOOKING = '/frmXMLROEntry';
}
