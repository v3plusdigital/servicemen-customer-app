import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:servicemen_customer_app/providers/auth_provider.dart';
import 'package:servicemen_customer_app/providers/cart_provider.dart';
import 'package:servicemen_customer_app/providers/dashboard_provider.dart';
import 'package:servicemen_customer_app/providers/locale_provider.dart';
import 'package:servicemen_customer_app/providers/location_provider.dart';
import 'package:servicemen_customer_app/services/api/api_client.dart';
import 'package:servicemen_customer_app/services/local_data/shared_pref.dart';
import 'package:servicemen_customer_app/utils/app_colors.dart';
import 'package:servicemen_customer_app/utils/app_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:servicemen_customer_app/utils/app_routes.dart';
import 'package:servicemen_customer_app/utils/l10n/app_localizations.dart';
import 'package:servicemen_customer_app/utils/navigation_service.dart';


void main() async{
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();
    return MultiProvider(
       providers: [
         Provider(create: (_) => ApiClient()),
         Provider(create: (_) => SharedPrefService()),
         ChangeNotifierProvider(create: (_) => AuthProvider()),
         ChangeNotifierProvider(create: (_) => LocaleProvider()..initializeLocale()),
         ChangeNotifierProvider(create: (_) => LocationProvider()),
         ChangeNotifierProvider(create: (_) => CartProvider()),
         ChangeNotifierProvider(create: (_) => DashboardProvider()),

       ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            navigatorObservers: [
              BotToastNavigatorObserver(),
            ],
            navigatorKey: NavigationService.navigatorKey,
            theme: ThemeData(
                useMaterial3: true,
                scaffoldBackgroundColor: AppColors.kWhite,
                fontFamily: AppFonts.generalSans),
            locale: localeProvider.locale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            initialRoute: AppRoutes.initialRoute(),
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}


