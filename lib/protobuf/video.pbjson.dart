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
    const {'1': 'deviceId', '3': 4, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `Video`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoDescriptor = $convert.base64Decode('CgVWaWRlbxISCgRuYW1lGAEgASgJUgRuYW1lEhoKCGVuY29kaW5nGAIgASgJUghlbmNvZGluZxIiCgVmcmFtZRgDIAEoCzIMLnZpZGVvLkZyYW1lUgVmcmFtZRIaCghkZXZpY2VJZBgEIAEoCVIIZGV2aWNlSWQ=');
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
    const {'1': 'mainUser', '3': 2, '4': 1, '5': 9, '10': 'mainUser'},
  ],
};

/// Descriptor for `PullVideoStreamReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pullVideoStreamReqDescriptor = $convert.base64Decode('ChJQdWxsVmlkZW9TdHJlYW1SZXESDgoCaWQYASABKAlSAmlkEhoKCG1haW5Vc2VyGAIgASgJUghtYWluVXNlcg==');
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
@$core.Deprecated('Use endPullVideoStreamReqDescriptor instead')
const EndPullVideoStreamReq$json = const {
  '1': 'EndPullVideoStreamReq',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'mainUser', '3': 2, '4': 1, '5': 9, '10': 'mainUser'},
  ],
};

/// Descriptor for `EndPullVideoStreamReq`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List endPullVideoStreamReqDescriptor = $convert.base64Decode('ChVFbmRQdWxsVmlkZW9TdHJlYW1SZXESDgoCaWQYASABKAlSAmlkEhoKCG1haW5Vc2VyGAIgASgJUghtYWluVXNlcg==');
@$core.Deprecated('Use streamrequestDescriptor instead')
const Streamrequest$json = const {
  '1': 'Streamrequest',
  '2': const [
    const {'1': 'request', '3': 1, '4': 1, '5': 8, '10': 'request'},
  ],
};

/// Descriptor for `Streamrequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List streamrequestDescriptor = $convert.base64Decode('Cg1TdHJlYW1yZXF1ZXN0EhgKB3JlcXVlc3QYASABKAhSB3JlcXVlc3Q=');
@$core.Deprecated('Use initialConnectionDescriptor instead')
const InitialConnection$json = const {
  '1': 'InitialConnection',
  '2': const [
    const {'1': 'setup', '3': 1, '4': 1, '5': 8, '10': 'setup'},
  ],
};

/// Descriptor for `InitialConnection`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List initialConnectionDescriptor = $convert.base64Decode('ChFJbml0aWFsQ29ubmVjdGlvbhIUCgVzZXR1cBgBIAEoCFIFc2V0dXA=');
