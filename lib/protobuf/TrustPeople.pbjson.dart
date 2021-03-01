///
//  Generated code. Do not modify.
//  source: TrustPeople.proto
//
// @dart = 2.7
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
@$core.Deprecated('Use userNameDescriptor instead')
const UserName$json = const {
  '1': 'UserName',
  '2': const [
    const {'1': 'usernames', '3': 1, '4': 1, '5': 9, '10': 'usernames'},
  ],
};

/// Descriptor for `UserName`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userNameDescriptor = $convert.base64Decode('CghVc2VyTmFtZRIcCgl1c2VybmFtZXMYASABKAlSCXVzZXJuYW1lcw==');
@$core.Deprecated('Use emptyDescriptor instead')
const Empty$json = const {
  '1': 'Empty',
};

/// Descriptor for `Empty`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyDescriptor = $convert.base64Decode('CgVFbXB0eQ==');
