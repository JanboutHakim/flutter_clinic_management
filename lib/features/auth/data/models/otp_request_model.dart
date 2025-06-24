class OtpRequestModel {
  final String otp;
  final String userName;
  const OtpRequestModel({required this.otp, required this.userName});

  Map<String, dynamic> toJson() {
    return {"username": userName, "otp": otp};
  }
}
