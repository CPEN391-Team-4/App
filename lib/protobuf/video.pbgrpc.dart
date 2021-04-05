///
//  Generated code. Do not modify.
//  source: video.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'video.pb.dart' as $0;
export 'video.pb.dart';

class VideoRouteClient extends $grpc.Client {
  static final _$streamVideo =
      $grpc.ClientMethod<$0.Video, $0.EmptyVideoResponse>(
          '/video.VideoRoute/StreamVideo',
          ($0.Video value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.EmptyVideoResponse.fromBuffer(value));
  static final _$pullVideoStream =
      $grpc.ClientMethod<$0.PullVideoStreamReq, $0.PullVideoStreamResp>(
          '/video.VideoRoute/PullVideoStream',
          ($0.PullVideoStreamReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.PullVideoStreamResp.fromBuffer(value));

  VideoRouteClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.EmptyVideoResponse> streamVideo(
      $async.Stream<$0.Video> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$streamVideo, request, options: options)
        .single;
  }

  $grpc.ResponseStream<$0.PullVideoStreamResp> pullVideoStream(
      $0.PullVideoStreamReq request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$pullVideoStream, $async.Stream.fromIterable([request]),
        options: options);
  }
}

abstract class VideoRouteServiceBase extends $grpc.Service {
  $core.String get $name => 'video.VideoRoute';

  VideoRouteServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Video, $0.EmptyVideoResponse>(
        'StreamVideo',
        streamVideo,
        true,
        false,
        ($core.List<$core.int> value) => $0.Video.fromBuffer(value),
        ($0.EmptyVideoResponse value) => value.writeToBuffer()));
    $addMethod(
        $grpc.ServiceMethod<$0.PullVideoStreamReq, $0.PullVideoStreamResp>(
            'PullVideoStream',
            pullVideoStream_Pre,
            false,
            true,
            ($core.List<$core.int> value) =>
                $0.PullVideoStreamReq.fromBuffer(value),
            ($0.PullVideoStreamResp value) => value.writeToBuffer()));
  }

  $async.Stream<$0.PullVideoStreamResp> pullVideoStream_Pre(
      $grpc.ServiceCall call,
      $async.Future<$0.PullVideoStreamReq> request) async* {
    yield* pullVideoStream(call, await request);
  }

  $async.Future<$0.EmptyVideoResponse> streamVideo(
      $grpc.ServiceCall call, $async.Stream<$0.Video> request);
  $async.Stream<$0.PullVideoStreamResp> pullVideoStream(
      $grpc.ServiceCall call, $0.PullVideoStreamReq request);
}
