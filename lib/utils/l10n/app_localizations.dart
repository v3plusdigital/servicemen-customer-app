import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('gu'),
    Locale('hi'),
  ];

  /// No description provided for @fastReliableHomeApplianceServices.
  ///
  /// In en, this message translates to:
  /// **'Fast & Reliable Home Appliance Services'**
  String get fastReliableHomeApplianceServices;

  /// No description provided for @allHomeServicesInOneApp.
  ///
  /// In en, this message translates to:
  /// **'All Home Services in One App'**
  String get allHomeServicesInOneApp;

  /// No description provided for @acTvFridgeWashingMachineMore.
  ///
  /// In en, this message translates to:
  /// **'AC, TV, fridge, washing machine & more. Book any service in seconds.'**
  String get acTvFridgeWashingMachineMore;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @fastBookingQuickInvoices.
  ///
  /// In en, this message translates to:
  /// **'Fast Booking, Quick Invoices'**
  String get fastBookingQuickInvoices;

  /// No description provided for @enjoyASmoothBookingExperienceWithEasyInvoiceDownloads.
  ///
  /// In en, this message translates to:
  /// **'Enjoy a smooth booking experience with easy invoice downloads.'**
  String get enjoyASmoothBookingExperienceWithEasyInvoiceDownloads;

  /// No description provided for @verifiedSkilledTechnicians.
  ///
  /// In en, this message translates to:
  /// **'Verified & Skilled Technicians'**
  String get verifiedSkilledTechnicians;

  /// No description provided for @professionalsWithRatingsReviewsAndServiceHistory.
  ///
  /// In en, this message translates to:
  /// **'Professionals with ratings, reviews and service history.'**
  String get professionalsWithRatingsReviewsAndServiceHistory;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @orLogInWith.
  ///
  /// In en, this message translates to:
  /// **'Or Log in with'**
  String get orLogInWith;

  /// No description provided for @yourHomeServiceExperienceStartsHereLogInEasilyWithYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Your home service experience starts here.\nLog in easily with your mobile number'**
  String get yourHomeServiceExperienceStartsHereLogInEasilyWithYourMobileNumber;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @logIn.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get logIn;

  /// No description provided for @byLoggingInYouAgreeToOur.
  ///
  /// In en, this message translates to:
  /// **'By logging in, you agree to our'**
  String get byLoggingInYouAgreeToOur;

  /// No description provided for @refundPolicy.
  ///
  /// In en, this message translates to:
  /// **'Refund policy'**
  String get refundPolicy;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @enter6DigitCode.
  ///
  /// In en, this message translates to:
  /// **'Enter 6 digit code'**
  String get enter6DigitCode;

  /// No description provided for @weSentAVerificationCodeToYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'We sent a verification code to your phone number'**
  String get weSentAVerificationCodeToYourPhoneNumber;

  /// No description provided for @youDidntReceivedAnyCode.
  ///
  /// In en, this message translates to:
  /// **'You didn’t received any code?'**
  String get youDidntReceivedAnyCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @profileSetup.
  ///
  /// In en, this message translates to:
  /// **'Profile Setup'**
  String get profileSetup;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @enterYourNameHere.
  ///
  /// In en, this message translates to:
  /// **'Enter your name here'**
  String get enterYourNameHere;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enterYourEmailHere.
  ///
  /// In en, this message translates to:
  /// **'Enter your email here'**
  String get enterYourEmailHere;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @continueStr.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueStr;

  /// No description provided for @useMyCurrentLocation.
  ///
  /// In en, this message translates to:
  /// **'Use My Current Location'**
  String get useMyCurrentLocation;

  /// No description provided for @addManually.
  ///
  /// In en, this message translates to:
  /// **'Add Manually'**
  String get addManually;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// No description provided for @houseFlatNo.
  ///
  /// In en, this message translates to:
  /// **'House No'**
  String get houseFlatNo;

  /// No description provided for @buildingSocietyName.
  ///
  /// In en, this message translates to:
  /// **'Building / Society Name'**
  String get buildingSocietyName;

  /// No description provided for @houseNo.
  ///
  /// In en, this message translates to:
  /// **'House no'**
  String get houseNo;

  /// No description provided for @enterYourBuildingName.
  ///
  /// In en, this message translates to:
  /// **'Enter your building name'**
  String get enterYourBuildingName;

  /// No description provided for @landmark.
  ///
  /// In en, this message translates to:
  /// **'Landmark (optional)'**
  String get landmark;

  /// No description provided for @enterANearbyLandmark.
  ///
  /// In en, this message translates to:
  /// **'Enter a nearby landmark'**
  String get enterANearbyLandmark;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @pincode.
  ///
  /// In en, this message translates to:
  /// **'Pincode'**
  String get pincode;

  /// No description provided for @enterYourPincode.
  ///
  /// In en, this message translates to:
  /// **'Enter your pincode'**
  String get enterYourPincode;

  /// No description provided for @addressType.
  ///
  /// In en, this message translates to:
  /// **'Address Type'**
  String get addressType;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @office.
  ///
  /// In en, this message translates to:
  /// **'Office'**
  String get office;

  /// No description provided for @saveContinue.
  ///
  /// In en, this message translates to:
  /// **'Save & Continue'**
  String get saveContinue;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @repairServices.
  ///
  /// In en, this message translates to:
  /// **'Repair & Services'**
  String get repairServices;

  /// No description provided for @videosPhotos.
  ///
  /// In en, this message translates to:
  /// **'Videos & Photos'**
  String get videosPhotos;

  /// No description provided for @whyChooseServicemen.
  ///
  /// In en, this message translates to:
  /// **'Why Choose Servicemen?'**
  String get whyChooseServicemen;

  /// No description provided for @expertVerifiedTechnicians.
  ///
  /// In en, this message translates to:
  /// **'Expert & Verified\nTechnicians'**
  String get expertVerifiedTechnicians;

  /// No description provided for @quickEasyBooking.
  ///
  /// In en, this message translates to:
  /// **'Quick &\nEasy Booking'**
  String get quickEasyBooking;

  /// No description provided for @affordableTransparentPricing.
  ///
  /// In en, this message translates to:
  /// **'Affordable &\nTransparent Pricing'**
  String get affordableTransparentPricing;

  /// No description provided for @onTimeServiceGuarantee.
  ///
  /// In en, this message translates to:
  /// **'On-Time Service\nGuarantee'**
  String get onTimeServiceGuarantee;

  /// No description provided for @booking.
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get booking;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @viewDetails.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @serviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Service Info'**
  String get serviceInfo;

  /// No description provided for @serviceDetails.
  ///
  /// In en, this message translates to:
  /// **'Service Details'**
  String get serviceDetails;

  /// No description provided for @totalPayment.
  ///
  /// In en, this message translates to:
  /// **'Total Payment'**
  String get totalPayment;

  /// No description provided for @proceedToOrder.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Order'**
  String get proceedToOrder;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @paymentSummary.
  ///
  /// In en, this message translates to:
  /// **'Payment Summary'**
  String get paymentSummary;

  /// No description provided for @addProblemDescriptions.
  ///
  /// In en, this message translates to:
  /// **'Add Problem Descriptions'**
  String get addProblemDescriptions;

  /// No description provided for @writeYourNote.
  ///
  /// In en, this message translates to:
  /// **'Write your note...'**
  String get writeYourNote;

  /// No description provided for @serviceLocation.
  ///
  /// In en, this message translates to:
  /// **'Service Location'**
  String get serviceLocation;

  /// No description provided for @changeLocation.
  ///
  /// In en, this message translates to:
  /// **'Change Location'**
  String get changeLocation;

  /// No description provided for @yourTechnicianArrival.
  ///
  /// In en, this message translates to:
  /// **'Your Technician’s Arrival'**
  String get yourTechnicianArrival;

  /// No description provided for @selectSlot.
  ///
  /// In en, this message translates to:
  /// **'Select slot'**
  String get selectSlot;

  /// No description provided for @am.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// No description provided for @proceedToPayment.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Payment'**
  String get proceedToPayment;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @changeAddress.
  ///
  /// In en, this message translates to:
  /// **'Change Address'**
  String get changeAddress;

  /// No description provided for @doYouWantToUpdateYourLocation.
  ///
  /// In en, this message translates to:
  /// **'Do you want to update your location?'**
  String get doYouWantToUpdateYourLocation;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @pleaseSelectProperAddressDetails.
  ///
  /// In en, this message translates to:
  /// **'Please select proper address details'**
  String get pleaseSelectProperAddressDetails;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @addServices.
  ///
  /// In en, this message translates to:
  /// **'Add Services'**
  String get addServices;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @byCategory.
  ///
  /// In en, this message translates to:
  /// **'By Category'**
  String get byCategory;

  /// No description provided for @byDate.
  ///
  /// In en, this message translates to:
  /// **'By Date'**
  String get byDate;

  /// No description provided for @orderID.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderID;

  /// No description provided for @service.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get service;

  /// No description provided for @slotDate.
  ///
  /// In en, this message translates to:
  /// **'Slot Date'**
  String get slotDate;

  /// No description provided for @slotTime.
  ///
  /// In en, this message translates to:
  /// **'Slot Time'**
  String get slotTime;

  /// No description provided for @cancelBooking.
  ///
  /// In en, this message translates to:
  /// **'Cancel Booking'**
  String get cancelBooking;

  /// No description provided for @modifyBooking.
  ///
  /// In en, this message translates to:
  /// **'Modify Booking'**
  String get modifyBooking;

  /// No description provided for @addRatting.
  ///
  /// In en, this message translates to:
  /// **'Add Ratting'**
  String get addRatting;

  /// No description provided for @downloadInvoice.
  ///
  /// In en, this message translates to:
  /// **'Download Invoice'**
  String get downloadInvoice;

  /// No description provided for @bookingDetails.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @addedProblemDescriptions.
  ///
  /// In en, this message translates to:
  /// **'Added Problem Descriptions'**
  String get addedProblemDescriptions;

  /// No description provided for @trackStatus.
  ///
  /// In en, this message translates to:
  /// **'Track Status'**
  String get trackStatus;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @assigned.
  ///
  /// In en, this message translates to:
  /// **'Assigned'**
  String get assigned;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In-Progress'**
  String get inProgress;

  /// No description provided for @technicianUpdatePendingYourApproval.
  ///
  /// In en, this message translates to:
  /// **'Technician update pending your approval.'**
  String get technicianUpdatePendingYourApproval;

  /// No description provided for @pleaseReviewToProceed.
  ///
  /// In en, this message translates to:
  /// **'Please review to proceed.'**
  String get pleaseReviewToProceed;

  /// No description provided for @technicianUpdate.
  ///
  /// In en, this message translates to:
  /// **'Technician Update'**
  String get technicianUpdate;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @payForAdditionalWorkAmount.
  ///
  /// In en, this message translates to:
  /// **'Pay for additional work amount'**
  String get payForAdditionalWorkAmount;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @addReasonForCancellation.
  ///
  /// In en, this message translates to:
  /// **'Add Reason for Cancellation'**
  String get addReasonForCancellation;

  /// No description provided for @cancelledDate.
  ///
  /// In en, this message translates to:
  /// **'Cancelled Date'**
  String get cancelledDate;

  /// No description provided for @refundAmount.
  ///
  /// In en, this message translates to:
  /// **'Refund Amount'**
  String get refundAmount;

  /// No description provided for @howSatisfiedAreYouWithTheTechnicianService.
  ///
  /// In en, this message translates to:
  /// **'How satisfied are you with the technician’s service?'**
  String get howSatisfiedAreYouWithTheTechnicianService;

  /// No description provided for @rateThisService.
  ///
  /// In en, this message translates to:
  /// **'Rate this service'**
  String get rateThisService;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @technician.
  ///
  /// In en, this message translates to:
  /// **'Technician'**
  String get technician;

  /// No description provided for @areYouSureYouWantToCancelThis.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this'**
  String get areYouSureYouWantToCancelThis;

  /// No description provided for @accordingToOurPolicyYouWillReceiveAn.
  ///
  /// In en, this message translates to:
  /// **'According to our policy, you will receive an'**
  String get accordingToOurPolicyYouWillReceiveAn;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'refund'**
  String get refund;

  /// No description provided for @writeHere.
  ///
  /// In en, this message translates to:
  /// **'Write here...'**
  String get writeHere;

  /// No description provided for @yesCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yesCancel;

  /// No description provided for @accountDetails.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get accountDetails;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @manageAddress.
  ///
  /// In en, this message translates to:
  /// **'Manage Address'**
  String get manageAddress;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @faqs.
  ///
  /// In en, this message translates to:
  /// **'FAQ’s'**
  String get faqs;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @completedDate.
  ///
  /// In en, this message translates to:
  /// **'Completed Date'**
  String get completedDate;

  /// No description provided for @changeDate.
  ///
  /// In en, this message translates to:
  /// **'Change Date'**
  String get changeDate;

  /// No description provided for @addNoteForTechnicians.
  ///
  /// In en, this message translates to:
  /// **'Add Note for Technicians'**
  String get addNoteForTechnicians;

  /// No description provided for @areYouSureYouWantToModifyThis.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to modify this'**
  String get areYouSureYouWantToModifyThis;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'date'**
  String get date;

  /// No description provided for @otherDetails.
  ///
  /// In en, this message translates to:
  /// **'Other Details'**
  String get otherDetails;

  /// No description provided for @areYouSureYouWantToLogOut.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get areYouSureYouWantToLogOut;

  /// No description provided for @areYouSureYouWantToDeleteThisAddress.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this address?'**
  String get areYouSureYouWantToDeleteThisAddress;

  /// No description provided for @deleteAddress.
  ///
  /// In en, this message translates to:
  /// **'Delete Address'**
  String get deleteAddress;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @markAllAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get markAllAsRead;

  /// No description provided for @noNotifications.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet'**
  String get noNotifications;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get addToCart;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'gu', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'gu':
      return AppLocalizationsGu();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
