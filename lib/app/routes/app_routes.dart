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
  static const COMMERCIAL_CREATION_AUTO = _Paths.COMMERCIAL_CREATION_AUTO;
  static const COMMERCIAL_LANGUAGE_SPECIFICATION =
      _Paths.COMMERCIAL_LANGUAGE_SPECIFICATION;
  static const ON_SPOT_BOOKING_SKY_MEDIA = _Paths.ON_SPOT_BOOKING_SKY_MEDIA;
  static const PERIODIC_DEAL_UTILISATION_FORMAT2 =
      _Paths.PERIODIC_DEAL_UTILISATION_FORMAT2;
  static const UPDATE_EXECUTIVE = _Paths.UPDATE_EXECUTIVE;
  static const USER_GROUPS_FOR_DEAL_WORKFLOW =
      _Paths.USER_GROUPS_FOR_DEAL_WORKFLOW;
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
  static const TAPE_I_D_CAMPAIGN = '/Routes.HOME';
  static const RO_RECEIVED = '/frmROReceived';
  static const ASRUN_DETAILS_REPORT = '/frmAsrundetailsReport';
  static const AUDIT_STATUS_REPORT = '/Frmauditstatusreport';
  static const DEAL_RECO_SUMMARY = '/FrmDealrecosummary';
  static const WORKFLOW_DEFINITION = '/frmDP_ApprovalTrail';
  static const E_D_I_MAPPING = '/frmEDIClientAgencyChannelMapping';
  static const COMMERCIAL_CREATION_AUTO = '/commercial-creation-auto';
  static const COMMERCIAL_LANGUAGE_SPECIFICATION =
      '/commercial-language-specification';
  static const ON_SPOT_BOOKING_SKY_MEDIA = '/frmDigiTextBooking';
  static const PERIODIC_DEAL_UTILISATION_FORMAT2 =
      '/frmPeriodicDealUtilisation';
  static const UPDATE_EXECUTIVE = '/rate';
  static const USER_GROUPS_FOR_DEAL_WORKFLOW = '/frmDP_UserGroups';
}
