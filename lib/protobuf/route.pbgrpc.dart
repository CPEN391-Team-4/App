///
//  Generated code. Do not modify.
//  source: route.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'route.pb.dart' as $0;
export 'route.pb.dart';

class RouteClient extends $grpc.Client {
  static final _$addTrustedUser = $grpc.ClientMethod<$0.User, $0.Empty>(
      '/route.Route/AddTrustedUser',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$updateTrustedUser = $grpc.ClientMethod<$0.User, $0.Empty>(
      '/route.Route/UpdateTrustedUser',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$verifyUserFace =
      $grpc.ClientMethod<$0.FaceVerificationReq, $0.FaceVerificationResp>(
          '/route.Route/VerifyUserFace',
          ($0.FaceVerificationReq value) => value.writeToBuffer(),
          ($core.List<$core.int> value) =>
              $0.FaceVerificationResp.fromBuffer(value));
  static final _$removeTrustedUser = $grpc.ClientMethod<$0.User, $0.Empty>(
      '/route.Route/RemoveTrustedUser',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$getUserPhoto = $grpc.ClientMethod<$0.User, $0.Photo>(
      '/route.Route/GetUserPhoto',
      ($0.User value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Photo.fromBuffer(value));
  static final _$getAllUserNames = $grpc.ClientMethod<$0.Empty, $0.UserNames>(
      '/route.Route/GetAllUserNames',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.UserNames.fromBuffer(value));
  static final _$getHistoryReocorded =
      $grpc.ClientMethod<$0.Timestamp, $0.HistoryRecord>(
          '/route.Route/GetHistoryReocorded',
          ($0.Timestamp value) => value.writeToBuffer(),
          ($core.List<$core.int> value) => $0.HistoryRecord.fromBuffer(value));
  static final _$givePermission = $grpc.ClientMethod<$0.Permission, $0.Empty>(
      '/route.Route/GivePermission',
      ($0.Permission value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Empty.fromBuffer(value));
  static final _$getLastestImage = $grpc.ClientMethod<$0.Empty, $0.Photo>(
      '/route.Route/GetLastestImage',
      ($0.Empty value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.Photo.fromBuffer(value));

  RouteClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$0.Empty> addTrustedUser($async.Stream<$0.User> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$addTrustedUser, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.Empty> updateTrustedUser(
      $async.Stream<$0.User> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$updateTrustedUser, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.FaceVerificationResp> verifyUserFace(
      $async.Stream<$0.FaceVerificationReq> request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$verifyUserFace, request, options: options)
        .single;
  }

  $grpc.ResponseFuture<$0.Empty> removeTrustedUser($0.User request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$removeTrustedUser, request, options: options);
  }

  $grpc.ResponseStream<$0.Photo> getUserPhoto($0.User request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getUserPhoto, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.UserNames> getAllUserNames($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getAllUserNames, request, options: options);
  }

  $grpc.ResponseStream<$0.HistoryRecord> getHistoryReocorded(
      $0.Timestamp request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getHistoryReocorded, $async.Stream.fromIterable([request]),
        options: options);
  }

  $grpc.ResponseFuture<$0.Empty> givePermission($0.Permission request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$givePermission, request, options: options);
  }

  $grpc.ResponseStream<$0.Photo> getLastestImage($0.Empty request,
      {$grpc.CallOptions? options}) {
    return $createStreamingCall(
        _$getLastestImage, $async.Stream.fromIterable([request]),
        options: options);
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
    $addMethod(
        $grpc.ServiceMethod<$0.FaceVerificationReq, $0.FaceVerificationResp>(
            'VerifyUserFace',
            verifyUserFace,
            true,
            false,
            ($core.List<$core.int> value) =>
                $0.FaceVerificationReq.fromBuffer(value),
            ($0.FaceVerificationResp value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.User, $0.Empty>(
        'RemoveTrustedUser',
        removeTrustedUser_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.User, $0.Photo>(
        'GetUserPhoto',
        getUserPhoto_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.User.fromBuffer(value),
        ($0.Photo value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.UserNames>(
        'GetAllUserNames',
        getAllUserNames_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.UserNames value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Timestamp, $0.HistoryRecord>(
        'GetHistoryReocorded',
        getHistoryReocorded_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Timestamp.fromBuffer(value),
        ($0.HistoryRecord value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Permission, $0.Empty>(
        'GivePermission',
        givePermission_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.Permission.fromBuffer(value),
        ($0.Empty value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Empty, $0.Photo>(
        'GetLastestImage',
        getLastestImage_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Empty.fromBuffer(value),
        ($0.Photo value) => value.writeToBuffer()));
  }

  $async.Future<$0.Empty> removeTrustedUser_Pre(
      $grpc.ServiceCall call, $async.Future<$0.User> request) async {
    return removeTrustedUser(call, await request);
  }

  $async.Stream<$0.Photo> getUserPhoto_Pre(
      $grpc.ServiceCall call, $async.Future<$0.User> request) async* {
    yield* getUserPhoto(call, await request);
  }

  $async.Future<$0.UserNames> getAllUserNames_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async {
    return getAllUserNames(call, await request);
  }

  $async.Stream<$0.HistoryRecord> getHistoryReocorded_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Timestamp> request) async* {
    yield* getHistoryReocorded(call, await request);
  }

  $async.Future<$0.Empty> givePermission_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Permission> request) async {
    return givePermission(call, await request);
  }

  $async.Stream<$0.Photo> getLastestImage_Pre(
      $grpc.ServiceCall call, $async.Future<$0.Empty> request) async* {
    yield* getLastestImage(call, await request);
  }

  $async.Future<$0.Empty> addTrustedUser(
      $grpc.ServiceCall call, $async.Stream<$0.User> request);
  $async.Future<$0.Empty> updateTrustedUser(
      $grpc.ServiceCall call, $async.Stream<$0.User> request);
  $async.Future<$0.FaceVerificationResp> verifyUserFace(
      $grpc.ServiceCall call, $async.Stream<$0.FaceVerificationReq> request);
  $async.Future<$0.Empty> removeTrustedUser(
      $grpc.ServiceCall call, $0.User request);
  $async.Stream<$0.Photo> getUserPhoto($grpc.ServiceCall call, $0.User request);
  $async.Future<$0.UserNames> getAllUserNames(
      $grpc.ServiceCall call, $0.Empty request);
  $async.Stream<$0.HistoryRecord> getHistoryReocorded(
      $grpc.ServiceCall call, $0.Timestamp request);
  $async.Future<$0.Empty> givePermission(
      $grpc.ServiceCall call, $0.Permission request);
  $async.Stream<$0.Photo> getLastestImage(
      $grpc.ServiceCall call, $0.Empty request);
}
