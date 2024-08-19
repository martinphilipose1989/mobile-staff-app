// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared/src/model/response/gate_mangment/create_gate_pass_data_response_model.dart';

class CreateGatepassResponseModel {
  int? status;
  String? message;
  CreateGatePassDataResponseModel? data;
  CreateGatepassResponseModel({
    this.status,
    this.message,
    this.data,
  });
}
