import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:data/data.dart';
import 'package:network_retrofit/src/util/get_error.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

Future<Either<NetworkError, T>> safeApiCall<T>(Future<T> apiCall) async {
  try {
    final originalResponse = await apiCall;
    final eitherResponse = originalResponse as HttpResponse<dynamic>;
    if (!eitherResponse.isSuccessful()) {
      return Left(getError(apiResponse: eitherResponse.response));
    } else {
      return Right(originalResponse);
    }
  } on Exception catch (throwable) {
    switch (throwable.runtimeType) {
      case DioException:
        switch ((throwable as DioException).type) {
          case DioExceptionType.connectionTimeout:
            return Left(NetworkError(
              message:
                  "Connection timed out while trying to reach the API server. Please check your internet connection.",
              httpError: 408,
              cause: throwable,
            ));
          case DioExceptionType.sendTimeout:
            return Left(NetworkError(
              message:
                  "Request timeout while sending data to the server. Please try again.",
              httpError: 408,
              cause: throwable,
            ));
          case DioExceptionType.receiveTimeout:
            return Left(NetworkError(
              message:
                  "Request timeout while waiting for the server's response. Please check your internet connection.",
              httpError: 408,
              cause: throwable,
            ));
          case DioExceptionType.badResponse:
            return Left(getError(apiResponse: throwable.response!));
          //"Received invalid status code: ${error.response.statusCode}";
          case DioExceptionType.cancel:
            break;
          case DioExceptionType.unknown:
            return Left(NetworkError(
              message:
                  "An unknown error occurred. Please check your internet connection and try again.",
              httpError: 503,
              cause: throwable,
            ));
          case DioExceptionType.badCertificate:
            return Left(NetworkError(
              message:
                  "Server certificate verification failed. Please ensure your connection is secure.",
              httpError: 495,
              cause: throwable,
            ));
          case DioExceptionType.connectionError:
            return Left(
              NetworkError(
                message:
                    "Failed to connect to the server. Please check your internet connection.",
                httpError: 503,
                cause: throwable,
              ),
            );
        }
        break;
      case IOException:
        return Left(NetworkError(
            message: throwable.toString(), httpError: 502, cause: throwable));

      case HttpException:
        return Left(NetworkError(
            message: (throwable as HttpException).message,
            httpError: 502,
            cause: throwable));

      case FormatException:
        return Left(NetworkError(
            message: (throwable as HttpException).message,
            httpError: 502,
            cause: throwable));

      default:
        return Left(NetworkError(
            message: throwable.toString(), httpError: 502, cause: throwable));
    }

    return Left(NetworkError(
        message: throwable.toString(), httpError: 502, cause: throwable));
  }
}

extension RetrofitResponse on HttpResponse {
  /// Returns true if the code is in [200..300), which means the request was successfully received,
  /// understood, and accepted.
  bool isSuccessful() {
    // return response.statusCode! >= 200 && response.statusCode! < 300;
    return response.statusCode! >= 200 && response.statusCode! < 300;
  }
}
