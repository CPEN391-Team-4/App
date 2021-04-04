///
//  Generated code. Do not modify.
//  source: TrustPeople.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'restricted', '3': 2, '4': 1, '5': 8, '10': 'restricted'},
    const {'1': 'Photo', '3': 3, '4': 1, '5': 11, '6': '.route.Photo', '10': 'Photo'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEhIKBG5hbWUYASABKAlSBG5hbWUSHgoKcmVzdHJpY3RlZBgCIAEoCFIKcmVzdHJpY3RlZBIiCgVQaG90bxgDIAEoCzIMLnJvdXRlLlBob3RvUgVQaG90bw==');
@$core.Deprecated('Use photoDescriptor instead')
const Photo$json = const {
  '1': 'Photo',
  '2': const [
    const {'1': 'image', '3': 1, '4': 1, '5': 12, '10': 'image'},
    const {'1': 'fileExtension', '3': 2, '4': 1, '5': 9, '10': 'fileExtension'},
  ],
};

/// Descriptor for `Photo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List photoDescriptor = $convert.base64Decode('CgVQaG90bxIUCgVpbWFnZRgBIAEoDFIFaW1hZ2USJAoNZmlsZUV4dGVuc2lvbhgCIAEoCVINZmlsZUV4dGVuc2lvbg==');
@$core.Deprecated('Use userNamesDescriptor instead')
const UserNames$json = const {
  '1': 'UserNames',
  '2': const [
    const {'1': 'usernames', '3': 1, '4': 3, '5': 9, '10': 'usernames'},
  ],
};

/// Descriptor for `UserNames`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userNamesDescriptor = $convert.base64Decode('CglVc2VyTmFtZXMSHAoJdXNlcm5hbWVzGAEgAygJUgl1c2VybmFtZXM=');
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
@$core.Deprecated('Use faceVerificationReqDescriptor instead')
const FaceVerificationReq$json = const {
  '1': 'FaceVerificationReq',
  '2': const [
    const {'1': 'Photo', '3': 1, '4': 1, '5': 11, '6': '.route.Photo', '10': 'Photo'},
  ],
};

/// Descriptor for `FaceVerificationReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List faceVerificationReqDescriptor = $convert.base64Decode('ChNGYWNlVmVyaWZpY2F0aW9uUmVxEiIKBVBob3RvGAEgASgLMgwucm91dGUuUGhvdG9SBVBob3Rv');
@$core.Deprecated('Use faceVerificationRespDescriptor instead')
const FaceVerificationResp$json = const {
  '1': 'FaceVerificationResp',
  '2': const [
    const {'1': 'user', '3': 1, '4': 1, '5': 9, '10': 'user'},
    const {'1': 'confidence', '3': 2, '4': 1, '5': 2, '10': 'confidence'},
    const {'1': 'accept', '3': 3, '4': 1, '5': 8, '10': 'accept'},
  ],
};

/// Descriptor for `FaceVerificationResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List faceVerificationRespDescriptor = $convert.base64Decode('ChRGYWNlVmVyaWZpY2F0aW9uUmVzcBISCgR1c2VyGAEgASgJUgR1c2VyEh4KCmNvbmZpZGVuY2UYAiABKAJSCmNvbmZpZGVuY2USFgoGYWNjZXB0GAMgASgIUgZhY2NlcHQ=');
@$core.Deprecated('Use historyRecordDescriptor instead')
const HistoryRecord$json = const {
  '1': 'HistoryRecord',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'status', '3': 2, '4': 1, '5': 9, '10': 'status'},
    const {'1': 'imageLocation', '3': 3, '4': 1, '5': 9, '10': 'imageLocation'},
    const {'1': 'time', '3': 4, '4': 1, '5': 9, '10': 'time'},
  ],
};

/// Descriptor for `HistoryRecord`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyRecordDescriptor = $convert.base64Decode('Cg1IaXN0b3J5UmVjb3JkEhIKBG5hbWUYASABKAlSBG5hbWUSFgoGc3RhdHVzGAIgASgJUgZzdGF0dXMSJAoNaW1hZ2VMb2NhdGlvbhgDIAEoCVINaW1hZ2VMb2NhdGlvbhISCgR0aW1lGAQgASgJUgR0aW1l');
@$core.Deprecated('Use historyRecordsDescriptor instead')
const HistoryRecords$json = const {
  '1': 'HistoryRecords',
  '2': const [
    const {'1': 'record', '3': 1, '4': 3, '5': 11, '6': '.route.HistoryRecord', '10': 'record'},
  ],
};

/// Descriptor for `HistoryRecords`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyRecordsDescriptor = $convert.base64Decode('Cg5IaXN0b3J5UmVjb3JkcxIsCgZyZWNvcmQYASADKAsyFC5yb3V0ZS5IaXN0b3J5UmVjb3JkUgZyZWNvcmQ=');
@$core.Deprecated('Use imageLocationDescriptor instead')
const ImageLocation$json = const {
  '1': 'ImageLocation',
  '2': const [
    const {'1': 'address', '3': 1, '4': 1, '5': 9, '10': 'address'},
  ],
};

/// Descriptor for `ImageLocation`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List imageLocationDescriptor = $convert.base64Decode('Cg1JbWFnZUxvY2F0aW9uEhgKB2FkZHJlc3MYASABKAlSB2FkZHJlc3M=');
@$core.Deprecated('Use timestampDescriptor instead')
const Timestamp$json = const {
  '1': 'Timestamp',
  '2': const [
    const {'1': 'starttime', '3': 1, '4': 1, '5': 9, '10': 'starttime'},
    const {'1': 'endtime', '3': 2, '4': 1, '5': 9, '10': 'endtime'},
  ],
};

/// Descriptor for `Timestamp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List timestampDescriptor = $convert.base64Decode('CglUaW1lc3RhbXASHAoJc3RhcnR0aW1lGAEgASgJUglzdGFydHRpbWUSGAoHZW5kdGltZRgCIAEoCVIHZW5kdGltZQ==');
@$core.Deprecated('Use permissionDescriptor instead')
const Permission$json = const {
  '1': 'Permission',
  '2': const [
    const {'1': 'usernames', '3': 1, '4': 1, '5': 9, '10': 'usernames'},
    const {'1': 'userid', '3': 2, '4': 1, '5': 3, '10': 'userid'},
    const {'1': 'permit', '3': 3, '4': 1, '5': 8, '10': 'permit'},
  ],
};

/// Descriptor for `Permission`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List permissionDescriptor = $convert.base64Decode('CgpQZXJtaXNzaW9uEhwKCXVzZXJuYW1lcxgBIAEoCVIJdXNlcm5hbWVzEhYKBnVzZXJpZBgCIAEoA1IGdXNlcmlkEhYKBnBlcm1pdBgDIAEoCFIGcGVybWl0');
