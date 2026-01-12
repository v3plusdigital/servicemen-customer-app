import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/custom_widgets/custom_dialog_box.dart';
import 'package:servicemen_customer_app/models/get_address_list_model.dart';
import 'package:servicemen_customer_app/providers/location_provider.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';

import '../../custom_widgets/custom_appbar.dart';
import '../../custom_widgets/custom_button.dart';
import '../../providers/auth_provider.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';
import '../../utils/app_textstyles.dart';
import '../../utils/build_extention.dart';
import 'manually_address_screen.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        title: context.l10n.address,
        actionWidget: [
          GestureDetector(
            onTap: () async {
              context.read<LocationProvider>().clearFormValue();
              final cancel = BotToast.showLoading();
              await context.read<LocationProvider>().getServiceArea(showLoader: false).then((
                  onValue) {
                cancel(); // ALWAYS close loading
                openAddAddressBottomSheet(context, false);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Text(
                "+${context.l10n.addAddress}",
                style: AppTextStyles.sf14kPrimaryW500TextStyle,
              ),
            ),
          ),
        ],
      ),
      body: Selector<LocationProvider, int>(
        selector: (_, p) => p.selectedAddress,
        builder: (context, p, w) {
          List<Address>? addressList = context
              .select<LocationProvider, List<Address>?>(
                (p) => p.addressListModel?.data?.addresses ?? [],
          );
          bool? loading = context
              .select<LocationProvider, bool?>(
                (p) => p.isLoading,
          );
          return loading == true ? Container() : addressList!.isEmpty ? Center(
            child: Text(
              "Address not found",
              style: AppTextStyles.sf16kPrimaryColorMediumTextStyle,
            ),
          ) : ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            itemCount: addressList.length,
            separatorBuilder: (context, i) => SizedBox(height: 15),
            itemBuilder: (context, i) {
              Address address = addressList[i];

              return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.kGrey1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {

                            openChangeAddressBottomSheet(context, address.id!);
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: p == address.id
                                        ? AppColors.kPrimaryColor
                                        : AppColors.kGrey1,
                                    width: 2,
                                  ),
                                ),
                                child: p == address.id
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
                              Text(
                                address.addressType ?? "",
                                style: AppTextStyles.sf16kBlackW500TextStyle,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<LocationProvider>()
                                    .updateFormValue(address)
                                    .then((onValue) {
                                  print("address---->" + address.id.toString());
                                  openAddAddressBottomSheet(
                                    context,
                                    true,
                                    id: address.id,
                                  );
                                });
                              },
                              child: AppImageWidget().svgImage(
                                imageName: AppImages.editIcon,
                                width: 15,
                                height: 20,
                              ),
                            ),

                            p != address.id ? Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  showConfirmDialog(context: context,
                                      title: context.l10n.deleteAddress,
                                      message:context.l10n.areYouSureYouWantToDeleteThisAddress,
                                      positiveText: context.l10n.delete,
                                      negativeText:context.l10n.cancel ,
                                      onPositiveTap: () async {
                                        final provider = context
                                            .read<LocationProvider>();
                                        final cancel = BotToast.showLoading();
                                        provider.isLoading = true;
                                        bool val = await provider.deleteAddress(
                                          address.id!,
                                        );
                                        print("val---$val");
                                        if (val == true) {
                                          await provider.getAddressList().then((
                                              onValue) {
                                            provider.isLoading = false;
                                          });
                                        } else {
                                          BotToast.showText(
                                            text: provider.errorMessage.toString(),
                                          );
                                        }
                                        cancel();
                                        provider.isLoading = false;
                                        Navigator.pop(context);
                                      });


                                },
                                child: AppImageWidget().svgImage(
                                  imageName: AppImages.deleteIcon,
                                  width: 15,
                                  height: 20,
                                ),
                              ),
                            ) : Container(),

                          ],
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () =>
                          openChangeAddressBottomSheet(context, address.id!),
                      child: Text(
                        "${address.houseFlatNo}, ${address
                            .buildingSocietyName}, ${address.landmark != null
                            ? "${address.landmark}, "
                            : ""} ${address.area}, ${address.city}, ${address
                            .state}-${address.pincode}",
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void openAddAddressBottomSheet(BuildContext context,
      bool isUpdate, {
        int? id,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          StatefulBuilder(
            builder: (context, setState) {
              return AddAddressBottomSheet(
                fromDashboard: false,
                isUpdate: isUpdate,
                id: id,
              );
            },
          ),
    );
  }

  Widget changeAddressBottomSheet(BuildContext context, int id) {
    final bottomPadding = MediaQuery
        .of(context)
        .viewInsets
        .bottom;
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
                      context.l10n.changeAddress,
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
              const SizedBox(height: 8),
              Text(
                context.l10n.doYouWantToUpdateYourLocation,
                style: AppTextStyles.sf16kGreyW400TextStyle,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: context.wp(0.44),
                    child: CustomOutlineButton(
                      borderRadius: BorderRadius.circular(8),
                      child: Text(
                        context.l10n.no,
                        style: AppTextStyles.sf14kGreyW400TextStyle,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: context.wp(0.44),
                    child: GradientButton(
                      child: Text(
                        context.l10n.yes,
                        style: AppTextStyles.sf16kWhiteMediumTextStyle,
                      ),
                      onPressed: () async {
                        final cancel = BotToast.showLoading();
                        context.read<LocationProvider>().selectMainAddress(id);
                        await context
                            .read<LocationProvider>()
                            .setDefaultAddress();
                        context.read<AuthProvider>().getProfile(context);
                        cancel();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void openChangeAddressBottomSheet(BuildContext context, int id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          StatefulBuilder(
            builder: (context, setState) {
              print("Id--->" + id.toString());
              return changeAddressBottomSheet(context, id);
            },
          ),
    );
  }
}
