/// Support for doing something awesome.
///
/// More dartdocs go here.
library shared;

//constants
export 'src/const/error_type.dart';
export 'src/const/server_constants.dart';
export 'src/const/common_variables.dart';

//models
export 'src/model/app_error.dart';
export 'src/model/error/base_error.dart';
export 'src/model/error/database_error.dart';
export 'src/model/error/network_error.dart';
export 'src/model/error_info.dart';
export 'src/model/user.dart';
export 'src/shared_base.dart';
export 'src/utils/mapper/base_layer_transformer.dart';
export 'src/model/upload_file.dart';
export 'src/model/response/gate_mangment/visitor_data_model.dart';
export 'src/model/response/gate_mangment/visitor_list_response_model.dart';
export 'src/model/response/gate_mangment/visitor_details_response_model.dart';
export 'src/model/request/gate_managment/create_gatepass_model.dart';
export 'src/model/response/gate_mangment/create_gatepass_response_model.dart';
export 'src/model/response/gate_mangment/create_gate_pass_data_response_model.dart';
export 'src/model/response/gate_mangment/mdm_coreason_response_model.dart';
export 'src/model/response/gate_mangment/upload_response_model.dart';
export 'src/model/error/local_error.dart';
// gate managment
export 'src/model/response/gate_mangment/visitor_populate_response_model.dart';
export 'src/model/request/gate_managment/getvistor_list_request_model.dart';
export 'src/model/response/gate_mangment/parent_gatepass_response_model.dart';
export 'src/model/request/gate_managment/parent_gatepass_request_model.dart';
export 'src/model/request/gate_managment/search_request_model.dart';

// login
export 'src/model/request/login/login_request.dart';
export 'src/model/response/login/login_response.dart';
export 'src/model/response/login/auth_response.dart';

// user permission
export 'src/model/response/user_permission/user_permission.dart';
export 'src/model/request/user_permission/user_permission_request.dart';

//utils
export 'src/utils/validator.dart';
