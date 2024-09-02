abstract class NetworkProperties {
  static const String getVisitorList = "gate-management/gatepass/list";
  static const String getVisitorDetails =
      "gate-management/gatepass/{gatepassId}";
  static const String createVistorGatepass = "gate-management/gatepass/create";
  static const String getPurposeOfVisitList =
      "gate-management/purpose-of-visit/list";
  static const String getVisitorTypeList = "gate-management/visitor-type/list";
  static const String uploadProfileImage =
      "gate-management/visitor/upload-profile-image";

  static const String populateVisitorData = "/gate-management/visitor/{mobile}";

  static const String mdmModule =
      "https://ampersand-r26sp3mibq-uc.a.run.app/api/co-reasons";
  static const String globalSearchVisitor =
      "gate-management/gatepass/global-search";

  static const String signOutVisitor =
      "gate-management/gatepass/{gatepassId}/sign-out";
}
