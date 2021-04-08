import 'package:grpc/grpc.dart';
import 'package:my_app/protobuf/TrustPeople.pb.dart';
import 'package:my_app/protobuf/TrustPeople.pbgrpc.dart';
import 'package:my_app/protobuf/video.pbgrpc.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';

connectStart(int timeout) {
  final channel = ClientChannel('192.168.0.101',
      port: 9000,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));

  print("Connect");
  final stub = RouteClient(channel,
      options: CallOptions(timeout: Duration(seconds: timeout)));
  return [stub, channel];
}

connectStartvideo() {
  final channel = ClientChannel('192.168.0.101',
      port: 9000,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));

  print("Connect");
  final stub = VideoRouteClient(channel);
  return [stub, channel];
}
