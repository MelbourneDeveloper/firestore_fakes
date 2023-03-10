import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsFake implements Settings {
  @override
  // TODO: implement asMap
  Map<String, dynamic> get asMap => throw UnimplementedError();

  @override
  // TODO: implement cacheSizeBytes
  int? get cacheSizeBytes => throw UnimplementedError();

  @override
  Settings copyWith(
      {bool? persistenceEnabled,
      String? host,
      bool? sslEnabled,
      int? cacheSizeBytes,
      bool? ignoreUndefinedProperties}) {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  // TODO: implement host
  String? get host => throw UnimplementedError();

  @override
  // TODO: implement ignoreUndefinedProperties
  bool get ignoreUndefinedProperties => throw UnimplementedError();

  @override
  // TODO: implement persistenceEnabled
  bool? get persistenceEnabled => throw UnimplementedError();

  @override
  // TODO: implement sslEnabled
  bool? get sslEnabled => throw UnimplementedError();
}
