import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_button.dart';
import 'package:servicemen_customer_app/providers/auth_provider.dart';
import 'package:servicemen_customer_app/providers/dashboard_provider.dart';
import 'package:servicemen_customer_app/providers/location_provider.dart';
import 'package:servicemen_customer_app/utils/app_functions.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';
import 'package:servicemen_customer_app/views/address/widgets/app_dropdown_field_widget.dart';

import '../../custom_widgets/custom_text_field.dart';
import '../../models/service_area_model.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../auth/profile_information_screen.dart';

class AddAddressBottomSheet extends StatefulWidget {
  bool fromDashboard;
  bool? isUpdate;
  int? id;

  AddAddressBottomSheet({
    super.key,
    required this.fromDashboard,
    this.isUpdate,
    this.id,
  });

  @override
  State<AddAddressBottomSheet> createState() => _AddAddressBottomSheetState();
}

class _AddAddressBottomSheetState extends State<AddAddressBottomSheet> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;
    final provider = context.read<LocationProvider>();
    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: AppColors.kWhite,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                          const SizedBox(height: 6),
                          CustomTextField(
                            fillColor: AppColors.kWhite,
                            controller: context
                                .read<LocationProvider>()
                                .houseNumberController,
                            hintText: context.l10n.houseNo,
                            keyboardType: TextInputType.streetAddress,
                            validator: (val) {
                              if (isEmpty(val?.trim()))
                                return "Please enter house no.";
                              return null;
                            },
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
                          const SizedBox(height: 6),
                          CustomTextField(
                            fillColor: AppColors.kWhite,
                            controller: context
                                .read<LocationProvider>()
                                .societyNameController,
                            hintText: context.l10n.enterYourBuildingName,
                            keyboardType: TextInputType.streetAddress,
                            validator: (val) {
                              if (isEmpty(val?.trim()))
                                return "Please enter building name";
                              return null;
                            },
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
                const SizedBox(height: 6),
                CustomTextField(
                  fillColor: AppColors.kWhite,
                  controller: context
                      .read<LocationProvider>()
                      .landmarkController,
                  hintText: context.l10n.landmark,
                  keyboardType: TextInputType.streetAddress,
                ),
                const SizedBox(height: 16),

                /// Area
                AppDropdownField<ServiceArea>(
                  label: context.l10n.area,
                  hint: context.l10n.select,
                  value: context.read<LocationProvider>().area,
                  items: context
                      .read<LocationProvider>()
                      .serviceAreaModel!
                      .data!
                      .serviceAreas!
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.area.toString()),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    context.read<LocationProvider>().selectArea(v!);
                    context.read<LocationProvider>().selectState(
                      v.state.toString(),
                    );
                    context.read<LocationProvider>().selectCity(
                      v.city.toString(),
                    );
                  },
                ),

                const SizedBox(height: 16),

                /// City & State
                Row(
                  children: [
                    Expanded(
                      child: Selector<LocationProvider, String?>(
                        selector: (_, p) => p.city,
                        builder: (_, city, __) {
                          return AppDropdownField<String>(
                            label: context.l10n.city,
                            hint: context.l10n.select,
                            value: city,
                            items: city == null
                                ? []
                                : [
                                    DropdownMenuItem(
                                      value: city,
                                      child: Text(city),
                                    ),
                                  ],
                            onChanged: null,
                            // context.read<LocationProvider>().selectCity(v!),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Selector<LocationProvider, String?>(
                        selector: (_, p) => p.state,
                        builder: (_, state, __) {
                          return AppDropdownField<String>(
                            label: context.l10n.state,
                            hint: context.l10n.select,
                            value: state,
                            items: state == null
                                ? []
                                : [
                                    DropdownMenuItem(
                                      value: state,
                                      child: Text(state),
                                    ),
                                  ],
                            onChanged: null,
                            // context.read<LocationProvider>().selectCity(v!),
                          );
                        },
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
                const SizedBox(height: 6),
                CustomTextField(
                  fillColor: AppColors.kWhite,
                  controller: context
                      .read<LocationProvider>()
                      .pinCodeController,
                  hintText: context.l10n.enterYourPincode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  validator: (val) {
                    if (isEmpty(val?.trim())) return "Please enter pincode";
                    if ((val ?? "").length < 6)
                      return "Please enter correct pincode";
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                /// Address Type
                buildAddressType(context),
                const SizedBox(height: 20),

                /// Save Button
                GradientButton(
                  child: Text(
                    widget.fromDashboard == true
                        ? context.l10n.saveContinue
                        : widget.isUpdate == true
                        ? context.l10n.update
                        : context.l10n.save,
                    style: AppTextStyles.sf16kWhiteMediumTextStyle,
                  ),
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    if (provider.area == null) {
                      BotToast.showText(text: "Please select area");
                      return;
                    }
                    if (provider.addressType == "") {
                      BotToast.showText(text: "Please select address type");
                      return;
                    }
                    if (widget.isUpdate == true) {
                      final cancel = BotToast.showLoading();
                      final successVal = await provider.updateAddressApi(widget.id!);
                      print("successVal--->$successVal");
                      if (successVal == true) {
                        await provider.getAddressList();
                        cancel();
                        Navigator.pop(context);
                      }
                    } else {
                      final cancel = BotToast.showLoading();
                      final successVal = await provider.createAddress();
                      print("successVal--->$successVal");
                      if (successVal == true) {
                        if (widget.fromDashboard == true) {
                          cancel();
                          Navigator.pushNamed(context, AppRoutes.home);
                        } else {
                          await provider.getAddressList();
                          await context.read<AuthProvider>().getProfile(context);
                          cancel();
                          Navigator.pop(context);
                        }
                      } else {
                        cancel();
                        BotToast.showText(
                          text: provider.errorMessage ?? "Error",
                        );
                      }
                    }
                  },
                ),
                SizedBox(height:  MediaQuery.of(context).viewInsets.bottom + 20,),
              ],
            ),
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
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRadio(
                  value: context.l10n.home,
                  selected: provider.addressType == context.l10n.home,
                  onTap: () => provider.selectAddressType(context.l10n.home),
                ),


                CustomRadio(
                  value: context.l10n.office,
                  selected: provider.addressType == context.l10n.office,
                  onTap: () => provider.selectAddressType(context.l10n.office),
                ),

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
