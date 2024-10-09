import 'guardian_detail_response.dart';
import 'route_stop_mapping_response.dart';

class GetStudentProfileResponse {
  int? status;

  GetStudentProfileData? data;

  String? message;

  GetStudentProfileResponse({this.status, this.data, this.message});
}

class GetStudentProfileData {
  int? studentId;

  String? firstName;

  String? middleName;

  String? lastName;

  String? profileImage;

  String? crtEnrOn;

  String? schoolName;

  String? gradeName;

  List<GuardiansDetail>? guardiansDetails;

  TransportDetails? transportDetails;

  List<dynamic>? bearersDetails;

  GetStudentProfileData({
    this.studentId,
    this.firstName,
    this.middleName,
    this.lastName,
    this.profileImage,
    this.crtEnrOn,
    this.schoolName,
    this.gradeName,
    this.guardiansDetails,
    this.transportDetails,
    this.bearersDetails,
  });
}

class TransportDetails {
  String? id;

  int? studentId;

  Route? route;

  TransportDetails({this.id, this.studentId, this.route});
}

class Route {
  String? id;

  String? routeName;

  String? busType;

  String? routeType;

  List<RouteStopMapping>? routeStopMapping;

  Route({
    this.id,
    this.routeName,
    this.busType,
    this.routeType,
    this.routeStopMapping,
  });
}
