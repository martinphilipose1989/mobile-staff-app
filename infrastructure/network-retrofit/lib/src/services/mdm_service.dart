import 'package:dio/dio.dart';
import 'package:network_retrofit/src/model/request/transport_management/create_bearer_entity_request.dart';
import 'package:network_retrofit/src/model/response/transport_management/createbearer_response_entity.dart';

import 'package:retrofit/retrofit.dart';

part 'mdm_service.g.dart';

const String _createBearer = "api/ac-guardians";

const String _mapBearerToGuardians = "api/ac-student-guardians";

@RestApi()
abstract class MdmService {
  factory MdmService(Dio dio, {String? mdmUrl}) {
    return _MdmService(dio, baseUrl: mdmUrl);
  }

  @POST(_createBearer)
  Future<HttpResponse<CreateBearerResponseEntity>> createBearer(
      @Body() CreateBearerRequestEntity request);

  @POST(_mapBearerToGuardians)
  Future<HttpResponse<CreateBearerResponseEntity>> mapBearerToGuardians(
      @Body() CreateBearerRequestEntity request);
}

/**
 *
   payload: {
    "data": {
        "student_id": number,
        "guardian_id": number,
        "guardian_relationship_id": 7
    }
}
 *
 */

/**
  response: {
    "data": {
        "id": 33,
        "attributes": {
            "student_id": 1,
            "guardian_id": 1,
            "guardian_relationship_id": 7,
			....
        }
    },
    "meta": {}
}
 * 
 */