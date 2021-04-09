///
//  Generated code. Do not modify.
//  source: video.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class Video extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Video', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'video'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'encoding')
    ..aOM<Frame>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'frame', subBuilder: Frame.create)
    ..hasRequiredFields = false
  ;

  Video._() : super();
  factory Video({
    $core.String? name,
    $core.String? encoding,
    Frame? frame,
  }) {
    final _result = create();
    if (name != null) {
      _result.name = name;
    }
    if (encoding != null) {
      _result.encoding = encoding;
    }
    if (frame != null) {
      _result.frame = frame;
    }
    return _result;
  }
  factory Video.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Video.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Video clone() => Video()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Video copyWith(void Function(Video) updates) => super.copyWith((message) => updates(message as Video)) as Video; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Video create() => Video._();
  Video createEmptyInstance() => create();
  static $pb.PbList<Video> createRepeated() => $pb.PbList<Video>();
  @$core.pragma('dart2js:noInline')
  static Video getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Video>(create);
  static Video? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get encoding => $_getSZ(1);
  @$pb.TagNumber(2)
  set encoding($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasEncoding() => $_has(1);
  @$pb.TagNumber(2)
  void clearEncoding() => clearField(2);

  @$pb.TagNumber(3)
  Frame get frame => $_getN(2);
  @$pb.TagNumber(3)
  set frame(Frame v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasFrame() => $_has(2);
  @$pb.TagNumber(3)
  void clearFrame() => clearField(3);
  @$pb.TagNumber(3)
  Frame ensureFrame() => $_ensure(2);
}

class Frame extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Frame', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'video'), createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'number', $pb.PbFieldType.O3)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'lastChunk', protoName: 'lastChunk')
    ..a<$core.List<$core.int>>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chunk', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  Frame._() : super();
  factory Frame({
    $core.int? number,
    $core.bool? lastChunk,
    $core.List<$core.int>? chunk,
  }) {
    final _result = create();
    if (number != null) {
      _result.number = number;
    }
    if (lastChunk != null) {
      _result.lastChunk = lastChunk;
    }
    if (chunk != null) {
      _result.chunk = chunk;
    }
    return _result;
  }
  factory Frame.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Frame.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Frame clone() => Frame()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Frame copyWith(void Function(Frame) updates) => super.copyWith((message) => updates(message as Frame)) as Frame; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Frame create() => Frame._();
  Frame createEmptyInstance() => create();
  static $pb.PbList<Frame> createRepeated() => $pb.PbList<Frame>();
  @$core.pragma('dart2js:noInline')
  static Frame getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Frame>(create);
  static Frame? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get number => $_getIZ(0);
  @$pb.TagNumber(1)
  set number($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearNumber() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get lastChunk => $_getBF(1);
  @$pb.TagNumber(2)
  set lastChunk($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLastChunk() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastChunk() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get chunk => $_getN(2);
  @$pb.TagNumber(3)
  set chunk($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChunk() => $_has(2);
  @$pb.TagNumber(3)
  void clearChunk() => clearField(3);
}

class EmptyVideoResponse extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'EmptyVideoResponse', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'video'), createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  EmptyVideoResponse._() : super();
  factory EmptyVideoResponse() => create();
  factory EmptyVideoResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EmptyVideoResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EmptyVideoResponse clone() => EmptyVideoResponse()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EmptyVideoResponse copyWith(void Function(EmptyVideoResponse) updates) => super.copyWith((message) => updates(message as EmptyVideoResponse)) as EmptyVideoResponse; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static EmptyVideoResponse create() => EmptyVideoResponse._();
  EmptyVideoResponse createEmptyInstance() => create();
  static $pb.PbList<EmptyVideoResponse> createRepeated() => $pb.PbList<EmptyVideoResponse>();
  @$core.pragma('dart2js:noInline')
  static EmptyVideoResponse getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EmptyVideoResponse>(create);
  static EmptyVideoResponse? _defaultInstance;
}

class PullVideoStreamReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PullVideoStreamReq', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'video'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  PullVideoStreamReq._() : super();
  factory PullVideoStreamReq({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory PullVideoStreamReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PullVideoStreamReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PullVideoStreamReq clone() => PullVideoStreamReq()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PullVideoStreamReq copyWith(void Function(PullVideoStreamReq) updates) => super.copyWith((message) => updates(message as PullVideoStreamReq)) as PullVideoStreamReq; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PullVideoStreamReq create() => PullVideoStreamReq._();
  PullVideoStreamReq createEmptyInstance() => create();
  static $pb.PbList<PullVideoStreamReq> createRepeated() => $pb.PbList<PullVideoStreamReq>();
  @$core.pragma('dart2js:noInline')
  static PullVideoStreamReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PullVideoStreamReq>(create);
  static PullVideoStreamReq? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class PullVideoStreamResp extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'PullVideoStreamResp', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'video'), createEmptyInstance: create)
    ..aOM<Video>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'video', subBuilder: Video.create)
    ..aOB(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'closed')
    ..hasRequiredFields = false
  ;

  PullVideoStreamResp._() : super();
  factory PullVideoStreamResp({
    Video? video,
    $core.bool? closed,
  }) {
    final _result = create();
    if (video != null) {
      _result.video = video;
    }
    if (closed != null) {
      _result.closed = closed;
    }
    return _result;
  }
  factory PullVideoStreamResp.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PullVideoStreamResp.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PullVideoStreamResp clone() => PullVideoStreamResp()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PullVideoStreamResp copyWith(void Function(PullVideoStreamResp) updates) => super.copyWith((message) => updates(message as PullVideoStreamResp)) as PullVideoStreamResp; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static PullVideoStreamResp create() => PullVideoStreamResp._();
  PullVideoStreamResp createEmptyInstance() => create();
  static $pb.PbList<PullVideoStreamResp> createRepeated() => $pb.PbList<PullVideoStreamResp>();
  @$core.pragma('dart2js:noInline')
  static PullVideoStreamResp getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PullVideoStreamResp>(create);
  static PullVideoStreamResp? _defaultInstance;

  @$pb.TagNumber(1)
  Video get video => $_getN(0);
  @$pb.TagNumber(1)
  set video(Video v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasVideo() => $_has(0);
  @$pb.TagNumber(1)
  void clearVideo() => clearField(1);
  @$pb.TagNumber(1)
  Video ensureVideo() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.bool get closed => $_getBF(1);
  @$pb.TagNumber(2)
  set closed($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasClosed() => $_has(1);
  @$pb.TagNumber(2)
  void clearClosed() => clearField(2);
}

