import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:data/data.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:network_retrofit/src/network_adapter.dart';
import 'package:network_retrofit/src/services/academics_service.dart';
import 'package:network_retrofit/src/services/mdm_service.dart';
import 'package:network_retrofit/src/services/retrofit_service.dart';
import 'package:network_retrofit/src/services/transport_service.dart';
import 'package:network_retrofit/src/util/api_interceptor.dart';

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
  ApiInterceptor provideApiInterceptor(@Named("ApiKey") String apiKey,
          AppAuthPort appAuthPort, @Named('MDMToken') String mdmToken) =>
      ApiInterceptor(apiKey, appAuthPort, mdmToken);

  // @singleton
  // TokenInterceptor provideTokenInterceptor(AppAuthPort appAuthPort) =>
  //     TokenInterceptor(appAuthPort: appAuthPort);

  @singleton
  List<Interceptor> providerInterceptors(
          PrettyDioLogger logger,
          ApiInterceptor apiInterceptor,
          // TokenInterceptor tokenInterceptor,
          CurlLoggerDioInterceptor curlInterceptor) =>
      <Interceptor>[apiInterceptor, logger, curlInterceptor];

  @lazySingleton
  Dio providerDio(BaseOptions options, List<Interceptor> interceptors) {
    Dio dio = Dio(options);
    dio.interceptors.addAll(interceptors);
    return dio;
  }

  @lazySingleton
  RetrofitService providerRetrofitService(Dio dio) => RetrofitService(dio);

  @lazySingleton
  TransportService providerTransportService(
          Dio dio, @Named('TransportUrl') String transportUrl) =>
      TransportService(dio, transportUrl: transportUrl);

  @lazySingleton
  AcademicsService providerAcademicsService(
          Dio dio, @Named('AcademicsUrl') String academicsUrl) =>
      AcademicsService(dio, academicsUrl: academicsUrl);

  @lazySingleton
  MdmService providerMDMService(Dio dio, @Named('MDMUrl') String mdmUrl) =>
      MdmService(dio, mdmUrl: mdmUrl);

  @lazySingleton
  NetworkPort providerNetworkService(
          RetrofitService retrofitService,
          TransportService transportService,
          AcademicsService academicsService,
          MdmService mdmService) =>
      NetworkAdapter(
        retrofitService,
        transportService,
        academicsService,
        mdmService,
      );
}
