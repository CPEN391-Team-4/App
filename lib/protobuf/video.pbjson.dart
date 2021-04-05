///
//  Generated code. Do not modify.
//  source: video.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use videoDescriptor instead')
const Video$json = const {
  '1': 'Video',
  '2': const [
    const {'1': 'name', '3': 1, '4': 1, '5': 9, '10': 'name'},
    const {'1': 'encoding', '3': 2, '4': 1, '5': 9, '10': 'encoding'},
    const {'1': 'frame', '3': 3, '4': 1, '5': 11, '6': '.video.Frame', '10': 'frame'},
  ],
};

/// Descriptor for `Video`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoDescriptor = $convert.base64Decode('CgVWaWRlbxISCgRuYW1lGAEgASgJUgRuYW1lEhoKCGVuY29kaW5nGAIgASgJUghlbmNvZGluZxIiCgVmcmFtZRgDIAEoCzIMLnZpZGVvLkZyYW1lUgVmcmFtZQ==');
@$core.Deprecated('Use frameDescriptor instead')
const Frame$json = const {
  '1': 'Frame',
  '2': const [
    const {'1': 'number', '3': 1, '4': 1, '5': 5, '10': 'number'},
    const {'1': 'lastChunk', '3': 2, '4': 1, '5': 8, '10': 'lastChunk'},
    const {'1': 'chunk', '3': 3, '4': 1, '5': 12, '10': 'chunk'},
  ],
};

/// Descriptor for `Frame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List frameDescriptor = $convert.base64Decode('CgVGcmFtZRIWCgZudW1iZXIYASABKAVSBm51bWJlchIcCglsYXN0Q2h1bmsYAiABKAhSCWxhc3RDaHVuaxIUCgVjaHVuaxgDIAEoDFIFY2h1bms=');
@$core.Deprecated('Use emptyVideoResponseDescriptor instead')
const EmptyVideoResponse$json = const {
  '1': 'EmptyVideoResponse',
};

/// Descriptor for `EmptyVideoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List emptyVideoResponseDescriptor = $convert.base64Decode('ChJFbXB0eVZpZGVvUmVzcG9uc2U=');
@$core.Deprecated('Use pullVideoStreamReqDescriptor instead')
const PullVideoStreamReq$json = const {
  '1': 'PullVideoStreamReq',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `PullVideoStreamReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pullVideoStreamReqDescriptor = $convert.base64Decode('ChJQdWxsVmlkZW9TdHJlYW1SZXESDgoCaWQYASABKAlSAmlk');
@$core.Deprecated('Use pullVideoStreamRespDescriptor instead')
const PullVideoStreamResp$json = const {
  '1': 'PullVideoStreamResp',
  '2': const [
    const {'1': 'video', '3': 1, '4': 1, '5': 11, '6': '.video.Video', '10': 'video'},
    const {'1': 'closed', '3': 2, '4': 1, '5': 8, '10': 'closed'},
  ],
};

/// Descriptor for `PullVideoStreamResp`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pullVideoStreamRespDescriptor = $convert.base64Decode('ChNQdWxsVmlkZW9TdHJlYW1SZXNwEiIKBXZpZGVvGAEgASgLMgwudmlkZW8uVmlkZW9SBXZpZGVvEhYKBmNsb3NlZBgCIAEoCFIGY2xvc2Vk');
