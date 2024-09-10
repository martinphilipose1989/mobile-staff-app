class UserPermissionResponse {
  bool? success;
  UserPermissionData? data;
  Meta? meta;
  String? message;

  UserPermissionResponse({
    this.success,
    this.data,
    this.meta,
    this.message,
  });
}

class UserPermissionData {
  List<String>? hrisCodes;
  List<String>? hrisCodeNames;
  List<dynamic>? permissions;
  List<Service>? services;
  int? schoolCode;
  UserInfo? userInfo;

  UserPermissionData({
    this.hrisCodes,
    this.hrisCodeNames,
    this.permissions,
    this.services,
    this.schoolCode,
    this.userInfo,
  });
}

class Service {
  String? name;
  dynamic icon;
  dynamic link;
  String? slug;

  Service({
    this.name,
    this.icon,
    this.link,
    this.slug,
  });
}

class UserInfo {
  int? id;
  String? name;
  String? email;
  List<int>? schools;
  List<int>? schoolIds;
  List<int>? lobs;
  List<int>? lobCodes;

  UserInfo({
    this.id,
    this.name,
    this.email,
    this.schools,
    this.schoolIds,
    this.lobs,
    this.lobCodes,
  });
}

class Meta {
  Meta();
}
