class CreateIncidentReportRequest {
  int? studentId;

  int? busId;

  int? busDiverId;

  int? busDidiId;

  int? teacherId;

  int? incidentType;

  String? comment;

  CreateIncidentReportRequest(
      {this.studentId,
      this.busId,
      this.busDiverId,
      this.busDidiId,
      this.teacherId,
      this.incidentType,
      this.comment});
}
