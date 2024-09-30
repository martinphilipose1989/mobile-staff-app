class CreateIncidentReportResponse {
  int? status;

  CreateIncidentReportResponseData? data;

  String? message;

  CreateIncidentReportResponse({this.status, this.data, this.message});
}

class CreateIncidentReportResponseData {
  int? studentId;

  int? busId;

  int? busDiverId;

  int? busDidiId;

  int? teacherId;

  int? incidentType;

  String? comment;

  String? id;

  String? createdAt;

  String? updatedAt;

  CreateIncidentReportResponseData({
    this.studentId,
    this.busId,
    this.busDiverId,
    this.busDidiId,
    this.teacherId,
    this.incidentType,
    this.comment,
    this.id,
    this.createdAt,
    this.updatedAt,
  });
}
