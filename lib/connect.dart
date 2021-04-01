import 'package:grpc/grpc.dart';
import 'package:my_app/protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pb.dart';
import 'protobuf/TrustPeople.pbgrpc.dart';

connectStart() {
  final channel = ClientChannel('192.168.0.101',
      port: 9000,
      options:
          const ChannelOptions(credentials: ChannelCredentials.insecure()));

  print("Connect");
  final stub = RouteClient(channel,
      options: CallOptions(timeout: Duration(seconds: 20)));
  return [stub, channel];
}
