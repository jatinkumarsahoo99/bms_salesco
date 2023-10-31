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
  static const MAKE_GOOD_REPORT = _Paths.MAKE_GOOD_REPORT;
  static const MARK_R_OS_FLAG = _Paths.MARK_R_OS_FLAG;
  static const AUTO_TIME_LOCK = _Paths.AUTO_TIME_LOCK;
  static const MONTHLY_REPORT = _Paths.MONTHLY_REPORT;
  static const GEO_PROGRAM_UPDATE = _Paths.GEO_PROGRAM_UPDATE;
  static const EDI_RO_BOOKING = _Paths.EDI_RO_BOOKING;
  static const WORKFLOW_DEFINITION = _Paths.WORKFLOW_DEFINITION;
  static const E_D_I_MAPPING = _Paths.E_D_I_MAPPING;
  static const COMMERCIAL_CREATION_AUTO = _Paths.COMMERCIAL_CREATION_AUTO;
  static const COMMERCIAL_LANGUAGE_SPECIFICATION =
      _Paths.COMMERCIAL_LANGUAGE_SPECIFICATION;
  static const ONE_SPOT_BOOKING_SKY_MEDIA = _Paths.ONE_SPOT_BOOKING_SKY_MEDIA;
  static const PERIODIC_DEAL_UTILISATION_FORMAT2 =
      _Paths.PERIODIC_DEAL_UTILISATION_FORMAT2;
  static const UPDATE_EXECUTIVE = _Paths.UPDATE_EXECUTIVE;
  // static const USER_GROUPS_FOR_DEAL_WORKFLOW = _Paths.USER_GROUPS_FOR_DEAL_WORKFLOW;
  static const USER_GROUPS_FOR_DEAL_WORKFLOW =
      _Paths.USER_GROUPS_FOR_DEAL_WORKFLOW;
  static const NEW_SHORT_CONTENT_FORM = _Paths.NEW_SHORT_CONTENT_FORM;
  static const VIEW_OLD_DEAL = _Paths.VIEW_OLD_DEAL;

  static const RATE_CARDFROM_DEAL_WORKFLOW = _Paths.RATE_CARDFROM_DEAL_WORKFLOW;
  static const ZONE_WISE_INVENTORY_UTILIZATION =
      _Paths.ZONE_WISE_INVENTORY_UTILIZATION;
  static const RESCHEDULE_IMPORT = _Paths.RESCHEDULE_IMPORT;
  static const AMAGI_SPOT_PLANNING = _Paths.AMAGI_SPOT_PLANNING;
  static const AMAGI_SPOTS_REPLACEMENT = _Paths.AMAGI_SPOTS_REPLACEMENT;
  static const AMAGI_STATUS_REPORT = _Paths.AMAGI_STATUS_REPORT;
  static const INTERNATIONAL_SALES_REPORT = _Paths.INTERNATIONAL_SALES_REPORT;
  static const PRODUCT_LEVEL1 = _Paths.PRODUCT_LEVEL1;
  static const PRODUCT_LEVEL2 = _Paths.PRODUCT_LEVEL2;
  static const PRODUCT_LEVEL3 = _Paths.PRODUCT_LEVEL3;
  static const PRODUCT_MASTER = _Paths.PRODUCT_MASTER;
  static const COMMERCIAL_CREATION_AUTO_DETAILS =
      _Paths.COMMERCIAL_CREATION_AUTO_DETAILS;
  static const DESIGN = _Paths.DESIGN;
  static const COMMON_DOCS = _Paths.COMMON_DOCS;
  static const RELESE_ORDER_RESCHEDULE_TAPE_I_D =
      _Paths.RELESE_ORDER_RESCHEDULE_TAPE_I_D;
  static const DEALVS_R_O_DATA_REPORT = _Paths.DEALVS_R_O_DATA_REPORT;
  static const BOOKING_STATUS_REPORT = _Paths.BOOKING_STATUS_REPORT;
  static const PROGRAM_WISE_REVENUE_REPORT = _Paths.PROGRAM_WISE_REVENUE_REPORT;
  static const DEAL_UTIL_PERIODIC = _Paths.DEAL_UTIL_PERIODIC;
  static const BOOKINGS_AGAINST_P_D_C = _Paths.BOOKINGS_AGAINST_P_D_C;
  static const P_D_C_CHEQUES = _Paths.P_D_C_CHEQUES;
}

abstract class RoutesList {
  RoutesList._();

  static List<String> listRoutes = [
    _Paths.HOME,
    _Paths.BOOKINGS_AGAINST_P_D_C,
    _Paths.CHANGE_R_O_NUMBER,
    _Paths.SAME_DAY_COLLECTION,
    _Paths.ASRUN_DETAILS_REPORT,
    _Paths.AUDIT_STATUS_REPORT,
    _Paths.DEAL_RECO_SUMMARY,
    _Paths.E_D_I_MAPPING,
    _Paths.WORKFLOW_DEFINITION,
    _Paths.PRODUCT_MASTER,
    _Paths.AMAGI_STATUS_REPORT,
    _Paths.AMAGI_SPOT_PLANNING,
    _Paths.AMAGI_SPOTS_REPLACEMENT,
    _Paths.INTERNATIONAL_SALES_REPORT,
    _Paths.NEW_SHORT_CONTENT_FORM,
    _Paths.ONE_SPOT_BOOKING_SKY_MEDIA,
    _Paths.PERIODIC_DEAL_UTILISATION_FORMAT2,
    _Paths.UPDATE_EXECUTIVE,
    _Paths.USER_GROUPS_FOR_DEAL_WORKFLOW,
    _Paths.PRODUCT_LEVEL1,
    _Paths.PRODUCT_LEVEL2,
    _Paths.PRODUCT_LEVEL3,
    _Paths.GEO_PROGRAM_UPDATE,
    _Paths.WORKFLOW_DEFINITION,
    _Paths.VIEW_OLD_DEAL,
    _Paths.ZONE_WISE_INVENTORY_UTILIZATION,
    _Paths.RATE_CARDFROM_DEAL_WORKFLOW,
    _Paths.RESCHEDULE_IMPORT,
    _Paths.RELESE_ORDER_RESCHEDULE_TAPE_I_D,
    _Paths.BOOKING_STATUS_REPORT,
    _Paths.PROGRAM_WISE_REVENUE_REPORT,
    _Paths.DEALVS_R_O_DATA_REPORT,
    _Paths.RO_RECEIVED,
    _Paths.EDI_RO_BOOKING,
    _Paths.COMMERCIAL_LANGUAGE_SPECIFICATION,
    _Paths.DEAL_UTIL_PERIODIC,
    _Paths.MARK_R_OS_FLAG,
  ];

  /* static final RoutesList _instance = RoutesList._();

  factory RoutesList(){
    return _instance;
  }*/
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
  static const GEO_PROGRAM_UPDATE = '/Frmdealedi';
  static const EDI_RO_BOOKING = '/frmXMLROEntry';
  static const ASRUN_DETAILS_REPORT = '/frmAsrundetailsReport';
  static const AUDIT_STATUS_REPORT = '/Frmauditstatusreport';
  static const DEAL_RECO_SUMMARY = '/FrmDealrecosummary';
  static const WORKFLOW_DEFINITION = '/frmDP_ApprovalTrail';
  static const E_D_I_MAPPING = '/frmEDIClientAgencyChannelMapping';
  static const COMMERCIAL_CREATION_AUTO = '/frmCommercialMasterAutoCreate';
  static const COMMERCIAL_LANGUAGE_SPECIFICATION = '/frmCommercialLanguageSpec';
  static const ONE_SPOT_BOOKING_SKY_MEDIA = '/frmDigiTextBooking';
  static const PERIODIC_DEAL_UTILISATION_FORMAT2 =
      '/frmPeriodicDealUtilisation';
  static const UPDATE_EXECUTIVE = '/frmbreakpatternxmlgenration';
  static const USER_GROUPS_FOR_DEAL_WORKFLOW = '/frmDP_UserGroups';
  static const NEW_SHORT_CONTENT_FORM = '/frmNewForm';
  static const VIEW_OLD_DEAL = '/frmviewdeal';

  static const RATE_CARDFROM_DEAL_WORKFLOW = '/frmDP_RateCard';
  static const ZONE_WISE_INVENTORY_UTILIZATION = '/frmZoneWiseInventory';
  static const RESCHEDULE_IMPORT = '/frmRescheduleImport';
  static const AMAGI_SPOT_PLANNING = '/frmAma_Planning';
  static const AMAGI_SPOTS_REPLACEMENT = '/frmSPReports';
  static const AMAGI_STATUS_REPORT = '/frmAmagiSTatus';
  static const INTERNATIONAL_SALES_REPORT = '/Rocanelationotherrevune';
  static const PRODUCT_LEVEL1 = '/frmProductLevel1';
  static const PRODUCT_LEVEL2 = '/frmProductLevel2';
  static const PRODUCT_LEVEL3 = '/frmProductLevel3';
  static const PRODUCT_MASTER = '/frmProductMaster';
  static const COMMERCIAL_CREATION_AUTO_DETAILS =
      '/commercial-creation-auto-details';
  static const DESIGN = '/design';
  static const COMMON_DOCS = '/common-docs';
  static const RELESE_ORDER_RESCHEDULE_TAPE_I_D = '/frmRoReschedule_TapeID';
  static const DEALVS_R_O_DATA_REPORT = '/frmDealvsRODataReport';
  static const BOOKING_STATUS_REPORT = '/frmnewbookingstatus';
  static const PROGRAM_WISE_REVENUE_REPORT = '/frmnewprogramwisereport';
  static const DEAL_UTIL_PERIODIC = '/frmsearching##BMS_DealUtilPeriodic';
  static const BOOKINGS_AGAINST_P_D_C = '/frmBookingsAgainstPDC';
  static const P_D_C_CHEQUES = '/frmPDCs';
}
