import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/domain.dart';

class VisitorRepositoryImpl extends VisitorRepository {
  final NetworkPort networkPort;

  VisitorRepositoryImpl({required this.networkPort});

  @override
  Future<Either<NetworkError, VisitorDetailsResponseModel>> getVisitorDetails({
    required String gatepassId,
  }) {
    return networkPort.getVisitorDetails(
      gatepassId: gatepassId,
    );
  }

  @override
  Future<Either<NetworkError, VisitorDetailsResponseModel>>
      patchVisitorDetails({
    required String gatepassId,
    required Map<String, dynamic> outgoingTime,
  }) {
    return networkPort.petchVisitorDetails(
      gatepassId: gatepassId,
      outgoingTime: outgoingTime,
    );
  }

  @override
  Future<Either<NetworkError, CreateGatepassResponseModel>>
      createVisitorGatePass({required CreateGatePassModel request}) {
    return networkPort.createVisitorGatePass(request: request);
  }

  @override
  Future<Either<NetworkError, MdmCoReasonResponseModel>>
      getPurposeOfVisitList() {
    return networkPort.getPurposeOfVisitList();
  }

  @override
  Future<Either<NetworkError, MdmCoReasonResponseModel>> getTypeOfVistorList() {
    return networkPort.getTypeOfVistorList();
  }

  @override
  Future<Either<NetworkError, UploadFileResponseModel>> uploadProfileImage(
      {required File file}) {
    return networkPort.uploadProfileImage(file: file);
  }

  @override
  Future<Either<NetworkError, VisitorPopulateResponseModel>>
      populateVisitorData({required String visitorMobileNumber}) {
    return networkPort.populateVisitorData(
        visitorMobileNumber: visitorMobileNumber);
  }

  @override
  Future<Either<NetworkError, VisitorListResponseModel>> getVisitorList(
      {required GetVisitorListRequestModel requestBody}) {
    return networkPort.getVisitorList(request: requestBody);
  }

  @override
  Future<Either<NetworkError, VisitorListResponseModel>> searchVisitorList(
      {required int pageNumber,
      required int pageSize,
      required String searchQuery}) {
    return networkPort.searchVisitorList(
        pageNumber: pageNumber, pageSize: pageSize, searchQuery: searchQuery);
  }

  @override
  Future<Either<NetworkError, ParentGatepassResponseModel>> patchParentGatePass(
      {required String gatepassID,
      required ParentGatePassRequestModel requestBody}) {
    return networkPort.patchParentGatePass(
        gatepassID: gatepassID, requestModel: requestBody);
  }
}
