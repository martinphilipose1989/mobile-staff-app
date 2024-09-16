import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:network_retrofit/src/network_adapter.dart';
import 'package:network_retrofit/src/services/retrofit_service.dart';
import 'package:network_retrofit/src/util/api_interceptor.dart';
import 'package:network_retrofit/src/util/token_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class NetworkModule {
  @singleton
  BaseOptions providerBaseConfig(@Named('BaseUrl') String url) =>
      BaseOptions(baseUrl: url);

  @singleton
  PrettyDioLogger providerPrettyLogger() => PrettyDioLogger(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint: (log) {
          return print(log as String);
        },
      );

  @singleton
  CurlLoggerDioInterceptor providerCurlLogger() =>
      CurlLoggerDioInterceptor(printOnSuccess: true);

  @singleton
  ApiInterceptor provideApiInterceptor(@Named("ApiKey") String apiKey) =>
      ApiInterceptor(apiKey);

  @singleton
  TokenInterceptor provideTokenInterceptor() => TokenInterceptor();

  @singleton
  List<Interceptor> providerInterceptors(
          PrettyDioLogger logger,
          ApiInterceptor apiInterceptor,
          TokenInterceptor tokenInterceptor,
          CurlLoggerDioInterceptor curlInterceptor) =>
      <Interceptor>[tokenInterceptor, apiInterceptor, logger, curlInterceptor];

  @lazySingleton
  Dio providerDio(BaseOptions options, List<Interceptor> interceptors) {
    Dio dio = Dio(options);
    dio.interceptors.addAll(interceptors);
    return dio;
  }

  @lazySingleton
  RetrofitService providerRetrofitService(Dio dio) => RetrofitService(dio);

  @lazySingleton
  NetworkPort providerNetworkService(RetrofitService retrofitService) =>
      NetworkAdapter(retrofitService);
}
