import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/custom_widgets/app_image_widget.dart';
import 'package:servicemen_customer_app/utils/app_images.dart';
import 'package:servicemen_customer_app/utils/build_extention.dart';

import '../../providers/auth_provider.dart';
import '../../providers/dashboard_provider.dart';
import '../../utils/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final auth = context.read<AuthProvider>();
    await auth.checkStatus();

    if (!mounted) return;
    Future.delayed(Duration(seconds: 2), () async {
      if (auth.isFirstLaunch) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.onBoarding,
          (v) => false,
        );
      } else if (!auth.isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.login,
          (v) => false,
        );
      } else if (auth.isNewUser) {
       await auth.getProfile(context).then((onValue){
         Navigator.pushNamedAndRemoveUntil(
           context,
           AppRoutes.profileInformation,
               (v) => false,
         );
       });

      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.home,
          (v) => false,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: AppImageWidget().customNetworkImage(
              radius: 0,
              image: AppImages.splashImage,
            ),
          ),
          Align(
            alignment: AlignmentGeometry.center,
            child: AppImageWidget().customNetworkImage(
              image: AppImages.logoImage,
              width: context.wp(0.5),
              height: context.wp(0.5),
              radius: 0,
            ),
          ),
        ],
      ),
    );
  }
}
