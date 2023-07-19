part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static List<String> listRoutes = [];
  static const ASRUN_DETAILS_REPORT = _Paths.ASRUN_DETAILS_REPORT;
  static const AUDIT_STATUS_REPORT = _Paths.AUDIT_STATUS_REPORT;
  static const DEAL_RECO_SUMMARY = _Paths.DEAL_RECO_SUMMARY;
}

abstract class RoutesList {
  RoutesList._();

  static List<String> listRoutes = [
    // _Paths.HOME,
    _Paths.HOME,
    _Paths.ASRUN_DETAILS_REPORT,
    _Paths.AUDIT_STATUS_REPORT,
    _Paths.DEAL_RECO_SUMMARY,
  ];
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const ASRUN_DETAILS_REPORT = '/frmAsrundetailsReport';
  static const AUDIT_STATUS_REPORT = '/Frmauditstatusreport';
  static const DEAL_RECO_SUMMARY = '/FrmDealrecosummary';
}
