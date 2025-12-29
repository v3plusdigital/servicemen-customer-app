import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/app_image_widget.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../providers/cart_provider.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../../utils/app_textstyles.dart';
import '../../../utils/build_extention.dart';

class AddCounterWidget extends StatelessWidget {
 final int serviceId;
 const AddCounterWidget({super.key,required this.serviceId});

  @override
  Widget build(BuildContext context) {
    return Selector<CartProvider, int>(
      selector: (_, p) => p.getQuantity(serviceId),
      builder: (_, qty, __) {
        if (qty == 0) {
          return CustomOutlineButton(
            height: 38,
            borderRadius: BorderRadius.circular(8),
            color: AppColors.kGrey1,
            child: Text(
              context.l10n.add,
              style: AppTextStyles.sf14kPrimaryW400TextStyle,
            ),
            onPressed: () => context.read<CartProvider>().add(serviceId),
          );
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _iconBtn(
              AppImages.deleteIcon,
                  () => context.read<CartProvider>().remove(serviceId),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "$qty",
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            _iconBtn(
              AppImages.addIcon,
                  () => context.read<CartProvider>().add(serviceId),
            ),
          ],
        );
      },
    );
  }


  Widget _iconBtn(String icon, VoidCallback onTap) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kGrey1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: AppImageWidget().svgImage(imageName: icon),
        ),
      ),
    );
  }
}


