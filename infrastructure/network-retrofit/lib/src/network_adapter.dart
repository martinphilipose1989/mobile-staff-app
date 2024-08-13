import 'package:dartz/dartz.dart';
import 'package:data/data.dart';
import 'package:network_retrofit/src/util/safe_api_call.dart';

import 'services/retrofit_service.dart';

class NetworkAdapter implements NetworkPort {
  final RetrofitService apiService;

  NetworkAdapter(this.apiService);

  @override
  Future<Either<NetworkError, VisitorListResponseModel>> getVisitorList(
      {required int pageNumber, int pageSize = 10}) async {
    final response =
        await safeApiCall(apiService.getVisitorList(pageNumber, pageSize));
    return response.fold((error) {
      return Left(error);
    }, (data) {
      return Right(data.transform());
    });
  }
}
