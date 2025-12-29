import 'package:flutter/material.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';

class OnboardingItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final bool active;

  const OnboardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),

        AnimatedScale(
          scale: active ? 1 : 0.9,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: active ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Image.asset(image,height: context.hp(0.4),/* height: 280*/),
          ),
        ),

        const SizedBox(height: 40),

        AnimatedSlide(
          offset: active ? Offset.zero : const Offset(0, 0.2),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            opacity: active ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.sf20kBlackSemiboldTextStyle
            ),
          ),
        ),

        const SizedBox(height: 12),

        AnimatedOpacity(
          opacity: active ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.sf16kGreyW400TextStyle
            ),
          ),
        ),
      ],
    );
  }
}
