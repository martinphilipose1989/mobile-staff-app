/// Support for doing something awesome.
///
/// More dartdocs go here.
library domain;

export 'src/di/domain_dependency_configurator.dart';
export 'package:dartz/dartz.dart';

//repository contracts
export 'src/repository/user_repository.dart';
export 'src/repository/attachment_repository.dart';
export 'src/repository/visitor_repository.dart';

//use-cases
export 'src/usecase/base/params.dart';
export 'src/usecase/user/login_usecase.dart';
export 'src/usecase/attachment/attachment_usecase.dart';
export 'src/usecase/visitor/get_visitor_list_usecase.dart';
export 'src/usecase/visitor/get_visitor_details_usecase.dart';

export 'package:shared/shared.dart';

export 'src/upload_filetype_enum.dart';
