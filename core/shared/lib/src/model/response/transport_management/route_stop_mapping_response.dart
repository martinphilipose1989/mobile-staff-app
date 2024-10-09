import 'stop_response.dart';

class RouteStopMapping {
  String? id;

  int? orderNo;

  String? approxTime;

  String? createdAt;

  String? updatedAt;

  Stop? stop;

  RouteStopMapping(
      {this.id,
      this.orderNo,
      this.approxTime,
      this.createdAt,
      this.updatedAt,
      this.stop});
}
