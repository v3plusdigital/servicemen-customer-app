import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_text_field.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_text_widget.dart';
import 'package:servicemen_customer_app/models/get_profile_model.dart';
import 'package:servicemen_customer_app/utils/app_functions.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/app_textstyles.dart';

import '../../custom_widgets/choose_image_widget.dart';
import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_button.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/build_extention.dart';

class ProfileInformationScreen extends StatelessWidget {
  ProfileInformationScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: context.read<AuthProvider>().isUpdateProfile == true
            ? context.l10n.personalInformation
            : context.l10n.profileSetup,
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildProfileImage(context),
              buildName(context),
              buildPhoneNumber(context),
              buildEmail(context),
              buildGender(context),
              SizedBox(height: 60),
              GradientButton(
                child: Text(
                  context.read<AuthProvider>().isUpdateProfile == true
                      ? context.l10n.update
                      : context.l10n.continueStr,
                  style: AppTextStyles.sf16kWhiteMediumTextStyle,
                ),
                onPressed: () async {
                  final provider = context.read<AuthProvider>();
                  print(
                    "_formKey.currentState!.validate()--" +
                        _formKey.currentState!.validate().toString(),
                  );
                  if (!_formKey.currentState!.validate()) return;
                  if (provider.gender == "") {
                    BotToast.showText(text: "Please select gender");
                    return;
                  }
                  final cancel = BotToast.showLoading();
                  if (provider.isUpdateProfile == true) {
                    final success = await provider.updateProfileApi(context);
                    cancel(); // ALWAYS close loading
                    if (success) {
                      Navigator.pop(context);
                      BotToast.showText(text: "Profile updated successfully");
                      provider.getProfile(context);
                      provider.updateProfile(true);
                    } else {
                      BotToast.showText(text: provider.errorMessage ?? "Error");
                    }
                  } else {
                    final success = await provider.createProfile(context);
                    cancel(); // ALWAYS close loading
                    if (success) {
                      Navigator.pushNamed(context, AppRoutes.home);
                      // Navigator.pushNamed(context, AppRoutes.chooseAddress);
                    } else {
                      BotToast.showText(text: provider.errorMessage ?? "Error");
                    }
                  }
                },
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage(BuildContext context) {
    final File? selectedImage = context.select<AuthProvider, File?>(
      (p) => p.image,
    );

    return SizedBox(
      width: context.width,
      child: Center(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.kGrey1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: context.read<AuthProvider>().isUpdateProfile == true
                  ? buildUpdateProfileImage(context)
                  :buildUpdateProfileImage(context)

              /*(selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.file(
                              selectedImage,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: AppImageWidget().svgImage(
                              imageName: AppImages.personIcon,
                              height: 70,
                              width: 70,
                            ),
                          )),*/
            ),
            GestureDetector(
              onTap: () {
                final provider = context.read<AuthProvider>();
                if (provider.isUpdateProfile == true) {
                  showUploadOrDeleteProfilePictureBottomSheet(context, (
                    v,
                  ) async {
                    if (v == true) {
                      final cancel = BotToast.showLoading();
                      try {
                        bool? val = await provider.deleteProfilePhoto();
                        if (val == true) {
                          provider.getProfile(context);
                          provider.updateProfile(true);
                        }
                        Navigator.pop(context);
                      } catch (e) {
                        print("Error--$e");
                      } finally {
                        cancel();
                      }
                    } else {
                      showImagePickerBottomSheet(context, (file) async {
                        final cancel = BotToast.showLoading();
                        try {
                          await provider.changeImage(file).then((c) async {
                            await provider.getProfile(context);
                            provider.updateProfile(true);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                        } catch (e) {
                          print("Error--$e");
                        } finally {
                          cancel();
                        }
                      });
                    }
                  });
                } else {

                  final provider = context.read<AuthProvider>();
                  showImagePickerBottomSheet(context, (file) async {
                    final cancel = BotToast.showLoading();
                    try {
                      await  provider.changeImage(file).then((c)  async {
                        await provider.getProfile(context);
                        Navigator.pop(context);
                      });
                    } catch (e) {
                      print("Error--$e");
                    } finally {
                      cancel();
                    }
                  });
                  /*final cancel = BotToast.showLoading();

                  showImagePickerBottomSheet(context, (file) {
                    provider.changeImage(file);
                  });*/
                }
              },
              child: Container(
                width: 37,
                height: 37,
                decoration: BoxDecoration(
                  color: AppColors.kGrey2,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: AppImageWidget().svgImage(
                    imageName: AppImages.cameraIcon,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildUpdateProfileImage(BuildContext context) {
    final GetProfileResponseModel? model = context
        .select<AuthProvider, GetProfileResponseModel?>(
          (p) => p.getProfileResponseModel,
        );
    print(
      "model?.data!.customer!.profilePhoto--->${model?.data!.customer!.profilePhoto?.thumb}",
    );
    return model?.data!.customer!.profilePhoto == null
        ? Center(
            child: AppImageWidget().svgImage(
              imageName: AppImages.personIcon,
              height: 70,
              width: 70,
            ),
          )
        : AppImageWidget().customNetworkImage(
            radius: 70,
            image: model?.data?.customer!.profilePhoto!.thumb! ?? "",
          );
  }

  Widget buildName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(context.l10n.name, style: AppTextStyles.sf14kBlackW400TextStyle),
          SizedBox(height: 10),
          CustomTextField(
            controller: context.read<AuthProvider>().nameController,
            fillColor: AppColors.kWhite,
            hintText: context.l10n.enterYourNameHere,
            keyboardType: TextInputType.name,
            validator: (v) {
              if (isEmpty(v?.trim())) return "Please enter name";
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget buildEmail(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.email,
            style: AppTextStyles.sf14kBlackW400TextStyle,
          ),
          SizedBox(height: 10),
          CustomTextField(
            controller: context.read<AuthProvider>().emailController,
            fillColor: AppColors.kWhite,
            hintText: context.l10n.enterYourEmailHere,
            keyboardType: TextInputType.emailAddress,
            validator: (v) => validateEmail(v),
          ),
        ],
      ),
    );
  }

  Widget buildPhoneNumber(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.phoneNumber,
            style: AppTextStyles.sf14kBlackW400TextStyle,
          ),
          SizedBox(height: 10),
          CustomTextField(
            readOnly: true,
            fillColor: AppColors.kWhite,
            prefixIcon: AppImageWidget().svgImage(
              imageName: AppImages.indianFlagIcon,
            ),
            controller: context.read<AuthProvider>().loginPhoneNumberController,
          ),
        ],
      ),
    );
  }

  Widget buildGender(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.gender, style: AppTextStyles.sf14kBlackW400TextStyle),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRadio(
              value: context.l10n.male,
              selected: provider.gender == context.l10n.male,
              onTap: () => provider.selectGender(context.l10n.male),
            ),

            // const SizedBox(width: 20),
            CustomRadio(
              value: context.l10n.female,
              selected: provider.gender == context.l10n.female,
              onTap: () => provider.selectGender(context.l10n.female),
            ),

            CustomRadio(
              value: context.l10n.other,
              selected: provider.gender == context.l10n.other,
              onTap: () => provider.selectGender(context.l10n.other),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomRadio extends StatelessWidget {
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const CustomRadio({
    super.key,
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        width: context.width / 3.6,
        padding: EdgeInsets.symmetric(horizontal: 7),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.kGrey1),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.kPrimaryColor : AppColors.kGrey1,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    )
                  : null,
            ),
            Text(value, style: AppTextStyles.sf14kGreyW400TextStyle),
          ],
        ),
      ),
    );
  }
}
