import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';

import '../../custom_widgets/custom_button.dart';
import '../../providers/location_provider.dart';
import '../../utils/app_textstyles.dart';
import '../../utils/build_extention.dart';
import 'manually_address_screen.dart';


class ChooseAddressScreen extends StatelessWidget {
  const ChooseAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        ///expanded
        child: Stack(
          children: [
            // _MapView(),
            Container(
              height: 100,
            ),
             Align(
              alignment: Alignment.bottomCenter,
              child: buildLocationBottomCard(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLocationBottomCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color:AppColors.kWhite,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          buildPlaceTitle(context),
          SizedBox(height: 6),
          buildAddress(context),
          SizedBox(height: 16),
          GradientButton(
            child: Text(
              context.l10n.useMyCurrentLocation,
              style: AppTextStyles.sf16kWhiteMediumTextStyle,
            ),
            onPressed: () {

            },
          ),
          SizedBox(height: 12),
          CustomOutlineButton(
            width: context.width,
            // height: 38,
            borderRadius: BorderRadius.circular(8),
            color: AppColors.kPrimaryColor,
            child: Text(
              context.l10n.addManually,
              style: AppTextStyles.sf16kPrimaryColorMediumTextStyle,
            ),
            onPressed: () {
              openAddAddressBottomSheet(context);
              // p.skipToEnd(p.onboardingData.length);
            },
          ),
        ],
      ),
    );
  }

  Widget buildPlaceTitle(BuildContext context) {
    return Selector<LocationProvider, String>(
      selector: (_, p) => p.placeName,
      builder: (_, place, __) {
        return Row(
          children: [
            Expanded(
              child: Text(
                place,
                style:AppTextStyles.sf20kBlackSemiboldTextStyle
              ),
            ),
           AppImageWidget().svgImage(imageName: AppImages.closeIcon)
          ],
        );
      },
    );
  }

  Widget buildAddress(BuildContext context) {
    return Selector<LocationProvider, String>(
      selector: (_, p) => p.address,
      builder: (_, address, __) {
        return Text(
          address,
          style: TextStyle(
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        );
      },
    );
  }

  void openAddAddressBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return const AddAddressBottomSheet();
        }
      ),
    );
  }
}
class _MapView extends StatelessWidget {
  const _MapView();

  @override
  Widget build(BuildContext context) {
    return Selector<LocationProvider, LatLng>(
      selector: (_, p) => p.currentPosition,
      builder: (_, position, __) {
        return GoogleMap(
          initialCameraPosition: CameraPosition(
            target: position,
            zoom: 16,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("selected"),
              position: position,
            ),
          },
          onTap: (pos) {
            context.read<LocationProvider>().updateLocation(pos);
          },
        );
      },
    );
  }
}

class _UseLocationButton extends StatelessWidget {
  const _UseLocationButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:  AppColors.kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // TODO: Get GPS location
        },
        child: const Text(
          "Use My Current Location",
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
class _AddManualButton extends StatelessWidget {
  const _AddManualButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color:AppColors.kPrimaryColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          // TODO: Navigate to manual address screen
        },
        child: const Text(
          "Add Manually",
          style: TextStyle(
            fontSize: 16,
            color: AppColors.kPrimaryColor
          ),
        ),
      ),
    );
  }
}
