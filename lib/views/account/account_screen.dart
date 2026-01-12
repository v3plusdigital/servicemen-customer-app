import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_appbar.dart';
import 'package:servicemen_customer_app/providers/auth_provider.dart';
import 'package:servicemen_customer_app/utils/app_functions.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';

import '../../custom_widgets/custom_dialog_box.dart';
import '../../models/get_profile_model.dart';
import '../../providers/location_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_images.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AuthProvider>();
    GetProfileResponseModel? model = context
        .select<AuthProvider, GetProfileResponseModel?>(
          (p) => p.getProfileResponseModel,
        );
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          /// Profile
          Column(
            children: [
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGrey1),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: model?.data!.customer!.profilePhoto == null
                    ? Center(
                        child: AppImageWidget().svgImage(
                          imageName: AppImages.personIcon,
                          height: 70,
                          width: 70,
                        ),
                      )
                    : AppImageWidget().customNetworkImage(
                        radius: 70,
                        image:
                            model?.data!.customer!.profilePhoto!.thumb! ?? "",
                      ),
              ),
              const SizedBox(height: 8),
              Text(
                provider.getProfileResponseModel?.data!.customer!.name ?? "",
                style: AppTextStyles.sf16kBlackW600TextStyle,
              ),
              Text(
                provider.getProfileResponseModel?.data!.customer!.email ?? "",
                style: AppTextStyles.sf14kGreyW400TextStyle,
              ),
            ],
          ),

          const SizedBox(height: 32),

          /// Account Details
          _sectionTitle(
            context.l10n.accountDetails,
            AppTextStyles.sf14kGreyW400TextStyle,
          ),
          _item(
            title: context.l10n.personalInformation,
            onTap: () {
              provider.updateProfile(true);
              Navigator.pushNamed(context, AppRoutes.profileInformation);
            },
          ),
          const Divider(thickness: 1),
          _item(
            title: context.l10n.manageAddress,
            onTap: () async {
              final provider = context.read<LocationProvider>();
              final cancel = BotToast.showLoading();

              final successVal = await provider.getAddressList();

              cancel(); // ALWAYS close loading
              print("successVal--->$successVal");
              if (successVal == true) {
                Navigator.pushNamed(context, AppRoutes.addressList);
              } else {
                BotToast.showText(text: provider.errorMessage ?? "Error");
              }
            },
          ),
          const Divider(thickness: 1),
          _item(title: context.l10n.changeLanguage, onTap: () {
            Navigator.pushNamed(context, AppRoutes.languageSelection);
          }),

          const SizedBox(height: 24),

          /// Other Details
          _sectionTitle(
            context.l10n.otherDetails,
            AppTextStyles.sf14kGreyW400TextStyle,
          ),
          _item(title: context.l10n.helpSupport, onTap: () {}),
          const Divider(thickness: 1),
          _item(title: context.l10n.faqs, onTap: () {}),
          const Divider(thickness: 1),
          _item(title: context.l10n.termsConditions, onTap: () {}),
          const Divider(thickness: 1),
          _item(title: context.l10n.privacyPolicy, onTap: () {}),
          const Divider(thickness: 1),
          _item(title: context.l10n.refundPolicy, onTap: () {}),
          const Divider(thickness: 1),
          _item(title: context.l10n.aboutUs, onTap: () {}),

          const SizedBox(height: 32),

          /// Logout
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: ()  {
                showConfirmDialog(
                  context: context,
                  title: capitalize(context.l10n.logOut),
                  message:context.l10n.areYouSureYouWantToLogOut,
                  positiveText: capitalize(context.l10n.logOut),
                  negativeText: context.l10n.cancel,
                  onPositiveTap: () async {
                    final val = await context.read<AuthProvider>().logout();
                    if (val == true) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.login,
                        (predicate) => false,
                      );
                    }
                  },
                );
              },
              icon: AppImageWidget().svgImage(
                imageName: AppImages.logoutIcon,
                height: 18,
                width: 18,
              ),
              label: Text(
                context.l10n.logOut,
                style: AppTextStyles.sf16kRedW400TextStyle,
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.kRed),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helpers
  Widget _sectionTitle(String title, TextStyle style) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(title, style: style),
      ),
    );
  }

  Widget _item({
    required String title,
    required VoidCallback onTap,
    TextStyle? style,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: style ?? AppTextStyles.sf16kBlackW400TextStyle),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: AppImageWidget().svgImage(
              imageName: AppImages.arrowForwardIcon,
              height: 12,
              width: 12,
            ),
          ),
        ],
      ),
    );
  }
}
