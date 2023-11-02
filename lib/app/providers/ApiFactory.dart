// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'Const.dart';

// import '../modules/OperationalFPC/DailyFPCModel.dart';

class ApiFactory {
  static String userId = "";
  static String LOCAL_URL = "http://localhost:9999";
  static String Enviroment =
      const String.fromEnvironment('ENV', defaultValue: 'dev');

  static String WEB_URL = Const.getWebSalescoUrl();
  static String WEB_URL_COMMON = Const.getWebCommonUrl();

  static String BASE_URL = Const.getBaseSalescoAPIUrl();
  static String BASE_URL_COMMON = Const.getBaseCommonAPIUrl();
  static String BASE_URL_LOGIN = Const.getBaseLoginAPIUrl();
  static String LOGIN_URL =
      (kReleaseMode ? Const.getWebLoginUrl() : "http://localhost:9991");

  // api-login-bms-dev.zeeconnect.in
  // api-common-bms-dev.zeeconnect.in
  // api-programming-bms-dev.zeeconnect.in

  static String AZURE_REDIRECT_UI =
      "${kReleaseMode ? WEB_URL : LOCAL_URL}/dashboard";
  static String NOTIFY_URL = (kReleaseMode ? WEB_URL_COMMON : LOCAL_URL);
  static String SPLIT_CLEAR_PAGE = (kReleaseMode ? "in/" : "92/");

  static String MS_TOKEN =
      "https://login.microsoftonline.com/56bd48cd-f312-49e8-b6c7-7b5b926c03d6/oauth2/token";

  static String LOGIN_API = "$BASE_URL_LOGIN/api/Login/GetLogin?";
  static String LOGOUT_API = "$BASE_URL_LOGIN/api/Login/GetLogout?PersonnelNo=";
  static String USER_INFO = "$BASE_URL_LOGIN/api/Login/GetUserinfo";
  static String PERMISSION_API =
      "$BASE_URL_COMMON/api/MDI/GetAllFormDetailsAndPermission?Userid=";
  static String USER_SETTINGS = "$BASE_URL_COMMON/api/MDI/SaveUserSettingData";
  static String FETCH_USER_SETTING = "$BASE_URL_COMMON/api/MDI/GetUserSetting";
  static String MS_PROFILE = "$BASE_URL_LOGIN/api/Login/PostUserProfile";
  static String MS_TOKEN_BACKEND = "$BASE_URL_LOGIN/api/Login/PostApiToken";

  static String MS_TOKEN1 =
      "https://login.microsoftonline.com/56bd48cd-f312-49e8-b6c7-7b5b926c03d6/oauth2/v2.0/token";
  static String MS_AUTH =
      "https://login.microsoftonline.com/56bd48cd-f312-49e8-b6c7-7b5b926c03d6/oauth2/v2.0/token";

  // static String MS_GRAPH_USER_DETAILS = "https://graph.microsoft.com/v1.0/me?\$select=employeeId,mail,givenName";
  static String MS_GRAPH_USER_DETAILS =
      "https://graph.microsoft.com/v1.0/me?\$select=employeeId,mail,givenName,jobTitle,givenName,id,mobilePhone,displayName";
  static String MS_LOGOUT =
      "https://login.microsoftonline.com/common/oauth2/v2.0/logout?post_logout_redirect_uri=";

  /*static String PERMISSION_API =
      BASE_URL + "/api/MDI/GetAllFormDetailsAndPermission?Userid=";
*/
///////////////////////XML Download API////////////////////////
  static String EXPORT_TO_XML = "$BASE_URL_COMMON/api/Common/ConvertTableToXml";
  static String CONVERT_TO_PDF =
      "$BASE_URL_COMMON/api/Common/ConvertTableToPDF";

  ////////////////////// SEARCH ////////////////////////////
  ///
  ///

  static String SEARCH_SEND_NAME(
    String mail,
    String pageName,
  ) {
    var currentDate =
        DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(DateTime.now());
    return "$BASE_URL_COMMON/api/MDI/SaveApplicationPagesFootprintData?UserName=$mail&PageName=$pageName&AccessDate=$currentDate";
  }

  static String SEARCH_VARIANCE(
      {required String viewName,
      required String screenName,
      required String loginCode}) {
    // return BASE_URL + "/api/$screenName/SearchVariance/$viewName";
    return "$BASE_URL_COMMON/api/CommonSearch/SearchVariance/$viewName";
  }

  static String SEARCH_BINDGRID(
      {required String viewName,
      required String screenName,
      required String code}) {
    // return BASE_URL + "/api/$screenName/BindGrid/$viewName,$code";
    return "$BASE_URL_COMMON/api/CommonSearch/BindGrid/$viewName,$code";
  }

  static String SEARCH_MASTER_SEARCH({
    required String name,
    required String valuecolumnname,
    required String TableName,
    required bool chkLikeNotLike,
    required String searchvalue,
    required String screenName,
  }) {
    // return BASE_URL + "/api/$screenName/TextSearch?name=$name&valuecolumnname=$valuecolumnname&TableName=$TableName&chkLikeNotLike=$chkLikeNotLike&searchvalue=$searchvalue";
    return "$BASE_URL_COMMON/api/CommonSearch/TextSearch?name=$name&valuecolumnname=$valuecolumnname&TableName=$TableName&chkLikeNotLike=$chkLikeNotLike&searchvalue=$searchvalue";
  }

  static String SEARCH_EXECUTE_SEARCH({
    required String strViewName,
    required String loginCode,
    required String screenName,
  }) {
    // return BASE_URL + "/api/$screenName/SearchExecute?strViewName=$strViewName";
    return "$BASE_URL_COMMON/api/CommonSearch/SearchExecute?strViewName=$strViewName";
  }

  // static String SEARCH_PIVOT({required String screenName,}) => BASE_URL + "/api/$screenName/SearchPivot";
  static String SEARCH_PIVOT({
    required String screenName,
  }) =>
      "$BASE_URL_COMMON/api/CommonSearch/SearchPivot";

  // static String SEARCH_EXCUTE_PIVOT({required String screenName, required String strViewname,}) => BASE_URL + "/api/$screenName/SearchExecutePivot?strViewName=$strViewname";
  static String SEARCH_EXCUTE_PIVOT({
    required String screenName,
    required String strViewname,
  }) =>
      "$BASE_URL_COMMON/api/CommonSearch/SearchExecutePivot?strViewName=$strViewname";

  static String ADD_SEARCH_VARIANCE({
    required String strViewName,
    required String loginCode,
    required String screenName,
    required String sVariant,
    // required String pivotTemplate,
  }) {
    // return BASE_URL + "/api/$screenName/InsertSearchVariance?strViewName=$strViewName&sVariant=$sVariant";
    return "$BASE_URL_COMMON/api/CommonSearch/InsertSearchVariance?strViewName=$strViewName&sVariant=$sVariant";
  }

  static String DELETE_SEARCH_VARIANCE({
    required String varianceId,
    required String loginCode,
    required String screenName,
  }) {
    // return BASE_URL + "/api/$screenName/DeleteSearchVariance?VarianceId=$varianceId";
    return "$BASE_URL_COMMON/api/CommonSearch/DeleteSearchVariance?VarianceId=$varianceId";
  }

  ////////////////////// DOCS /////////////////////////////

  static String COMMON_DOCS_LOAD(String docKey) =>
      "$BASE_URL_COMMON/api/CommonDoc/loadDocument?DocumentKey=$docKey";
  static String COMMON_DOCS_VIEW(String docId) =>
      "$BASE_URL_COMMON/api/CommonDoc/ViewDocument?DocId=$docId";
  static String get COMMON_DOCS_ADD =>
      "$BASE_URL_COMMON/api/CommonDoc/AddDocument";
  static String COMMON_DOCS_DELETE(String docId) =>
      "$BASE_URL_COMMON/api/CommonDoc/DeleteDocument?DocumentID=$docId";

  /////////////////////////////////////////////////////////
  //////////////////////////// RO RECIEVED /////////////////////////////////

  static String RO_RECEIVED_LOAD = "$BASE_URL/api/ROReceived/OnLoadRoReceived";

  static String RO_RECEIVED_LOAD_GET_CHANNEL({
    required String locationCode,
  }) {
    return "$BASE_URL/api/ROReceived/OnLeaveLocation?LocationCode=$locationCode";
  }

  // static String RO_RECEIVED_DATE_LEAVE({
  //   required String date,
  // }) {
  //   return "$BASE_URL/api/ROReceived/OnLeaveEffectDate?EffectiveDate=$date";
  // }

  static String RO_RECEIVED_RETRIVE({
    required String receivedCode,
  }) =>
      "$BASE_URL/api/ROReceived/RetriveRecords?Code=$receivedCode";

  static String RO_RECEIVED_LEAVE_CLIENT({
    required String locationCode,
    required String channelCode,
    required String clientCode,
  }) {
    return "$BASE_URL/api/ROReceived/OnLeaveClient?ClientCode=$clientCode&LocationCode=$locationCode&ChannelCode=$channelCode";
  }

  static String RO_RECEIVED_DELETE({
    required String id,
    required String remark,
  }) {
    return "$BASE_URL/api/ROReceived/DeleteRecords?IntID=$id&Remarks=$remark";
  }

  static String RO_RECEIVED_SAVE = "$BASE_URL/api/ROReceived/SaveRecords";

  static String RO_RECEIVED_GET_CLIENTS =
      "$BASE_URL/api/ROReceived/GetClientList?ContainSearch=";

  static String RO_RECEIVED_START_DATE_LEAVE({
    required String date,
  }) =>
      "$BASE_URL/api/ROReceived/StartDateOnLeave?EffectiveDate=$date";

///////////////////////////////////////////////////////////////////////////////////////////

////////////////////////// EDI RO BOOKING ///////////////////////////////////////////

  static String EDI_RO_INIT = "$BASE_URL/api/EDIRoBooking/OnLoadXmlRoBooking";
  static String EDI_RO_FILE_LEAVE(fileName, effectiveDate) =>
      "$BASE_URL/api/EDIRoBooking/OnLeaveFileName?FileName=$fileName&EffectiveDate=$effectiveDate";
  static String EDI_RO_LEAVE_LOCATION(locationCode) =>
      "$BASE_URL/api/EDIRoBooking/OnLeaveLocation?LocationCode=$locationCode";
  static String EDI_RO_LEAVE_FILE_NAME_CLAGDETAILS(
          locationName, channelName, clientName, agencyName, effectiveFrom) =>
      "$BASE_URL/api/EDIRoBooking/OnLeaveFileNameClagdetails?LocationName=$locationName&ChannelName=$channelName&ClientName=$clientName&AgencyName=$agencyName&EffectiveFrom=$effectiveFrom";
  static String EDI_RO_AGENCY_LEAVE =
      "$BASE_URL/api/EDIRoBooking/OnAgencyLeave";
  static String EDI_RO_MARK_AS_DONE(fileName) =>
      "$BASE_URL/api/EDIRoBooking/OnMarkAsDone?FileName=$fileName";
  static String EDI_RO_SHOW_LINK = "$BASE_URL/api/EDIRoBooking/ShowLink";

  static String EDI_RO_LEAVE_DEAL_NO(effDate, locationCode, channelCode, dealNo,
          payRouteCode, agencyCode, clientCode, grpPDC) =>
      "$BASE_URL/api/EDIRoBooking/OnLeaveDealNo?EffDate=$effDate&LocationCode=$locationCode&ChannelCode=$channelCode&DealNo=$dealNo&PayRouteCode=$payRouteCode&AgencyCode=$agencyCode&ClientCode=$clientCode&grpPDC=$grpPDC";

  static String EDI_RO_SPOT_FPC_START(
          locationCode, channelCode, telecastDate) =>
      "$BASE_URL/api/EDIRoBooking/SpotFPCStart?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$telecastDate";

  static String EDI_RO_LEAVE_BRAND(brandCode) =>
      "$BASE_URL/api/EDIRoBooking/OnLeaveBrandName?BrandCode=$brandCode";

///////////////////////////////////////////////////////////////////////////////////////////

////////////////////////// Create Break Pattern ///////////////////////////////////////////
  static String CREATE_BREAK_PATTERN_INIT =
      "$BASE_URL/api/CreateBreakPattern/Initialize";

  static String CREATE_BREAK_PATTERN_GET_CHANNEL({
    required String locationCode,
  }) {
    return "$BASE_URL/api/CreateBreakPattern/GetChannelListForUserAndLocation?locationCode=$locationCode";
  }

  static String CREATE_BREAK_PATTERN_GET_DATA({
    required String locationCode,
    required String channelCode,
    required String fromDate,
    required String toDate,
  }) {
    return "$BASE_URL/api/CreateBreakPattern/OnToDateSelected?LocationCode=$locationCode&ChannelCode=$channelCode&FromDate=$fromDate&ToDate=$toDate";
  }

  static String CREATE_BREAK_PATTERN_UPDATE_TRANSTIME({
    required String dayStart,
    required int? commercialTime,
    required bool updateStatus,
  }) {
    return "$BASE_URL/api/CreateBreakPattern/UpdateTransmissionTime?DayStart=$dayStart&CommercialTime=${commercialTime ?? ""}&UpdateStatus=$updateStatus";
  }

  static String CREATE_BREAK_PATTERN_MultiAggregate =
      "$BASE_URL/api/CreateBreakPattern/MultiAggregate";
  static String CREATE_BREAK_PATTERN_SAVE_SEGMENTS =
      "$BASE_URL/api/CreateBreakPattern/SaveSegment";
  static String CREATE_BREAK_PATTERN_SAVE_BREAK_PATTERN =
      "$BASE_URL/api/CreateBreakPattern/Save";

  static String CREATE_BREAK_PATTERN_BREAK_FILE({
    required String locationCode,
    required String channelCode,
    required String fromDate,
    required String toDate,
  }) {
    return "$BASE_URL/api/CreateBreakPattern/Break?LocationCode=$locationCode&ChannelCode=$channelCode&FromDate=$fromDate&ToDate=$toDate";
  }

//////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////Pending TC & Technical Check: UI: Sanjaya Jena API: Patta Nigam////////////////////////////////////////////////////////////////////////

  static String PENDING_TC_MASTER =
      "$BASE_URL/api/TechnicalCheck/PendingTCInfo?PersonnelNo=";

  static String PENDING_TC_LIST(
      {required String frmDt,
      required String toDt,
      required String contentType,
      String? branchCode}) {
    return "$BASE_URL/api/TechnicalCheck/PendingTCList/$frmDt,$toDt,$contentType,$branchCode";
  }

  static String TECHNICAL_CHECK_MASTER =
      "$BASE_URL/api/TechnicalCheck/GetInfoLoad/0";

// START --> Contnet Inward

  static String CI_DASHBOARD_INTIAL_DATA =
      "$BASE_URL/api/cidashboard/GetInit?PersonnelNo=";

  static String CI_DASHBOARD_PROGRAM_SEARCH =
      "$BASE_URL/api/cidashboard/GetProgram?search=";

  static String CI_DASHBOARD_PROGRAM_SEARCH1 =
      "$BASE_URL/api/cidashboard/GetProgram1?search=";

  static String CI_DASHBOARD_REPORT = "$BASE_URL/api/cidashboard/GetReport";

  static String CI_INWARD_INTIAL_DATA = "$BASE_URL/api/ciInward/Initialise";

  static String CI_INWARD_DATA =
      "$BASE_URL/api/ciInward/GetInwardDetails?InwardCode=";
  static String TECHNICAL_CHECK_SAVE = "$BASE_URL/api/TechnicalCheck/TCSave";

  static String TECHNICAL_CHECK_GET_TC_DATA =
      "$BASE_URL/api/TechnicalCheck/TCNoSelect";

  static String TECHNICAL_CHECK_GET_FAULTDESC =
      "$BASE_URL/api/TechnicalCheck/FaultCategorySelect";

  static String TECHNICAL_CHECK_MASTER1(
      {required String programName,
      required String contentType,
      required String epNo,
      required String inWardCode}) {
    return "$BASE_URL/api/TechnicalCheck/InfoPopulate?ProgramName=$programName&ContentType=$contentType&EpisodeNumber=$epNo&InwardCode=$inWardCode";
  }

////////////////////////////////////////////////////End Pending TC & Technical Check//////////////////////////////////////////////////////////

  static String CI_BMS_PH_DATA =
      "$BASE_URL/api/ciInward/GetPHAndBMSProgram?ProgramCode=";

  static String CI_DASHBOARD_SENDMAIL({
    required int tcNo,
    required String tcStatus,
    required bool resendmail,
  }) {
    return "${BASE_URL}api/cidashboard/SendEmail?TCNo=$tcNo&TCStatus=$tcStatus&ResendMail=$resendmail";
  }

  static String CI_SAVE_FORM = "$BASE_URL/api/ciInward/Save";

// END --> Contnet Inward

  ///////////////////////////////// New Short Content Form /////////////////////////////////////
  static String NEW_SHORT_CONTENT_INIT =
      "$BASE_URL/api/ShortCode/OnLoadShortCode";
  static String NEW_SHORT_CONTENT_GetVignetee =
      "$BASE_URL/api/ShortCode/GetVigneteeTypeMaster";
  static String NEW_SHORT_CONTENT_GetStillTypeMaster =
      "$BASE_URL/api/ShortCode/GetStillTypeMaster";
  static String NEW_SHORT_CONTENT_GetSlideTypeMaster =
      "$BASE_URL/api/ShortCode/GetSlideTypeMaster";

  static String NEW_SHORT_CONTENT_LOCATION_LEAVE(locationCode) =>
      "$BASE_URL/api/ShortCode/OnLeaveLocation?LocationCode=$locationCode";
  static String NEW_SHORT_CONTENT_Type_LEAVE(formCode) =>
      "$BASE_URL/api/ShortCode/OnLeaveType?FormCode=$formCode";
  static String NEW_SHORT_CONTENT_Program_Search =
      "$BASE_URL/api/ShortCode/OnFillComboProgram?TextSourceProgram=";
  static String NEW_SHORT_CONTENT_HOUSEID_LEAVE(
          houseCode, ShortName, StrCode) =>
      "$BASE_URL/api/ShortCode/HouseIDOnLeave?HouseID=$houseCode&TextBoxShortName=$ShortName&strCode=$StrCode";
  static String NEW_SHORT_CONTENT_SAVE = "$BASE_URL/api/ShortCode/SaveRecords";
  ////////////////////////////////////////////////////////////////////////////////////////

  ////////////////Operatonal FPC Page: UI-> Shreesh Tiwari API-> Ram P Kubde//////////////

  static String OPERATIONAL_FPC_INITIAL_DATA({required String loginId}) {
    return "$BASE_URL/api/DailyFPCReport/DailyFPCInitialise?Userid=$loginId";
  }

  static String OPERATIONAL_FPC_GET_CHANNELS_ON_LOCATION_SELECT(
      {required String loginCode, required String location}) {
    return "$BASE_URL/api/DailyFPCReport/GetChannelAfterLoctionLoad?Userid=$loginCode&LocationCode=$location";
  }

  static String OPERATIONAL_FPC_PROGRAM_SEARCH =
      "$BASE_URL/api/DailyFPCReport/ProgramSearch?SearchText=";

  static String OPERATIONAL_FPC_DAILY_FPC_LIST(
      {required String locationCode,
      required String channelCode,
      required String date}) {
    return '$BASE_URL/api/dailyfpcreport/DailyFpcByDateString?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$date';
  }

  static String OPERATIONAL_FPC_SEGMENT_LIST(
      {required String locationCode,
      required String channelCode,
      required String fpcDuration}) {
    return '$BASE_URL/api/dailyfpcreport/GetBarbDefaultSegment?LocationCode=$locationCode&ChannelCode=$channelCode&FPCDuration=$fpcDuration';
  }

  // static String OPERATIONAL_FPC_SEGMENT_LIST1(
  //     {required String locationCode, required String channelCode, required String date, required DailyFPCModel model}) {
  //   return '$BASE_URL/api/dailyfpcreport/GetSegmentDetails?ProgramCode=${model.programCode}&ExporttapeCode=${model.tapeid}&EpisodeNumber=${model.epsNo.toString()}&OriginalRepeatCode=${model.oriRepCode}&LocationCode=$locationCode&ChannelCode=$channelCode&StartTime=${model.fpcTime}&TelecastDate=$date';
  // }

  // epg API
  static String OPERATIONAL_FPC_GET_EPG(
      {required String locationCode,
      required String channelCode,
      required String programCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetEpgProgramList?LocationCode=$locationCode&ChannelCode=$channelCode&ProgramCode=$programCode';
  }

  static String OPERATIONAL_FPC_GET_DEFAULT_SEGMENT_LIST_LC(
      {required String locationCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetEuropeDetails?Location=$locationCode';
  }

  static String OPERATIONAL_FPC_GET_DEFAULT_SEGMENT_LIST_EUROPE_DETAILS(
      {required String locationCode,
      required String channelCode,
      required String fpcDuration}) {
    return '$BASE_URL/api/dailyfpcreport/GetEuropeDetailsInfo?LocationCode=$locationCode&ChannelCode=$channelCode&FPCDuration=$fpcDuration';
  }

  static String OPERATIONAL_FPC_SAVE_FPC(
      {required String locationCode,
      required String channelCode,
      // required String fpcDuration,
      required String date,
      required bool isStandby,
      required String programCode,
      required String episodeNumber,
      required String tapeId,
      required String fpcTime,
      required String endTime,
      required String oriRepCode,
      required String isModified}) {
    // return BASE_URL + '/api/dailyfpcreport/SaveDailyFPC?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$date&ModifiedBy=$userId&StandBy=$isStandby&ProgramCode=$programCode&EpisodeNumber=$episodeNumber&TapeID=$tapeId&FPCTime=$fpcTime:00&EndTime=$endTime:00&OriginalRepeatCode=$oriRepCode&Modifed=$isModified';
    return '$BASE_URL/api/dailyfpcreport/saveDailyFPC_Data?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$date&ModifiedBy=$userId&StandBy=${isStandby ? "Y" : "N"}&ProgramCode=$programCode&EpisodeNumber=$episodeNumber&TapeID=$tapeId&FPCTime=$fpcTime:00&EndTime=$endTime:00&OriginalRepeatCode=$oriRepCode&Modifed=$isModified';
  }

  static String OPERATIONAL_FPC_SAVE_SEGMENT(
      {required String programCode,
      required String originalRepCode,
      required String tapeId,
      required String segNo,
      required String segCaption,
      required String segDuration,
      required String som}) {
    return '$BASE_URL/api/dailyfpcreport/DefaultSegmentSave?ProgramCode=$programCode&OriginalRepeatCode=$originalRepCode&ExporttapeCode=$tapeId&ModifiedBy=$userId&SegmentNumber=$segNo&ExportTapeCaption=$segCaption&SOM=$som:00&SegmentDuration=$segDuration';
  }

  static String OPERATIONAL_FPC_GetDataAfterProgLoad(
      {required String locationCode,
      required String channelCode,
      required String programCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetDataAfterProgLoad?LocationCode=$locationCode&ChannelCode=$channelCode&ProgramCode=$programCode';
  }

  static String OPERATIONAL_FPC_NEXT_EP(
      {required String locationCode,
      required String channelCode,
      required String teleDate,
      required String orgRepCode,
      required String programCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetNextEpisodeNumber?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$teleDate&ProgramCode=$programCode&OrgRepCode=$orgRepCode';
  }

  static String OPERATIONAL_FPC_GET_TAPE_ID(
      {required int ep,
      required String orgRepCode,
      required String programCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetTapeId?ProgramCode=$programCode&EpisodeNo=$ep&OrgRepCode=$orgRepCode';
  }

  static String OPERATIONAL_FPC_SEGMENT_DETAILS(
      {required String locationCode,
      required String channelCode,
      required String date,
      required String epsNo,
      required String programCode,
      required String originalRepCode,
      required String tapeId,
      required String som}) {
    return '$BASE_URL/api/dailyfpcreport/GetSegmentDetails?ProgramCode=$programCode&ExporttapeCode=$tapeId&EpisodeNumber=$epsNo&OriginalRepeatCode=$originalRepCode&LocationCode=$locationCode&ChannelCode=$channelCode&StartTime=$som&TelecastDate=$date';
  }

  static String OPERATIONAL_FPC_DELETE_SEGMENTS({
    required String programCode,
  }) {
    return '$BASE_URL/api/dailyfpcreport/DeleteDefaultSegmentDetails?ProgramCode=$programCode';
  }

  static String OPERATIONAL_FPC_VALIDATE_ON_SAVE({
    required String locationCode,
    required String channelCode,
    required String date,
  }) {
    return '$BASE_URL/api/dailyfpcreport/GetValidateSaveData?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$date';
  }

  static String OPERATIONAL_FPC_VALIDATE_ON_SAVE1({
    required String locationCode,
    required String channelCode,
    required String date,
  }) {
    return '$BASE_URL/api/DailyFPCReport/GetValidateFPCData';
  }

  static String OPERATIONAL_FPC_VALIDATE_ON_SAVE2({
    required String locationCode,
    required String channelCode,
    required String date,
    required String rowNo,
    required String progCode,
    required String langCode,
    required String orgRepCode,
    required String progTypCode,
    required String epsDur,
    required String fpcTime,
    required String endTime,
    required String progName,
    required String epsNo,
    required String tapeId,
    required String status,
    required String orgRep,
    required String wbs,
    required String caption,
    required String modified,
  }) {
    return '$BASE_URL/api/DailyFPCReport/GetValidateFPCData?locationCode=$locationCode&channelCode=$channelCode&telecastDate=$date&RowNo=$rowNo&ProgramCode=$progCode&LanguageCode=$langCode&OriginalRepeatCode=$orgRepCode&ProgramTypeCode=$progTypCode&EpisodeDuration=$epsDur&FpcTime=$fpcTime&endtime=$endTime&ProgramName=$progName&EpsNo=$epsNo&Tapeid=$tapeId&Status=$status&OriRep=$orgRep&WBS=$wbs&Caption=$caption&Modifed=$modified&OriRepCode=$orgRepCode';
  }

  ////////////////////////////////////////////////////End Operational FPC Page//////////////////////////////////////////////////////////
  ////////////////////////////// START OF ZONE MASTER API///////////////////////////////////
  static String get ZONE_MASTER_INITALIZE =>
      "$BASE_URL/api/ZoneMaster/ZoneMasterInitialise";

  static String ZONE_MASTER_SAVE(
    String zoneCode,
    String zoneName,
    String shortName,
    String startSeries,
    String bShortName,
    String sapSales,
  ) =>
      "$BASE_URL/api/ZoneMaster/SaveZoneMaster?ZoneCode=$zoneCode&ZoneName=$zoneName&ShortName=$shortName&StartSeries=$startSeries&BShortName=$bShortName&SAPSales=$sapSales";
  ////////////////////////////// END OF ZONE MASTER API///////////////////////////////////

  ////////////////////////////// START ZONE WISE COMMERCIAL TIME ALLOCATION/////////////
  static String get ZONE_WISE_COMMERCIAL_TIME_ALLOC_LOCATION_LOAD =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/Location_Load";

  static String get ZONE_WISE_COMMERCIAL_TIME_ALLOC_GET_ALL_CHANNELS =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/Channel_Load";

  static String ZONE_WISE_COMMERCIAL_TIME_ALLOC_GET_CHANNELS_ON_LEAVE(
          String locationCode, String loggedUser) =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/Locations_Leave?LocationCode=$locationCode&LoggedUser=$loggedUser";

  static String ZONE_WISE_COMMERCIAL_TIME_ALLOC_GET_ALL_DISPLAY_RECORD(
          String locationCode, String channelCode) =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/DisplayRecord?LocationCode=$locationCode&ChannelCode=$channelCode";

  static String ZONE_WISE_COMMERCIAL_TIME_ALLOC_SAVE_DATA(
          String locationCode, String channelCode) =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/SaveRecord?LocationCode=$locationCode&ChannelCode=$channelCode";
  ////////////////////////////// END ZONE WISE COMMERCIAL TIME ALLOCATION//////////////
  ///
  ///
  ///////////////////////////// START LOCATION MASTER API///////////////////
  static String LOCATION_MASTER_INITALIZE_CURRENCY =
      "$BASE_URL/api/LocationMaster/FillCurrencyTypeMaster";
  static String LOCATION_MASTER_INITALIZE_TERRITORY =
      "$BASE_URL/api/LocationMaster/FillTerritoryMaster";
  static String LOCATION_MASTER_FETCH_LOCATION(String keyword) =>
      "$BASE_URL/api/LocationMaster/LocationName_leave?LocationName=$keyword";

  // static String LOCATION_MASTER_FETCH_SHORT_NAME({String? locationCode, required String keyword}) =>
  //     "$BASE_URL/api/LocationMaster/ShortName_Leave?ShortName=$keyword${locationCode != null ? "&TextBoxShortName=$locationCode" : ""}";

  static String LOCATION_MASTER_FETCH_SHORT_NAME(String shortName) =>
      "$BASE_URL/api/LocationMaster/ShortName_Leave?ShortName=$shortName";

  // static String LOCATION_MASTER_FETCH_SAP_OFFICE({String? locationCode, required String keyword}) =>
  //     "$BASE_URL/api/LocationMaster/SAPSalesOffice_Leave?SAPSalesOffice=$keyword${locationCode != null ? "&LocationCode=$locationCode" : ""}";

  static String LOCATION_MASTER_FETCH_SAP_OFFICE(String sapSales) =>
      "$BASE_URL/api/LocationMaster/SAPSalesOffice_Leave?SAPSalesOffice=$sapSales";

  static String LOCATION_MASTER_SAVE({
    String? locationCode,
    required String locationName,
    required String locationShortName,
    required String currencyCode,
    required int territorycode,
    required String sapSalesOffice,
    required String loginCode,
  }) =>
      "$BASE_URL/api/LocationMaster/LocationSaveRecords?LocationCode=${locationCode ?? ""}&LocationName=$locationName&LocationShortName=$locationShortName&CurrencyCode=$currencyCode&Territorycode=$territorycode&SAPSalesOffice=$sapSalesOffice&ModifiedBy=$loginCode";
  ///////////////////////////// END LOCATION MASTER API///////////////////
  ///
  ///
  //////////////////////////// START ZONE GROUPING API///////////////////
  static String get ZONE_GROUPING_LOCATION =>
      "$BASE_URL/api/ZoneGrouping/Location_Load";
  static String ZONE_GROUPING_CHANNELS(String locationCode) =>
      "$BASE_URL/api/ZoneGrouping/Channel_Load?LocationCode=$locationCode";
  static String ZONE_GROUPING_GET_ALL_GROUPS(
          String locationCode, String channelCode) =>
      "$BASE_URL/api/ZoneGrouping/PopulateGroup?LocationCode=$locationCode&ChannelCode=$channelCode";
  static String ZONE_GROUPING_GET_LEFT_DATATABLE(
          String lc, String cc, String gc) =>
      "$BASE_URL/api/ZoneGrouping/PopulateGroupedZone?LocationCode=$lc&ChannelCode=$cc&GroupCode=$gc";
  static String ZONE_GROUPING_GET_RIHGT_DATATABLE(
          String lc, String cc, String gc) =>
      "$BASE_URL/api/ZoneGrouping/PopulateGroupedZoneLeft?LocationCode=$lc&ChannelCode=$cc&GroupCode=$gc";
  static String ZONE_GROUPING_SAVE_DATA(String lc, String cc, String gc) =>
      "$BASE_URL/api/ZoneGrouping/SaveZoneGrouping?LocationCode=$lc&ChannelCode=$cc&GroupCode=$gc";
  //////////////////////////// END ZONE GROUPING API///////////////////
  ///
  ///
  ///
  ////////////////////////// START CHANNEL MASTER API//////////////////
  static String get CHANNEL_MASTER_GET_LOCATION =>
      "$BASE_URL/api/ChannelMaster/Location_Load";
  static String get CHANNEL_MASTER_GET_CHANNELS =>
      "$BASE_URL/api/ChannelMaster/Channel_Load";

  static String CHANNEL_MASTER_CHANNEL_EVENT_SPECI_LEFT_DATA(
          String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/Get_ChannelSpecs?LocationCode=$lc&ChannelCode=$cc";
  static String CHANNEL_MASTER_CHANNEL_EVENT_SPECI_RIGHT_DATA(
          String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/EventSpecification?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_CREATE_NEW_CHANNEL_EXIT(
      String channelName, String shortName) {
    return "$BASE_URL/api/ChannelMaster/ShortNameLeave?strShortName=$shortName&ChannelMaster=$channelName";
  }

  static String get CHANNEL_MASTER_SAVE_CREATE_NEW_CHANNEL =>
      "$BASE_URL/api/ChannelMaster/CreateNewChannel";

  static String CHANNEL_MASTER_CREATE_NEW_CHANNEL_GET_ALL_DATA(
          String channelNanme) =>
      "$BASE_URL/api/ChannelMaster/ChannelNameLeave?ChannelName=$channelNanme";

  static String CHANNEL_MASTER_LOG_LEFTDATATABLE_DATA(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/LogSpecificationGrid?LocationCode=$lc&ChannelCode=$cc";
  static String CHANNEL_MASTER_LOG_1ST_QUERY(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/Get_Excel?LocationCode=$lc&ChannelCode=$cc";
  static String CHANNEL_MASTER_LOG_2ND_QUERY(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/Get_ExcelOld?LocationCode=$lc&ChannelCode=$cc";
  static String CHANNEL_MASTER_LOG_3RD_QUERY(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/Get_ExcelNews?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_CHANNEL_BAND_DATA(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/GetBandMaster?LocationCode=$lc&ChannelCode=$cc";

  static String get CHANNEL_MASTER_SAVE_DATA =>
      "$BASE_URL/api/ChannelMaster/ChannelMasterSave";

  static String get CHANNel_MASTER_TIME_BAND_VALIDATION =>
      "$BASE_URL/api/ChannelMaster/Validate";

  static String CHANNEL_MASTER_SAVE_CHANNELEVENTSPECF_RIGHT_TABLE(
          String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveEventSpecs?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_SAVE_CHANNELEVENTSPECF_LEFT_TABLE(
          String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveChannelSpecs?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_SAVE_LOGSPECF_LEFT_TABLE(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveLogSpecs?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_SAVE_LOGSPECF_3QUERY(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveExcelQuery?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_SAVE_CHANNEL_BAND(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveTimeBand?LocationCode=$lc&ChannelCode=$cc";

  ////////////////////////// END CHANNEL MASTER API//////////////////
  ///
  ///
  ///
  ///
  ////////////////////////// START LOGIN MASTER API ////////////////
  static String get LOGIN_MASTER_GET_LOCATION =>
      "$BASE_URL/api/LoginMaster/GetLocation";

  static String LOGIN_MASTER_GET_LOGGEDUSERCHANNELS(String lc) {
    return "$BASE_URL/api/LoginMaster/GetLoggedUserChannels?LoginCode=$lc";
  }

  static String get LOGIN_MASTER_GET_MODULE =>
      "$BASE_URL/api/LoginMaster/GetModule";
  static String get LOGIN_MASTER_GET_ZONE =>
      "$BASE_URL/api/LoginMaster/GetZone";
  static String get LOGIN_MASTER_GET_BRANCH =>
      "$BASE_URL/api/LoginMaster/GetBranch";
  static String get LOGIN_MASTER_GET_USER_DETAILS =>
      "$BASE_URL/api/LoginMaster/GetUserDetails";
  static String get LOGIN_MASTER_GET_ZONE_1 =>
      "$BASE_URL/api/LoginMaster/GetZoneName1";

  static String get LOGIN_MASTER_GET_USER_LIST =>
      "$BASE_URL/api/LoginMaster/GetUserDetails?SearchValue=";

  static String LOGIN_MASTER_GET_USER_ALL_INFO(String ln,
          {String? lc,
          bool fromCopyRIghts = false,
          bool chkCopyTransactionRights = false,
          bool chkCopyLocationChannelZoneRights = false}) =>
      "$BASE_URL/api/LoginMaster/GetLoginInfo?LoginName=$lc&LoginCode=&iscopy=$fromCopyRIghts&chkCopyTransactionRights=$chkCopyTransactionRights&chkCopyLocationChannelZoneRights=$chkCopyLocationChannelZoneRights";

  static String LOGIN_MASTER_GET_EMPLOYEE_DETAILS(String sapID) =>
      "$BASE_URL/api/LoginMaster/GetEmployeeDetails?SAPID=$sapID";
  static String get LOGIN_MASTER_GET_MODULE_FORM_DETAILS =>
      "$BASE_URL/api/LoginMaster/GetModuleFormDetails";

  static String LOGIN_MASTER_LOCATION_CHANNEL_ZONE_RIGHT_ACTIVE_ZONE(
          String lc, String cd) =>
      "$BASE_URL/api/LoginMaster/GetActiveZoneDetails?LocationCode=$lc&ChannelCode=$cd";

  static String get LOGIN_MASTER_SAVE_ALL_CHANNELS_LOCATIONS_ZONE_RIGHTS =>
      "$BASE_URL/api/LoginMaster/SaveAddChannelAndLocationRight";
  static String get LOGIN_MASTER_SAVE_BUDGET_EMPLOYEE_LOGIN =>
      "$BASE_URL/api/LoginMaster/SaveBudgetEmployeeLogin";
  static String get LOGIN_MASTER_SAVE_TC_INWARD_USER_DETAILS =>
      "$BASE_URL/api/LoginMaster/SaveInwardUserDtls";
  static String get LOGIN_MASTER_SAVE_LOGIN_MASTER =>
      "$BASE_URL/api/LoginMaster/SaveLoginMaster";

  ////////////////////////// END LOGIN MASTER API ////////////////
  ///
  ///
  ///
  ///////////////////////// START MODULE FORM TRANSACTION API//////
  static String get MODULE_FORM_TRANSACTION_GET_MODULE_FORMS_LIST =>
      "$BASE_URL/api/ModuleFormTransaction/Initialisation";

  static String get MODULE_FORM_TRANSACTION_ADD_MODULE_SAVE =>
      "$BASE_URL/api/ModuleFormTransaction/SaveModuleData";
  static String get MODULE_FORM_TRANSACTION_ADD_FORM_SAVE =>
      "$BASE_URL/api/ModuleFormTransaction/SaveFormData";
  static String get MODULE_FORM_TRANSACTION_FORM_DELETE_SAVE =>
      "$BASE_URL/api/ModuleFormTransaction/SaveFormModuleMappingData";

  static String MODULE_FORM_TRANSACTION_GET_MODULE_LIST(String moduleCode) =>
      "$BASE_URL/api/ModuleFormTransaction/GetModuleFormDetails?ModuleCode=$moduleCode";
  ///////////////////////// END MODULE FORM TRANSACTION API//////

///////////////////////////// Asrun Details Report ///////////////////////////////

  static String get ASRUN_DETAILS_REPORT_LOAD =>
      "$BASE_URL/api/AsrundetailsReport/AsrundetailsReportLoad";
  static String get ASRUN_DETAILS_REPORT_GENERATE =>
      "$BASE_URL/api/AsrundetailsReport/GenerateReport";

////////////////////////////// Audit Status Report ////////////////////////////////////////////////

  static String get AUDIT_STATUS_REPORT_LOAD =>
      "$BASE_URL/api/AuditStatusReport/auditstatusreport_Load";
  static String get AUDIT_STATUS_REPORT_GENERATE_TOLIST =>
      "$BASE_URL/api/AuditStatusReport/GenrateOTList";
  static String get AUDIT_STATUS_REPORT_GENERATE_AUDIT =>
      "$BASE_URL/api/AuditStatusReport/GenrateAudit";

  static String get AUDIT_STATUS_REPORT_GENERATE_AUDIT_CANCEl =>
      "$BASE_URL/api/AuditStatusReport/GenrateCancel";

  ////////////////////////////// EDIMAPPING ////////////////////////////////

  static String get EDI_MAPPING_CLIENT_SEARCH =>
      "$BASE_URL/api/EDIMapping/GetClientMasterSearch?TextClientMaster=";
  static String get EDI_MAPPING_AGENT_SEARCH =>
      "$BASE_URL/api/EDIMapping/GetAgencyMasterSearch?TextAgencyMaster=";
  static String get EDI_MAPPING_CHANNEL_SEARCH =>
      "$BASE_URL/api/EDIMapping/GetChannelMasterSearch?TextChannelMaster=";
  static String get EDI_MAPPING_POPULATE_ENTITY =>
      "$BASE_URL/api/EDIMapping/GetPopulateEntity";
  static String get EDI_MAPPING_UPDATE_SOFT_CLIENT =>
      "$BASE_URL/api/EDIMapping/Updatesoftclient";

  ///////////////////////////////////// DealRecoSummary ////////////////////////////////////////////////////

  static String get DEAL_RECO_SUMMARY_LOAD =>
      "$BASE_URL/api/DealReCoSummary/Dealrecosummary_Load";
  static String get DEAL_RECO_SUMMARY_GET_CLIENT =>
      "$BASE_URL/api/DealReCoSummary/GetClient?locationName=";
  static String get DEAL_RECO_SUMMARY_GET_AGENCY =>
      "$BASE_URL/api/DealReCoSummary/GetAgency";
  static String get DEAL_RECO_SUMMARY_GET_DEAL =>
      "$BASE_URL/api/DealReCoSummary/GetDeal";
  static String get DEAL_RECO_SUMMARY_GET_DEAL_LEAVE =>
      "$BASE_URL/api/DealReCoSummary/DealLeave";
  static String get DEAL_RECO_SUMMARY_GENERATE =>
      "$BASE_URL/api/DealReCoSummary/GetGenrate";

  /////////////////////////////// DealWorkFlow Definition ///////////////////////////////////////
  static String get DEAL_WORK_FLOW_DEFINITION_LOAD =>
      "$BASE_URL/api/DealWorkflowDefinition/GetDWFOnLoad";
  static String get DEAL_WORK_FLOW_DEFINITION_GET_GROUP_SEARCH =>
      "$BASE_URL/api/DealWorkflowDefinition/GetGroupSearch?TextGroupSearch=";
  static String get DEAL_WORK_FLOW_DEFINITION_GET_USER_SEARCH =>
      "$BASE_URL/api/DealWorkflowDefinition/GetuserSearch?TextUserSearch=";
  static String get DEAL_WORK_FLOW_DEFINITION_ON_LEAVE_COPYZONE =>
      "$BASE_URL/api/DealWorkflowDefinition/GetCopyZoneOnLeave?ZoneCode=";
  static String get DEAL_WORK_FLOW_DEFINITION_ON_LEAVE_ZONE =>
      "$BASE_URL/api/DealWorkflowDefinition/GetZoneOnLeave?ZoneCode=";
  static String get DEAL_WORK_FLOW_DEFINITION_ON_LEAVE_LOCATION =>
      "$BASE_URL/api/DealWorkflowDefinition/GetLocationOnLeave?LocationCode=";
  static String get DEAL_WORK_FLOW_DEFINITION_GET_DISPLAY =>
      "$BASE_URL/api/DealWorkflowDefinition/GetDisplay";
  static String get DEAL_WORK_FLOW_DEFINITION_SAVE =>
      "$BASE_URL/api/DealWorkflowDefinition/Postsave";

  //////////////////////////////////////// GeoProgramUpdate ////////////////////////////
  static String get GEO_PROGRAM_UPDATE_LOAD =>
      "$BASE_URL/api/GeoProgramUpdate/GetGPUOnLoad";
  static String get GEO_PROGRAM_UPDATE_UPDATE =>
      "$BASE_URL/api/GeoProgramUpdate/PostUpdate";

  //////////////////////////////// OneSpotBooking ////////////////////////////////
  static String get ONE_SPOT_BOOKING_LOAD =>
      "$BASE_URL/api/OneSpotBooking/GetOSBOnload";
  static String get ONE_SPOT_BOOKING_CHANNEL_LEAVE =>
      "$BASE_URL/api/OneSpotBooking/GetChannelOnLeave?locationcode=";
  static String get ONE_SPOT_BOOKING_SAVE =>
      "$BASE_URL/api/OneSpotBooking/PostSave";

  /////////////////////////////////// International Sales Report /////////////////////////////
  static String get INTERNATIONAL_SALES_REPORT_GENERATE =>
      "$BASE_URL/api/InternationalSalesReport/Generate";
  //////////////////////////////////////// PeriodicDealUtilisationFormat2 /////////////////////////////
  static String get PERIODIC_DEAL_UTILISATION_FORMAT2_LOAD =>
      "$BASE_URL/api/PeriodicDealUtilisation/GetPDUOnload";
  static String get PERIODIC_DEAL_UTILISATION_FORMAT2_ON_CHANNEL_LEAVE =>
      "$BASE_URL/api/PeriodicDealUtilisation/GetChannelOnLeave";

////////////////////////////////////////////// User Groups For Deal Work flow  //////////////////////////////////////////
  static String get USER_GROUPS_FOR_DEAL_WORKFLOW_EmpSearch =>
      "$BASE_URL/api/UserGroupsForDealWorkflow/GetEmployeeSearch?TextEmployeeSearch=";
  static String get USER_GROUPS_FOR_DEAL_WORKFLOW_GET_DISPLAY_GROUP =>
      "$BASE_URL/api/UserGroupsForDealWorkflow/GetDisplayGroup?GroupName=";
  static String get USER_GROUPS_FOR_DEAL_WORKFLOW_SAVE =>
      "$BASE_URL/api/UserGroupsForDealWorkflow/Save";

  //////////////////////////////////////////////// Update Executive ////////////////////////////////////////////////////////
  static String get UPDATE_EXECUTIVE_LOAD =>
      "$BASE_URL/api/UpdateExecutive/GetUEOnLoad";
  static String get UPDATE_EXECUTIVE_GET_CLIENT =>
      "$BASE_URL/api/UpdateExecutive/Getclient";
  static String get UPDATE_EXECUTIVE_GET_AGENCY =>
      "$BASE_URL/api/UpdateExecutive/GetAgency";
  static String get UPDATE_EXECUTIVE_GET_VERIFY =>
      "$BASE_URL/api/UpdateExecutive/GetVerifiy";
  static String get UPDATE_EXECUTIVE_UPDATE_EXECUTIVE =>
      "$BASE_URL/api/UpdateExecutive/UpdateExecutive";

  ///////////////////////////////////// Product Level 1 //////////////////////////////
  static String get PRODUCT_LEVEL1_LOAD =>
      "$BASE_URL/api/ProductLevelOne/GetPT1OnLoad";
  static String get PRODUCT_LEVEL1_RETRIEVE =>
      "$BASE_URL/api/ProductLevelOne/GetRetrieveRecord";
  static String get PRODUCT_LEVEL1_SAVE =>
      "$BASE_URL/api/ProductLevelOne/PostSave";

  /////////////////////////////////// Product Level 2 ////////////////////////////////
  static String get PRODUCT_LEVEL2_LOAD =>
      "$BASE_URL/api/ProductLevelTwo/GetPTTwoOnLoad";
  static String get PRODUCT_LEVEL2_GET_PRODUCT_LEVEL1 =>
      "$BASE_URL/api/ProductLevelTwo/GetProductLevelOne";
  static String get PRODUCT_LEVEL2_RETRIEVE =>
      "$BASE_URL/api/ProductLevelTwo/GetRetrieveRecord";
  static String get PRODUCT_LEVEL2_SAVE =>
      "$BASE_URL/api/ProductLevelTwo/PostSave";

  //////////////////////////////// Product Level 3 //////////////////////////////////
  static String get PRODUCT_LEVEL3_LOAD =>
      "$BASE_URL/api/ProductLevelThree/GetproductType";
  static String get PRODUCT_LEVEL3_GET_PRODUCT_LEVEL1 =>
      "$BASE_URL/api/ProductLevelThree/GetProductLeaveOne";
  static String get PRODUCT_LEVEL3_GET_PRODUCT_LEVEL2 =>
      "$BASE_URL/api/ProductLevelThree/GetProductLevelTwo";
  static String get PRODUCT_LEVEL3_RETRIEVE =>
      "$BASE_URL/api/ProductLevelThree/Retrieverecord";
  static String get PRODUCT_LEVEL3_SAVE =>
      "$BASE_URL/api/ProductLevelThree/PostSave";

  /////////////////////////////////////// Product Master ///////////////////////////////
  static String get PRODUCT_MASTER_GET_PRODUCT_LEVEL_THREE =>
      "$BASE_URL/api/ProductMaster/GetProductLevelThree";
  static String get PRODUCT_MASTER_GET_RETRIEVE_RECORD =>
      "$BASE_URL/api/ProductMaster/GetRetrieveRecord";
  static String get PRODUCT_MASTER_POST =>
      "$BASE_URL/api/ProductMaster/PostSave";

  ///////////////////////////////////// ViewOldDeals //////////////////////////////////////
  static String get ViewOldDeals_LOAD =>
      "$BASE_URL/api/ViewOldDeals/viewdeal_Load";
  static String get ViewOldDeals_GET_CLIENT =>
      "$BASE_URL/api/ViewOldDeals/GetClient";
  static String get ViewOldDeals_GET_AGENCY =>
      "$BASE_URL/api/ViewOldDeals/GetAgency";
  static String get ViewOldDeals_GET_DEAL =>
      "$BASE_URL/api/ViewOldDeals/GetDeal";
  static String get ViewOldDeals_GET_DEAL_LEAVE =>
      "$BASE_URL/api/ViewOldDeals/GetDeal_leave";

  //////////////////////////////////// ZoneWiseInventory ////////////////////////////////////////////
  static String get ZoneWiseInventory_LOAD =>
      "$BASE_URL/api/ZoneWiseInventory/GetLocation";
  static String get ZoneWiseInventory_GET_CHANNEL =>
      "$BASE_URL/api/ZoneWiseInventory/GetChannel";
  static String get ZoneWiseInventory_GENERATE =>
      "$BASE_URL/api/ZoneWiseInventory/Generate";

  /////////////////////////////////// RateCardfromDealWorkflow /////////////////////////////////
  static String get Rate_Card_From_Deal_Workflow_LOAD =>
      "$BASE_URL/api/DPRateCard/GetLocationLoad";
  static String get Rate_Card_From_Deal_Workflow_GET_Channel =>
      "$BASE_URL/api/DPRateCard/GetChannel";
  static String get Rate_Card_From_Deal_Workflow_Export =>
      "$BASE_URL/api/DPRateCard/Export";
  static String get Rate_Card_From_Deal_Workflow_SAVE =>
      "$BASE_URL/api/DPRateCard/Save";

///////////////////////////////////////////// Amagi Spot Planning //////////////////////////
  static String get Amagi_Spot_Planning_LOAD =>
      "$BASE_URL/api/AmagiSpotPlanning/GetLocation";
  static String get Amagi_Spot_Planning_Get_Channel =>
      "$BASE_URL/api/AmagiSpotPlanning/GetChannel?LocationCode=";
  static String get Amagi_Spot_Planning_Get_Generate =>
      "$BASE_URL/api/AmagiSpotPlanning/Generate";

  ///////////////////////////////////////// Amagi Status Report /////////////////////////////////////////////
  static String get Amagi_Status_Report_LOAD =>
      "$BASE_URL/api/AmagiStatusReport/AmagiSTatusLoad";
  static String get Amagi_Status_Report_Get_Channel =>
      "$BASE_URL/api/AmagiStatusReport/GetChannel?locationcode=";
  static String get Amagi_Status_Report_RetrieveData =>
      "$BASE_URL/api/AmagiStatusReport/RetrieveData";

  //////////////////////////////////////// Reschedule Import //////////////////////////////////////
  static String get Reschedule_Import_LOAD =>
      "$BASE_URL/api/RescheduleImport/GetLocation";
  static String get Reschedule_Import_Get_Channel =>
      "$BASE_URL/api/RescheduleImport/GetChannel?locationcode=";
  static String get Reschedule_Import_ReImport =>
      "$BASE_URL/api/RescheduleImport/ReImport";

  ///
  ///
  ///
  ///
  ///
  ///
  ///////////////////////// CHANGE-RO-NUMBER-START//////
  static String get CHANGE_RO_NUMBER_ON_LOAD =>
      "$BASE_URL/api/ChangeRONumber/GetLocation";
  static String get CHANGE_RO_NUMBER_UPDATE_DATA =>
      "$BASE_URL/api/ChangeRONumber/ShowDeal";
  static String CHANGE_RO_NUMBER_ON_LEAVE_LOCATION(String locationCode) =>
      "$BASE_URL/api/ChangeRONumber/GetChannel?LocationCode=$locationCode";
  ///////////////////////// CHANGE-RO-NUMBER-END//////
  ///
  ///
  ///
  ///
  ///
  ///
  ///////////////////////// SAME-DAY-COLLECTION-START//////
  static String get SAME_DAY_COLLECTION_ON_LOAD =>
      "$BASE_URL/api/SameDayCancellation/GetLocation";
  static String get SAME_DAY_COLLECTION_SAVE_DATA =>
      "$BASE_URL/api/SameDayCancellation/Save";
  static String SAME_DAY_COLLECTION_ON_LEAVE_LOCATION(String locationCode) =>
      "$BASE_URL/api/SameDayCancellation/GetChannel?LocationCode=$locationCode";
  static String SAME_DAY_COLLECTION_SHOW_DATA(
          String locationCode, String channelCode) =>
      "$BASE_URL/api/SameDayCancellation/Show?LocationCode=$locationCode&Channelcode=$channelCode";
  ///////////////////////// SAME-DAY-COLLECTION-END//////
  ///
  ///
  ///
  ///
  ///
  ///////////////////////// TAPE-ID-CAMPAIGN-START//////
  static String TAPE_ID_CAMPAIGN_ON_LEAVE(String tapeID) =>
      "$BASE_URL/api/TapeIDCampaign/TapeIdDetails?TapeId=$tapeID";
  static String TAPE_ID_CAMPAIGN_GET_HISTORY(String tapeID) =>
      "$BASE_URL/api/TapeIDCampaign/TapeIdHistoryDetails?TapeId=$tapeID";
  static String get TAPE_ID_CAMPAIGN_UPDATE_HISTORY =>
      "$BASE_URL/api/TapeIDCampaign/TapeIdHistoryUpdate";
  static String get TAPE_ID_CAMPAIGN_SAVE_RECORD =>
      "$BASE_URL/api/TapeIDCampaign/Save";
  static String get TAPE_ID_CAMPAIGN_IMPORT =>
      "$BASE_URL/api/TapeIDCampaign/Import";
  static String get TAPE_ID_CAMPAIGN_CAMPAIGN_HISTORY =>
      "$BASE_URL/api/TapeIDCampaign/CampaignHistory";
  static String get TAPE_ID_CAMPAIGN_TAPE_CAMPAIGN_DETAILS =>
      "$BASE_URL/api/TapeIDCampaign/TapeIDCampaignDetail";
  ///////////////////////// TAPE-ID-CAMPAIGN-END//////
  ///
  ///
  ///
  ///
  ///////////////////////// MANAGE-CHANNEL-LOCKS-START//////
  static String get MANAGE_CHANNEL_LOCKS_GET_LOCATION =>
      "$BASE_URL/api/ManageChannelsLocks/GetLocation";
  static String MANAGE_CHANNEL_LOCKS_GET_DATA(String locationCode) =>
      "$BASE_URL/api/ManageChannelsLocks/Show?LocationCode=$locationCode";
  static String get MANAGE_CHANNEL_LOCKS_SAVE =>
      "$BASE_URL/api/ManageChannelsLocks/Save";
  ///////////////////////// MANAGE-CHANNEL-LOCKS-END//////
  ///
  ///
  ///
  ///
  ///
  ///////////////////////// MONTHLY-REPORT-START//////
  static String get MONTHLY_REPORT_GET_LOCATION =>
      "$BASE_URL/api/MonthlyReport/GetLocation";
  static String get MONTHLY_REPORT_GET_CHANNEL =>
      "$BASE_URL/api/MonthlyReport/GetChannel";
  static String get MONTHLY_REPORT_GET_DATA =>
      "$BASE_URL/api/MonthlyReport/Show";
  ///////////////////////// MONTHLY-REPORT-END//////
  ///
  ///
  ///
  ///
  ///
  ///////////////////////// MARK-ROS-FLAG-START//////
  static String get MARK_ROS_FLAG_GET_LOCATION =>
      "$BASE_URL/api/ManageROSFlags/GetLocation";
  static String MARK_ROS_FLAG_GET_CHANNEL(String locationCode) =>
      "$BASE_URL/api/ManageROSFlags/GetChannel?LocationCode=$locationCode";
  static String MARK_ROS_FLAG_GET_DATA(
          String locationCode, String channelCode, String fromDate) =>
      "$BASE_URL/api/ManageROSFlags/Show?LocationCode=$locationCode&ChannelCode=$channelCode&EffectiveDate=$fromDate";
  static String get MARK_ROS_FLAG_SAVE => "$BASE_URL/api/ManageROSFlags/Save";
  ///////////////////////// MARK-ROS-FLAG-END//////
  ///
  ///
  ///
  ///
  ///
  ///////////////////////// MAKE-GOOD-REPORT-START//////
  static String get MAKE_GOOD_REPORT_GET_LOCATION =>
      "$BASE_URL/api/MakeGoodReport/GetLocation";
  static String get MAKE_GOOD_REPORT_GET_CHANNEL =>
      "$BASE_URL/api/MakeGoodReport/GetChannel";
  static String MAKE_GOOD_REPORT_GET_CLIENT(String locationName,
          String channelName, String fromDate, String toDate) =>
      "$BASE_URL/api/MakeGoodReport/GetClient?LocationName=$locationName&ChannelName=$channelName&Fromdate=$fromDate&ToDate=$toDate";
  static String MAKE_GOOD_REPORT_GET_AGENCY(
          String locationName, String channelName, String clientName) =>
      "$BASE_URL/api/MakeGoodReport/GetAgency?LocationName=$locationName&ChannelName=$channelName&Clientname=$clientName";
  static String get MAKE_GOOD_REPORT_GET_BRAND =>
      "$BASE_URL/api/MakeGoodReport/GetBrand";
  static String get MAKE_GOOD_REPORT_GET_GENERATE =>
      "$BASE_URL/api/MakeGoodReport/Generate";
  ///////////////////////// MAKE-GOOD-REPORT-END//////
  ///
  ///
  ///////////////////////// MAKE-GOOD-REPORT-START//////
  static String get COMMERCIAL_LANG_SPEC_LOCATION =>
      "$BASE_URL/api/CommercialLanguageSpec/GetLocation";
  static String COMMERCIAL_LANG_SPEC_CHANNEL(String locName) =>
      "$BASE_URL/api/CommercialLanguageSpec/GetLocationsLeave?LocationCode=$locName";
  static String COMMERCIAL_LANG_SPEC_DISPLAY(String loc, String chanl) =>
      "$BASE_URL/api/CommercialLanguageSpec/GetDisplay?LocationCode=$loc&channlecode=$chanl";
  static String get COMMERCIAL_LANG_SPEC_SAVE =>
      "$BASE_URL/api/CommercialLanguageSpec/PostSave";
  ///////////////////////// MAKE-GOOD-REPORT-END//////
  ///
  ///
  ///
  ///
  ///////////////////////// COMERCIAL CREATION AUTO/////////
  static String COMMERCIAL_CREATION_GET_LOAD() =>
      "$BASE_URL/api/CommercialMasterAuto/GetLoad";
  static String COMMERCIAL_CREATION_PROVIDER_LIST(String provider) =>
      "$BASE_URL/api/CommercialMasterAuto/GetProviderSelect?Provider=$provider";
  static String COMMERCIAL_CREATION_CLIENT_LEAVE(String clientMaster) =>
      "$BASE_URL/api/CommercialMasterAuto/GetClientMasterLeave?ClientMaster=$clientMaster";
  static String COMMERCIAL_CREATION_CLIENT_LIST() =>
      "$BASE_URL/api/CommercialMasterAuto/GetClientMaster?SearchText=";
  static String COMMERCIAL_CREATION_BRAND_LIST(String client) =>
      "$BASE_URL/api/CommercialMasterAuto/GetBrandMaster?Clientcode=$client&SearchText=";
  static String COMMERCIAL_CREATION_SHOW_ACID(String acid) =>
      "$BASE_URL/api/CommercialMasterAuto/GetShowACID?acid=$acid";
  static String COMMERCIAL_CREATION_REVENUE_TYPE_SELECT(String revenue) =>
      "$BASE_URL/api/CommercialMasterAuto/GetrevenuetypeSelect?revenuetype=$revenue";
  static String COMMERCIAL_CREATION_SELECT_CLIENT(String clientCode) =>
      "$BASE_URL/api/CommercialMasterAuto/GetClientMasterByCode?SearchValue=$clientCode";
  static String COMMERCIAL_CREATION_SELECT_BRAND(String clientCode) =>
      "$BASE_URL/api/CommercialMasterAuto/GetBrandMasterByCode?SearchValue=$clientCode";
  static String COMMERCIAL_CREATION_EOM_SELECT(String som, String eom) =>
      "$BASE_URL/api/CommercialMasterAuto/GetEOMSelect?EOM=$som&SOM=$eom";
  static String COMMERCIAL_CREATION_SAVE() =>
      "$BASE_URL/api/CommercialMasterAuto/PostSave";
  ///////////////////////// End: COMERCIAL CREATION AUTO ////////////
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  ///
  //////////////////////////////// RO_RESCHEDULE_TAPE_ID START /////////////////////////////////////
  static String get RO_RESCHEDULE_TAPE_ID_ON_LOAD =>
      "$BASE_URL/api/RORescheduleTapeID/GetLoad";
  static String get RO_RESCHEDULE_TAPE_ID_SAVE_DATA =>
      "$BASE_URL/api/RORescheduleTapeID/PostSave";
  static String RO_RESCHEDULE_TAPE_ID_GET_CHANNELS(String locationCode) =>
      "$BASE_URL/api/RORescheduleTapeID/GetlocationLeave?LocationCode=$locationCode";
  static String RO_RESCHEDULE_TAPE_ID_GET_CLIENT(
          String locationCode, String channelCode) =>
      "$BASE_URL/api/RORescheduleTapeID/GetChannelLeave?LocationCode=$locationCode&ChannelCode=$channelCode";
  static String RO_RESCHEDULE_TAPE_ID_GET_AGENCY(
          String locationCode, String channelCode, String clientCode) =>
      "$BASE_URL/api/RORescheduleTapeID/GetClientLeave?LocationCode=$locationCode&ChannelCode=$channelCode&Clientcode=$clientCode";
  static String RO_RESCHEDULE_TAPE_ID_GET_BRAND(String locationCode,
          String channelCode, String clientCode, String agencyCode) =>
      "$BASE_URL/api/RORescheduleTapeID/GetAgencyLeave?LocationCode=$locationCode&ChannelCode=$channelCode&Clientcode=$clientCode&Agencycode=$agencyCode";
  static String RO_RESCHEDULE_TAPE_ID_GET_TAPE_DETAILS(
    String locationCode,
    String channelCode,
    String clientCode,
    String agencyCode,
    String brandCode,
    String fromDate,
    String toDate,
  ) =>
      "$BASE_URL/api/RORescheduleTapeID/GetBrandLeave?LocationCode=$locationCode&ChannelCode=$channelCode&Clientcode=$clientCode&Agencycode=$agencyCode&BrandCode=$brandCode&EffectiveFromDT=$fromDate&EffectiveToDT=$toDate";

  static String RO_RESCHEDULE_TAPE_ID_GET_TAPE_BOOKING_DETAILS(
    String locationCode,
    String channelCode,
    String clientCode,
    String agencyCode,
    String brandCode,
    String fromDate,
    String toDate,
    String tapeCode,
  ) =>
      "$BASE_URL/api/RORescheduleTapeID/GetSearch?LocationCode=$locationCode&ChannelCode=$channelCode&Clientcode=$clientCode&Agencycode=$agencyCode&BrandCode=$brandCode&EffectiveFromDT=$fromDate&EffectiveToDT=$toDate&ExportTapeCode=$tapeCode";
  //////////////////////////////// RO_RESCHEDULE_TAPE_ID END /////////////////////////////////////
  ///////////////////////// Deals Vs RO Date Report Start//////////////////////
  static String get DEAL_VS_RO_DATA_REPORT_DATAINITIAL =>
      "$BASE_URL/api/DealvsRODataReport/DealVSRoReportDataInitial";
  static String DEAL_VS_RO_DATA_REPORT_GET_CHANNEL(String locationCode) =>
      "$BASE_URL/api/DealvsRODataReport/GetChannelList?LocationCode=$locationCode";
  static String DEAL_VS_RO_DATA_REPORT_GET_CLIENT(
          String locationCode, String channelCode, String fromDate) =>
      "$BASE_URL/api/DealvsRODataReport/GetClientList?LocationCode=$locationCode&ChannelCode=$channelCode&FromDate=$fromDate";
  static String DEAL_VS_RO_DATA_REPORT_GET_DEAL(
          String locationCode,
          String channelCode,
          String clientCode,
          String fromDate,
          String toDate) =>
      "$BASE_URL/api/DealvsRODataReport/GetDealDetails?LocationCode=$locationCode&ChannelCode=$channelCode&ClientCode=$clientCode&FromDate=$fromDate&ToDate=$toDate";
  static String DEAL_VS_RO_DATA_REPORT_GENERATE_REPORT(
          String locationCode,
          String channelCode,
          String optDealWise,
          String optROWise,
          String fromDate,
          String toDate,
          String dealNO) =>
      "$BASE_URL/api/DealvsRODataReport/GenerateReportData?LocationCode=$locationCode&ChannelCode=$channelCode&optDealWise=$optDealWise&optROWise=$optROWise&FromDate=$fromDate&ToDate=$toDate&DealNo=$dealNO";
  ///////////////////////// Deals Vs RO Date Report End//////////////////////
  ///
  ///
  ///
  ///
  ///
  //////////////////////////// Booking Status Report Start//////////////////////
  static String get BOOKING_STATUS_REPORT_GET_LOAD_DATA =>
      "$BASE_URL/api/BookingStatusReport/GetloadData";
  static String get BOOKING_STATUS_REPORT_GET_REPORT =>
      "$BASE_URL/api/BookingStatusReport/GetReport";

  //////////////////////////// Booking Status Report End//////////////////////
  ///
  ///
  ///
  ///
  /////////////////////////////// Program Wise Revenue Report Start//////////////////////
  static String get PROGRAM_WISE_REPORT_INITIAL =>
      "$BASE_URL/api/NewProgramWiseReport/NewProgramWiseReportInitial";
  static String get PROGRAM_WISE_REPORT_GENERATE_REPORT =>
      "$BASE_URL/api/NewProgramWiseReport/GenerateReport";
  static String PROGRAM_WISE_REPORT_CLIENTLIST(
          String fromDate, String toDate) =>
      "$BASE_URL/api/NewProgramWiseReport/GenerateReport?FromDate=$fromDate&ToDate=$toDate";
  /////////////////////////////// Program Wise Revenue Report End//////////////////////
  ///
  ///
  ///
  ///
  ///
  /////////////////////////////// Booking against PDC Start//////////////////////
  static String get BOOKING_AGAINST_PDC_GET_CLIENT =>
      "$BASE_URL/api/BookingsAgainstPDC/GetClientList?ContainSearch=";
  static String BOOKING_AGAINST_PDC_GET_AGENCY(String client) =>
      "$BASE_URL/api/BookingsAgainstPDC/GetAgencyList?ClientCode=$client";
  static String BOOKING_AGAINST_PDC_GET_CHEQUE_NO(
          String client, String agency, String activityMonth) =>
      "$BASE_URL/api/BookingsAgainstPDC/GetPDCList?ClientCode=$client&AgencyCode=$agency&ActivityMonth=$activityMonth";
  static String BOOKING_AGAINST_PDC_GET_BOOKING_LIST(String client,
          String agency, String activityMonth, String chequeNo) =>
      "$BASE_URL/api/BookingsAgainstPDC/BookingList?ClientCode=$client&AgencyCode=$agency&ActivityMonth=$activityMonth&ChequeNo=$chequeNo";
  /////////////////////////////// Booking against PDC End//////////////////////
  ///
  ///
  ///
  ///
  ///
  /////////////////////////////// PDC Cheques Start//////////////////////
  static String PDC_CHEQUES_ON_LOAD(int chequeID) =>
      "$BASE_URL/api/ClientPDC/OnLoadData?ChequeId=$chequeID";
  static String PDC_CHEQUES_GET_AGENCY(String client) =>
      "$BASE_URL/api/ClientPDC/GetAgencyCode?ClientCode=$client";
  static String PDC_CHEQUES_GET_RETRIVE_DATA(String client) =>
      "$BASE_URL/api/ClientPDC/GetRetrieve?ChequeId=$client";
  static String get PDC_CHEQUES_CLIENT =>
      "$BASE_URL/api/ClientPDC/GetClientCode?clientName=";

  static String get PDC_CHEQUES_SAVE => "$BASE_URL/api/ClientPDC/SavePDC";

  static String get PDC_CHEQUES_GET_CHEQUE_GROUPING =>
      "$BASE_URL/api/ClientPDC/GetPDCGroup";
  /////////////////////////////// PDC Cheques PDC End//////////////////////
  ///
  ///
  ///
  ///
  ///
////////////////////////// Amagi Spots Replacement ////////////////////////////////////
  static String AMAGI_SPOT_REPLACEMENT_GET_LOCATION() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetLocation";
  static String AMAGI_SPOT_REPLACEMENT_GET_SAVE() =>
      "$BASE_URL/api/AmagiSpotsReplacement/Save";
  static String AMAGI_SPOT_REPLACEMENT_GET_CHANNEL() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetChannel";
  static String AMAGI_SPOT_REPLACEMENT_GET_SPOTS() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetSpots";
  static String AMAGI_SPOT_REPLACEMENT_GET_FAST_INSERT() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetFastInsert";
  static String AMAGI_SPOT_REPLACEMENT_GET_EXCEL() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetExcel";
  static String AMAGI_SPOT_REPLACEMENT_GET_CLIENT() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetClient";
  static String AMAGI_SPOT_REPLACEMENT_GET_SUMMARY() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetSummary";
  static String AMAGI_SPOT_REPLACEMENT_GET_TOTAL() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetTotal";
  static String AMAGI_SPOT_REPLACEMENT_GET_UNALLOCATED() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetUnAllocated";
  static String AMAGI_SPOT_REPLACEMENT_GET_MERGESPOT() =>
      "$BASE_URL/api/AmagiSpotsReplacement/DontMergeSpots";
  static String AMAGI_SPOT_REPLACEMENT_GET_DEALALLOCATED() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetDeallocateHold";
  static String AMAGI_SPOT_REPLACEMENT_GET_PivotOnLoadLocalTable() =>
      "$BASE_URL/api/AmagiSpotsReplacement/GetPivotOnLocalTable";
}
