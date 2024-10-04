import 'dart:async';

import 'package:flutter/material.dart';
import 'package:x_rate_app/config/routes/custom_push_navigators.dart';
import 'package:x_rate_app/core/utils/color_constants.dart';
import 'package:x_rate_app/core/utils/global_constants.dart';
import 'package:x_rate_app/core/utils/assets.dart';
import 'package:x_rate_app/features/auth/screens/login_screen.dart';
import 'package:x_rate_app/features/auth/services/auth_service.dart';
import 'package:x_rate_app/features/auth/providers/auth_provider.dart';
import 'package:x_rate_app/widgets/custom_app_bar.dart';
import 'package:x_rate_app/widgets/custom_button.dart';
import 'package:x_rate_app/widgets/height_space.dart';
import 'package:x_rate_app/widgets/otp_input_field.dart';
import 'package:x_rate_app/widgets/width_space.dart';
import 'package:provider/provider.dart';

class SignUpVerificationScreen extends StatefulWidget {
  static const String route = "/signup-verification";
  const SignUpVerificationScreen({super.key});

  @override
  State<SignUpVerificationScreen> createState() =>
      _SignUpVerificationScreenState();
}

class _SignUpVerificationScreenState extends State<SignUpVerificationScreen> {
  final AuthService authService = AuthService();
  final TextEditingController firstNumberController = TextEditingController();
  final TextEditingController secondNumberController = TextEditingController();
  final TextEditingController thirdNumberController = TextEditingController();
  final TextEditingController fourthNumberController = TextEditingController();
  final TextEditingController fifthNumberController = TextEditingController();
  final TextEditingController sixthNumberController = TextEditingController();
  bool willResendCodeButton = false;
  final otpFieldKey = GlobalKey<FormState>();

  int _counter = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  verifyOtp() async {
    if (otpFieldKey.currentState!.validate()) {
      String otpCode = firstNumberController.text +
          secondNumberController.text +
          thirdNumberController.text +
          fourthNumberController.text +
          fifthNumberController.text +
          sixthNumberController.text;
      print(otpCode);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      print(authProvider.emailAddress);
      authService.verifyOtp(
        context: context,
        email: authProvider.emailAddress ?? "",
        otpCode: otpCode,
        onSuccessButtonTap: () => namedNavRemoveUntil(
          context,
          LoginScreen.route,
        ),
      );
    }
  }

  sendOtp() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authService.sendOtp(
      context: context,
      email: authProvider.emailAddress ?? "",
      onTapDialogButton: () => popNav(context),
      sendPurpose: 'sign-up-verification',
    );
  }

  void startTimer() {
    _counter = 60;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer!.cancel();
          setState(() {
            willResendCodeButton = true;
          });
          //Resend Code
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(image: logo),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: value20),
        child: Stack(
          children: [
            screenUI(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: heightValue20),
                child: CustomButton(
                  buttonText: "Verify",
                  borderRadius: heightValue30,
                  onTap: () {
                    verifyOtp();
                  },
                  buttonTextColor: secondaryAppColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget screenUI() {
    final userEmail = Provider.of<AuthProvider>(context).emailAddress;
    return Form(
      key: otpFieldKey,
      child: Column(
        children: [
          HeightSpace(heightValue10),
          Text(
            "We sent you a code",
            style: TextStyle(
              fontSize: heightValue30,
              fontWeight: FontWeight.bold,
            ),
          ),
          HeightSpace(heightValue10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Code sent to ",
                style: TextStyle(
                  fontSize: heightValue17,
                ),
              ),
              Text(
                userEmail ?? "",
                style: TextStyle(
                  fontSize: heightValue17,
                  color: primaryAppColor,
                ),
              )
            ],
          ),
          HeightSpace(heightValue20),
          Row(
            // mainAxisAlignment: Main,
            children: [
              Expanded(
                child: OtpCodeInputField(
                  controller: firstNumberController,
                ),
              ),
              WidthSpace(value5),
              Expanded(
                child: OtpCodeInputField(
                  controller: secondNumberController,
                ),
              ),
              WidthSpace(value5),
              Expanded(
                child: OtpCodeInputField(
                  controller: thirdNumberController,
                ),
              ),
              WidthSpace(value5),
              Expanded(
                child: OtpCodeInputField(
                  controller: fourthNumberController,
                ),
              ),
              WidthSpace(value5),
              Expanded(
                child: OtpCodeInputField(
                  controller: fifthNumberController,
                ),
              ),
              WidthSpace(value5),
              Expanded(
                child: OtpCodeInputField(
                  controller: sixthNumberController,
                ),
              ),
            ],
          ),
          HeightSpace(heightValue20),
          RichText(
            text: TextSpan(
              style: TextStyle(fontSize: heightValue17),
              children: [
                const TextSpan(
                  text: 'Resend code',
                ),
                const TextSpan(
                  text: ' in ',
                ),
                TextSpan(
                    text: '$_counter',
                    style: const TextStyle(
                      color: primaryAppColor,
                      fontWeight: FontWeight.bold,
                    )),
                const TextSpan(
                  text: ' s',
                ),
              ],
            ),
          ),
          HeightSpace(heightValue20),
          willResendCodeButton
              ? TextButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      willResendCodeButton = false;
                    });
                    sendOtp();
                  },
                  child: Text(
                    "Resend",
                    style: TextStyle(
                      fontSize: heightValue23,
                    ),
                  ),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
