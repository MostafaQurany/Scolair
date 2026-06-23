import 'otp_flow_type.dart';

class OtpArgs {
  const OtpArgs({
    required this.identifier,
    required this.flow,
    this.sessionId = '',
  });

  final String identifier;
  final OtpFlowType flow;
  final String sessionId;
}