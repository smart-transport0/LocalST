import 'dart:math';

class Verification {
  static String otpGenerator() {
    String otp = '';
    var random = Random();
    for (int i = 0; i < 4; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }
}
