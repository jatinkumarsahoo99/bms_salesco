part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static List<String> listRoutes = [];
  static const ASRUN_DETAILS_REPORT = _Paths.ASRUN_DETAILS_REPORT;
  static const AUDIT_STATUS_REPORT = _Paths.AUDIT_STATUS_REPORT;
  static const DEAL_RECO_SUMMARY = _Paths.DEAL_RECO_SUMMARY;
  static const CHANGE_R_O_NUMBER = _Paths.CHANGE_R_O_NUMBER;
  static const SAME_DAY_COLLECTION = _Paths.SAME_DAY_COLLECTION;
  static const TAPE_I_D_CAMPAIGN = _Paths.TAPE_I_D_CAMPAIGN;
  static const RO_RECEIVED = _Paths.RO_RECEIVED;
  static const WORKFLOW_DEFINITION = _Paths.WORKFLOW_DEFINITION;
  static const E_D_I_MAPPING = _Paths.E_D_I_MAPPING;
}

abstract class RoutesList {
  RoutesList._();

  static List<String> listRoutes = [
    _Paths.HOME,
    _Paths.CHANGE_R_O_NUMBER,
    _Paths.SAME_DAY_COLLECTION,
    _Paths.ASRUN_DETAILS_REPORT,
    _Paths.AUDIT_STATUS_REPORT,
    _Paths.DEAL_RECO_SUMMARY,
    _Paths.E_D_I_MAPPING,
    _Paths.WORKFLOW_DEFINITION,
  ];
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const CHANGE_R_O_NUMBER = '/Frmchangereference';
  static const SAME_DAY_COLLECTION = '/frmSamedayCancellation';
  static const TAPE_I_D_CAMPAIGN = '/frmTapeIDCampaign';
  static const RO_RECEIVED = '/frmROReceived';
  static const ASRUN_DETAILS_REPORT = '/frmAsrundetailsReport';
  static const AUDIT_STATUS_REPORT = '/Frmauditstatusreport';
  static const DEAL_RECO_SUMMARY = '/FrmDealrecosummary';
  static const WORKFLOW_DEFINITION = '/frmDP_ApprovalTrail';
  static const E_D_I_MAPPING = '/frmEDIClientAgencyChannelMapping';
}
