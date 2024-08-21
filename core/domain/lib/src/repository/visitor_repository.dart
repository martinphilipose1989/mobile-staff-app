import 'dart:io';

import 'package:domain/domain.dart';

abstract class VisitorRepository {
  Future<Either<NetworkError, VisitorListResponseModel>> getVisitorList(
      {required GetVisitorListRequestModel requestBody});

  Future<Either<NetworkError, VisitorDetailsResponseModel>> getVisitorDetails(
      {required String gatepassId});

  Future<Either<NetworkError, VisitorDetailsResponseModel>> patchVisitorDetails(
      {required String gatepassId, required Map<String, dynamic> outgoingTime});
  Future<Either<NetworkError, CreateGatepassResponseModel>>
      createVisitorGatePass({required CreateGatePassModel request});

  Future<Either<NetworkError, PurposeOfVisitModel>> getPurposeOfVisitList();

  Future<Either<NetworkError, TypeOfVisitorResponseModel>>
      getTypeOfVistorList();

  Future<Either<NetworkError, UploadFileResponseModel>> uploadProfileImage(
      {required File file});

  Future<Either<NetworkError, VisitorPopulateResponseModel>>
      populateVisitorData({required String visitorMobileNumber});
}
