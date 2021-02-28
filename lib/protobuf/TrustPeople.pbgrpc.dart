///
//  Generated code. Do not modify.
//  source: TrustPeople.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'TrustPeople.pb.dart' as $0;
export 'TrustPeople.pb.dart';

class RouteClient extends $grpc.Client {
  static final _$addTrustedUser = $grpc.ClientMethod<$0.User, $0.Empty>(
      '/route.Route/AddTrustedUser',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$updateTrustedUser = $grpc.ClientMethod<$0.User, $0.Empty>(
      '/route.Route/UpdateTrustedUser',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$removeTrustedUser = $grpc.ClientMethod<$0.User, $0.Empty>(
      '/route.Route/RemoveTrustedUser',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));

  RouteClient($grpc.ClientChannel channel,
      {$grpc.CallOptions options,
      $core.Iterable<$grpc.ClientInterceptor> interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Empty> addTrustedUser($async.Stream<$0.User> request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(_$addTrustedUser, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.Empty> updateTrustedUser(
      $async.Stream<$0.User> request,
      {$grpc.CallOptions options}) {
    return $createStreamingCall(_$updateTrustedUser, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.Empty> removeTrustedUser($0.User request,
      {$grpc.CallOptions options}) {
    return $createUnaryCall(_$removeTrustedUser, request, options: options);
  }
}

abstract class RouteServiceBase extends $grpc.Service {
  $core.String get $name => 'route.Route';

  RouteServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.User, $0.Empty>(
        'AddTrustedUser',
        addTrustedUser,
        true,
        false,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.User, $0.Empty>(
        'UpdateTrustedUser',
        updateTrustedUser,
        true,
        false,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.User, $0.Empty>(
        'RemoveTrustedUser',
        removeTrustedUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
  }

  $async.Future<$0.Empty> removeTrustedUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.User> request) async {
    return removeTrustedUser(call, await request);
  }

  $async.Future<$0.Empty> addTrustedUser(
      $grpc.ServiceCall call, $async.Stream<$0.User> request);
  $async.Future<$0.Empty> updateTrustedUser(
      $grpc.ServiceCall call, $async.Stream<$0.User> request);
  $async.Future<$0.Empty> removeTrustedUser(
      $grpc.ServiceCall call, $0.User request);
}
