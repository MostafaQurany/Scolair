import 'otp_flow_type.dart';

class OtpArgs {
  const OtpArgs({required this.email, required this.flow});

  final String email;
  final OtpFlowType flow;
}
