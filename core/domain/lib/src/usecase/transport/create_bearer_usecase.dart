import 'package:domain/domain.dart';
import 'package:domain/src/usecase/base/base_usecase.dart';

class CreateBearerUsecase extends BaseUseCase<NetworkError,
    CreateBearerUsecaseParams, MapStudenttoBearerResponse> {
  final TransportRepository transportRepository;

  CreateBearerUsecase({required this.transportRepository});

  @override
  Future<Either<NetworkError, MapStudenttoBearerResponse>> execute(
      {required CreateBearerUsecaseParams params}) async {
    return Future.value(
      (await transportRepository.createBearer(
        request: CreateBearerRequest(data: params.request),
      ))
          .fold((l) => Left(l), (result) async {
        return transportRepository.mapBearerToGuardians(
          request: MapStudenttoBearerRequest(
            data: MapStudenttoBearerRequestData(
                guardianId: result.data?.id,
                guardianRelationshipId: 7, // for bearer
                studentId: params.studentId),
          ),
        );
      }),
    );
  }
}

class CreateBearerUsecaseParams extends Params {
  final CreateBearerRequesData request;
  final int studentId;

  CreateBearerUsecaseParams({required this.request, required this.studentId});

  @override
  Either<AppError, bool> verify() {
    return Right(true);
  }
}
