import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_button.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';
import 'package:servicemen_customer_app/views/auth/widgets/otp_fields_widget.dart';

import '../../custom_widgets/custom_appbar.dart';
import '../../providers/auth_provider.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: context.l10n.verificationCode,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            AppImageWidget().svgImage(
              imageName: AppImages.otpVerificationLockIcon,
            ),

            const SizedBox(height: 20),

            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                context.l10n.enter6DigitCode,
                style: AppTextStyles.sf20kBlackMediumTextStyle,
              ),
            ),

            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: context.l10n.weSentAVerificationCodeToYourPhoneNumber,
                    style: AppTextStyles.sf16kGreyW400TextStyle,
                  ),
                  TextSpan(
                    text:
                        " +91 ${context.read<AuthProvider>().loginPhoneNumberController.text} ",
                    style: AppTextStyles.sf16kGreyW400TextStyle,
                  ),
                  TextSpan(
                    text: context.l10n.change,
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: AppTextStyles.sf16kPrimaryW400TextStyle.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),
            OtpFields(
              length: 6,
              onCompleted: (code) {
                print("OTP Completed = $code");
              },
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Text(
                  context.l10n.youDidntReceivedAnyCode,
                  style: AppTextStyles.sf16kGreyW400TextStyle,
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "${context.l10n.resendCode}",
                    style: AppTextStyles.sf16kPrimaryW400TextStyle.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            GradientButton(
              child: Text(
                context.l10n.verify,
                style: AppTextStyles.sf16kWhiteMediumTextStyle,
              ),
              onPressed: () async {
                final provider = context.read<AuthProvider>();

                final cancel = BotToast.showLoading();

                final success = await provider.verifyOtp();

                cancel(); // ALWAYS close loading

                if (success) {
                  if(provider.verifyOtpModel?.data?.isNewUser==true){
                    Navigator.pushNamed(context, AppRoutes.profileInformation);
                  }
                  else{
                    Navigator.pushNamed(context, AppRoutes.profileInformation);
                  }



                } else {
                  BotToast.showText(
                    text: provider.errorMessage ?? "Error",
                  );
                }
                  },
            ),
            SizedBox(height: 25,)
          ],
        ),
      ),
    );
  }
}
