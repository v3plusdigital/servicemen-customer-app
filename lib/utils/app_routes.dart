import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/providers/auth_provider.dart';
import 'package:servicemen_customer_app/providers/booking_provider.dart';
import 'package:servicemen_customer_app/providers/cart_provider.dart';
import 'package:servicemen_customer_app/providers/dashboard_provider.dart';
import 'package:servicemen_customer_app/views/address/address_list_screen.dart';
import 'package:servicemen_customer_app/views/auth/otp_verification_screen.dart';
import 'package:servicemen_customer_app/views/auth/profile_information_screen.dart';
import 'package:servicemen_customer_app/views/auth/splash_screen.dart';
import 'package:servicemen_customer_app/views/bookings/booking_details_screen.dart';
import 'package:servicemen_customer_app/views/bookings/booking_screen.dart';
import 'package:servicemen_customer_app/views/dashboard/cart_screen.dart';
import 'package:servicemen_customer_app/views/dashboard/home_screen.dart';
import 'package:servicemen_customer_app/views/dashboard/order_summary_screen.dart';
import 'package:servicemen_customer_app/views/account/language_selection_screen.dart';
import 'package:servicemen_customer_app/views/notifications/notification_screen.dart';

import '../providers/onboarding_provider.dart';
import '../views/address/choose_address_screen.dart';
import '../views/auth/login_screen.dart';
import '../views/auth/onboarding_screen.dart';
import '../views/dashboard/services_product_list_screen.dart';

class AppRoutes {
  static const String splash = '/Splash';
  static const String onBoarding = '/onBoarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String otpVerification = '/otpVerification';
  static const String profileInformation = '/profileInformation';
  static const String chooseAddress = '/chooseAddress';
  static const String serviceProductsList = '/serviceProductsList';
  static const String orderSummary = '/orderSummary';
  static const String addressList = '/addressList';
  static const String cart = '/cart';
  static const String booking = '/booking';
  static const String bookingDetails = '/bookingDetails';
  static const String languageSelection = '/languageSelection';
  static const String notifications = '/notifications';

  static String initialRoute() {
    return splash;
  }

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onBoarding:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider(
            create: (_) => OnboardingProvider(),
            child: const OnboardingScreen(),
          ),
        );

      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case otpVerification:
        return MaterialPageRoute(builder: (_) => const OtpVerificationScreen());

      case profileInformation:
        return MaterialPageRoute(
          builder: (_) =>  ProfileInformationScreen(),
        );
      case chooseAddress:
        return MaterialPageRoute(builder: (_) => const ChooseAddressScreen());
      case home:
        return MaterialPageRoute(
          builder: (_) => MultiProvider(
            providers: [
               ChangeNotifierProvider(create: (_) => BookingProvider()),
            ],
            child: const HomeScreen(),
          ),
        );
      case serviceProductsList:
        final dashboardProvider = settings.arguments as DashboardProvider;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: dashboardProvider,
            child: const ServicesProductListScreen(),
          ),
        );
      case orderSummary:
        return MaterialPageRoute(builder: (_) => OrderSummaryScreen());
      case addressList:
        return MaterialPageRoute(builder: (_) => AddressListScreen());
      case cart:
        return MaterialPageRoute(builder: (_) => CartScreen());
      case bookingDetails:
        return MaterialPageRoute(builder: (_) => BookingDetailsScreen());
      case languageSelection:
        return MaterialPageRoute(builder: (_) => const LanguageSelectionScreen());
      case notifications:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
