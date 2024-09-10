import 'package:data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_permission_entity_response.g.dart';

@JsonSerializable()
class UserPermissionEntityResponse
    implements
        BaseLayerDataTransformer<UserPermissionEntityResponse,
            UserPermissionResponse> {
  @JsonKey(name: "success")
  bool? success;
  @JsonKey(name: "data")
  UserPermissionEntityData? data;
  @JsonKey(name: "meta")
  MetaEntity? meta;
  @JsonKey(name: "message")
  String? message;

  UserPermissionEntityResponse(
      {this.success, this.data, this.meta, this.message});

  factory UserPermissionEntityResponse.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionEntityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserPermissionEntityResponseToJson(this);

  @override
  UserPermissionEntityResponse restore(UserPermissionResponse data) {
    return UserPermissionEntityResponse(
      data: UserPermissionEntityData(),
      message: data.message,
    );
  }

  @override
  UserPermissionResponse transform() {
    return UserPermissionResponse(
        data: data?.transform(),
        message: message,
        meta: meta?.transform(),
        success: success);
  }
}

@JsonSerializable()
class UserPermissionEntityData
    implements
        BaseLayerDataTransformer<UserPermissionEntityData, UserPermissionData> {
  @JsonKey(name: "hrisCodes")
  List<String>? hrisCodes;
  @JsonKey(name: "hrisCodeNames")
  List<String>? hrisCodeNames;
  @JsonKey(name: "permissions")
  List<dynamic>? permissions;
  @JsonKey(name: "services")
  List<ServiceEntity>? services;
  @JsonKey(name: "schoolCode")
  int? schoolCode;
  @JsonKey(name: "userInfo")
  UserInfoEntity? userInfo;

  UserPermissionEntityData(
      {this.hrisCodes,
      this.hrisCodeNames,
      this.permissions,
      this.services,
      this.schoolCode,
      this.userInfo});

  factory UserPermissionEntityData.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionEntityDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserPermissionEntityDataToJson(this);

  @override
  UserPermissionEntityData restore(UserPermissionData data) {
    return UserPermissionEntityData(
      schoolCode: data.schoolCode,
      hrisCodeNames: data.hrisCodeNames,
      hrisCodes: data.hrisCodes,
      permissions: data.permissions,
      services: data.services
          ?.map((service) => ServiceEntity(
              icon: service.icon,
              link: service.link,
              name: service.name,
              slug: service.slug))
          .toList(),
    );
  }

  @override
  UserPermissionData transform() {
    return UserPermissionData(
        hrisCodeNames: hrisCodeNames,
        hrisCodes: hrisCodes,
        permissions: permissions,
        schoolCode: schoolCode,
        services: services?.map((service) => service.transform()).toList(),
        userInfo: userInfo?.transform());
  }
}

@JsonSerializable()
class ServiceEntity
    implements BaseLayerDataTransformer<ServiceEntity, Service> {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "icon")
  dynamic icon;
  @JsonKey(name: "link")
  dynamic link;
  @JsonKey(name: "slug")
  String? slug;

  ServiceEntity({this.name, this.icon, this.link, this.slug});

  factory ServiceEntity.fromJson(Map<String, dynamic> json) =>
      _$ServiceEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceEntityToJson(this);

  @override
  ServiceEntity restore(Service data) {
    return ServiceEntity(
        icon: data.icon, link: data.link, name: data.name, slug: data.slug);
  }

  @override
  Service transform() {
    return Service(icon: icon, link: link, name: name, slug: slug);
  }
}

@JsonSerializable()
class UserInfoEntity
    implements BaseLayerDataTransformer<UserInfoEntity, UserInfo> {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "schools")
  List<int>? schools;
  @JsonKey(name: "schoolIds")
  List<int>? schoolIds;
  @JsonKey(name: "lobs")
  List<int>? lobs;
  @JsonKey(name: "lobCodes")
  List<int>? lobCodes;

  UserInfoEntity(
      {this.id,
      this.name,
      this.email,
      this.schools,
      this.schoolIds,
      this.lobs,
      this.lobCodes});

  factory UserInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$UserInfoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoEntityToJson(this);

  @override
  UserInfoEntity restore(UserInfo data) {
    return UserInfoEntity(
        email: data.email,
        id: data.id,
        lobCodes: data.lobCodes,
        lobs: data.lobs,
        name: name,
        schoolIds: schoolIds,
        schools: schools);
  }

  @override
  UserInfo transform() {
    return UserInfo(
        id: id,
        email: email,
        lobCodes: lobCodes,
        lobs: lobs,
        name: name,
        schoolIds: schoolIds,
        schools: schoolIds);
  }
}

@JsonSerializable()
class MetaEntity implements BaseLayerDataTransformer<MetaEntity, Meta> {
  MetaEntity();

  factory MetaEntity.fromJson(Map<String, dynamic> json) =>
      _$MetaEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MetaEntityToJson(this);

  @override
  MetaEntity restore(Meta data) {
    return MetaEntity();
  }

  @override
  Meta transform() {
    return Meta();
  }
}
