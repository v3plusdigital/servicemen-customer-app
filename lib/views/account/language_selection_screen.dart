import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_appbar.dart';
import 'package:servicemen_customer_app/providers/locale_provider.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: 'Select Language',
        leading: true,
      ),
      body: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          final currentLanguage = localeProvider.locale.languageCode;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Choose your preferred language',
                style: AppTextStyles.sf16kGreyW400TextStyle,
              ),
              const SizedBox(height: 20),

              // English Option
              _buildLanguageOption(
                context: context,
                languageCode: 'en',
                languageName: 'English',
                languageNameNative: 'English',
                isSelected: currentLanguage == 'en',
                onTap: () async {
                  await localeProvider.changeLocale('en');
                },
              ),

              const SizedBox(height: 12),

              // Hindi Option
              _buildLanguageOption(
                context: context,
                languageCode: 'hi',
                languageName: 'Hindi',
                languageNameNative: 'हिंदी',
                isSelected: currentLanguage == 'hi',
                onTap: () async {
                  await localeProvider.changeLocale('hi');
                },
              ),

              const SizedBox(height: 12),

              // Gujarati Option
              _buildLanguageOption(
                context: context,
                languageCode: 'gu',
                languageName: 'Gujarati',
                languageNameNative: 'ગુજરાતી',
                isSelected: currentLanguage == 'gu',
                onTap: () async {
                  await localeProvider.changeLocale('gu');
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String languageCode,
    required String languageName,
    required String languageNameNative,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          border: Border.all(
            color: isSelected ? AppColors.kPrimaryColor : AppColors.kGrey2,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Radio button
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppColors.kPrimaryColor
                      : AppColors.kGrey2,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    )
                  : null,
            ),

            const SizedBox(width: 16),

            // Language names
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    languageName,
                    style: AppTextStyles.sf16kBlackW500TextStyle,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    languageNameNative,
                    style: AppTextStyles.sf14kGreyW400TextStyle,
                  ),
                ],
              ),
            ),

            // Checkmark icon for selected
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.kPrimaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
