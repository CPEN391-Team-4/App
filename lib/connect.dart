import 'package:grpc/grpc.dart';
import 'package:my_app/protobuf/TrustPeople.pb.dart';
import 'package:my_app/protobuf/TrustPeople.pbgrpc.dart';
import 'package:my_app/protobuf/video.pbgrpc.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';

//start a connetion with the server normal route with a certain timeout.
connectStart(int timeout) {
  final channel = ClientChannel('cpen391.johnramsden.ca',
      port: 9000,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));

  print("Connect");
  final stub = RouteClient(channel,
      options: CallOptions(timeout: Duration(seconds: timeout)));
  return [stub, channel];
}

// start a connection with server video stream route, without timeout
connectStartvideo() {
  final channel = ClientChannel('cpen391.johnramsden.ca',
      port: 9000,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));

  print("Connect");
  final stub = VideoRouteClient(channel);
  return [stub, channel];
}
