import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:network_retrofit/src/model/error/error_info_entity.dart';

NetworkError getError({required Response apiResponse}) {
  if (apiResponse.data != null) {
    try {
      final ErrorInfoEntity errorResponseEntity =
          ErrorInfoEntity.fromJson(apiResponse.data);
      print("errorResponseEntity is ${errorResponseEntity.errorMessage}");
      if (apiResponse.statusCode! >= 500) {
        return NetworkError(
          httpError: errorResponseEntity.errorCode ?? 1000,
          message: errorResponseEntity.errorMessage?['error'] ?? '',
          cause: Exception("Server Response Error"),
        );
      } else {
        return NetworkError(
          httpError: errorResponseEntity.errorCode ?? 1000,
          message: errorResponseEntity.errorMessage ?? '',
          cause: Exception("Server Response Error"),
        );
      }
    } catch (exception) {
      // exception.printStackTrace();
      return NetworkError(
          cause: Exception("Server Response Error"),
          httpError: apiResponse.statusCode!,
          message: apiResponse.statusMessage!);
    }
  } else {
    return NetworkError(
        cause: Exception("Server Response Error"),
        httpError: apiResponse.statusCode!,
        message: apiResponse.statusMessage!);
  }
}