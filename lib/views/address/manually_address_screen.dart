import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_button.dart';
import 'package:servicemen_customer_app/providers/auth_provider.dart';
import 'package:servicemen_customer_app/providers/location_provider.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../auth/profile_information_screen.dart';

class AddAddressBottomSheet extends StatelessWidget {
  const AddAddressBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.addAddress,
                      style: AppTextStyles.sf20kBlackSemiboldTextStyle,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: AppImageWidget().svgImage(
                      imageName: AppImages.closeIcon,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              /// House / Building
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.houseFlatNo,
                          style: AppTextStyles.sf14kBlackW400TextStyle,
                        ),
                        CustomTextField(
                          fillColor: AppColors.kWhite,
                          controller: context
                              .read<LocationProvider>()
                              .houseNumberController,
                          hintText: context.l10n.houseNo,
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Expanded(
                    flex: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.buildingSocietyName,
                          style: AppTextStyles.sf14kBlackW400TextStyle,
                        ),
                        CustomTextField(
                          fillColor: AppColors.kWhite,
                          controller: context
                              .read<LocationProvider>()
                              .societyNameController,
                          hintText: context.l10n.enterYourBuildingName,
                          keyboardType: TextInputType.streetAddress,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Text(
                context.l10n.landmark,
                style: AppTextStyles.sf14kBlackW400TextStyle,
              ),
              CustomTextField(
                fillColor: AppColors.kWhite,
                controller: context.read<LocationProvider>().landmarkController,
                hintText: context.l10n.houseNo,
                keyboardType: TextInputType.streetAddress,
              ),
              const SizedBox(height: 16),

              /// Area
              AppDropdownField<String>(
                label: context.l10n.area,
                hint: context.l10n.select,
                value: context.read<LocationProvider>().area,
                items: const [
                  DropdownMenuItem(value: "Shahpore", child: Text("Shahpore")),
                  DropdownMenuItem(value: "Adajan", child: Text("Adajan")),
                ],
                onChanged: (v) =>
                    context.read<LocationProvider>().selectArea(v!),
              ),

              const SizedBox(height: 16),

              /// City & State
              Row(
                children: [
                  Expanded(
                    child: AppDropdownField<String>(
                      label: context.l10n.city,
                      hint: context.l10n.select,
                      value: context.read<LocationProvider>().city,
                      items: const [
                        DropdownMenuItem(
                          value: "Shahpore",
                          child: Text("Shahpore"),
                        ),
                        DropdownMenuItem(
                          value: "Adajan",
                          child: Text("Adajan"),
                        ),
                      ],
                      onChanged: (v) =>
                          context.read<LocationProvider>().selectCity(v!),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: AppDropdownField<String>(
                      label: context.l10n.state,
                      hint: context.l10n.select,
                      value: context.read<LocationProvider>().city,
                      items: const [
                        DropdownMenuItem(
                          value: "Shahpore",
                          child: Text("Shahpore"),
                        ),
                        DropdownMenuItem(
                          value: "Adajan",
                          child: Text("Adajan"),
                        ),
                      ],
                      onChanged: (v) =>
                          context.read<LocationProvider>().selectState(v!),
                    ),
                  ),
                ],
              ),
              //
              const SizedBox(height: 16),
              //
              /// Pincode
              Text(
                context.l10n.pincode,
                style: AppTextStyles.sf14kBlackW400TextStyle,
              ),
              CustomTextField(
                fillColor: AppColors.kWhite,
                controller: context.read<LocationProvider>().pinCodeController,
                hintText: context.l10n.enterYourPincode,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              /// Address Type
              buildAddressType(context),
              const SizedBox(height: 35),

              /// Save Button
              GradientButton(
                child: Text(
                  context.l10n.saveContinue,
                  style: AppTextStyles.sf16kWhiteMediumTextStyle,
                ),
                onPressed: () async {
                  final provider = context.read<AuthProvider>();

                  final cancel = BotToast.showLoading();

                  final success = await provider.createProfile(context);

                  cancel(); // ALWAYS close loading

                  if (success) {
                    Navigator.pushNamed(context, AppRoutes.home);
                  } else {
                    BotToast.showText(text: provider.errorMessage ?? "Error");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAddressType(BuildContext context) {
    return Selector<LocationProvider, String>(
      builder: (BuildContext context, String value, Widget? child) {
        final provider = context.read<LocationProvider>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.addressType,
              style: AppTextStyles.sf14kBlackW400TextStyle,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRadio(
                  value: context.l10n.home,
                  selected: provider.addressType == context.l10n.home,
                  onTap: () => provider.selectAddressType(context.l10n.home),
                ),
                const SizedBox(width: 20),
                CustomRadio(
                  value: context.l10n.office,
                  selected: provider.addressType == context.l10n.office,
                  onTap: () => provider.selectAddressType(context.l10n.office),
                ),
                const SizedBox(width: 20),
                CustomRadio(
                  value: context.l10n.other,
                  selected: provider.addressType == context.l10n.other,
                  onTap: () => provider.selectAddressType(context.l10n.other),
                ),
              ],
            ),
          ],
        );
      },
      selector: (_, p) => p.addressType,
    );
  }
}

class AppDropdownField<T> extends StatelessWidget {
  final String label;
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const AppDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          value: value,
          items: items,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down),
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.kGrey2, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
