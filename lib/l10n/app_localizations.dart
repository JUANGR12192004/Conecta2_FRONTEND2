import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';

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
    Locale('es', 'CO'),
    Locale('pt', 'BR'),
    Locale('en', 'US'),
    Locale('fr', 'FR'),
    Locale('de', 'DE'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('pt')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Workify'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en_US, this message translates to:
  /// **'Welcome to Workify'**
  String get welcome;

  /// No description provided for @subtitle.
  ///
  /// In en_US, this message translates to:
  /// **'Choose your role to continue'**
  String get subtitle;

  /// No description provided for @roleHint.
  ///
  /// In en_US, this message translates to:
  /// **'Pick Worker or Client to proceed'**
  String get roleHint;

  /// No description provided for @workerButton.
  ///
  /// In en_US, this message translates to:
  /// **'I\'m a Worker'**
  String get workerButton;

  /// No description provided for @clientButton.
  ///
  /// In en_US, this message translates to:
  /// **'I\'m a Client'**
  String get clientButton;

  /// No description provided for @selectCountry.
  ///
  /// In en_US, this message translates to:
  /// **'Select a country'**
  String get selectCountry;

  /// No description provided for @currencyLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Current currency'**
  String get currencyLabel;

  /// No description provided for @dateLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Local date'**
  String get dateLabel;

  /// No description provided for @countryLabel.
  ///
  /// In en_US, this message translates to:
  /// **'{emoji} {name}'**
  String countryLabel(Object emoji, Object name);

  /// No description provided for @loginTitleWorker.
  ///
  /// In en_US, this message translates to:
  /// **'Sign in as Worker'**
  String get loginTitleWorker;

  /// No description provided for @loginTitleClient.
  ///
  /// In en_US, this message translates to:
  /// **'Sign in as Client'**
  String get loginTitleClient;

  /// No description provided for @loginDescription.
  ///
  /// In en_US, this message translates to:
  /// **'Connect with verified trades, pay securely and track your service in real time.'**
  String get loginDescription;

  /// No description provided for @loginFeaturePayments.
  ///
  /// In en_US, this message translates to:
  /// **'Secure payments'**
  String get loginFeaturePayments;

  /// No description provided for @loginFeatureIdentity.
  ///
  /// In en_US, this message translates to:
  /// **'Verified identity'**
  String get loginFeatureIdentity;

  /// No description provided for @loginFeatureSupport.
  ///
  /// In en_US, this message translates to:
  /// **'Support and security'**
  String get loginFeatureSupport;

  /// No description provided for @accessTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Secure access'**
  String get accessTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailEmptyError.
  ///
  /// In en_US, this message translates to:
  /// **'Enter your email'**
  String get emailEmptyError;

  /// No description provided for @emailInvalidError.
  ///
  /// In en_US, this message translates to:
  /// **'Invalid email'**
  String get emailInvalidError;

  /// No description provided for @passwordLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordEmptyError.
  ///
  /// In en_US, this message translates to:
  /// **'Enter your password'**
  String get passwordEmptyError;

  /// No description provided for @forgotPassword.
  ///
  /// In en_US, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en_US, this message translates to:
  /// **'Sign in'**
  String get loginButton;

  /// No description provided for @registerPrompt.
  ///
  /// In en_US, this message translates to:
  /// **'Don\'t have an account? Register here'**
  String get registerPrompt;

  /// No description provided for @backHome.
  ///
  /// In en_US, this message translates to:
  /// **'⬅️ Return to home'**
  String get backHome;

  /// No description provided for @unverifiedAccountMessage.
  ///
  /// In en_US, this message translates to:
  /// **'Your account is not verified. Check your email and activate it to sign in.'**
  String get unverifiedAccountMessage;

  /// No description provided for @understood.
  ///
  /// In en_US, this message translates to:
  /// **'Understood'**
  String get understood;

  /// No description provided for @errorMessage.
  ///
  /// In en_US, this message translates to:
  /// **'Error: {message}'**
  String errorMessage(Object message);

  /// No description provided for @welcomeUser.
  ///
  /// In en_US, this message translates to:
  /// **'Welcome {name}'**
  String welcomeUser(Object name);

  /// No description provided for @registerTitleClient.
  ///
  /// In en_US, this message translates to:
  /// **'Create your account'**
  String get registerTitleClient;

  /// No description provided for @registerSubtitleClient.
  ///
  /// In en_US, this message translates to:
  /// **'Connect with trustworthy workers and pay securely.'**
  String get registerSubtitleClient;

  /// No description provided for @verifiedIdentity.
  ///
  /// In en_US, this message translates to:
  /// **'Verified identity'**
  String get verifiedIdentity;

  /// No description provided for @registerTagProtected.
  ///
  /// In en_US, this message translates to:
  /// **'Protected payments'**
  String get registerTagProtected;

  /// No description provided for @registerTagSupport.
  ///
  /// In en_US, this message translates to:
  /// **'24/7 support'**
  String get registerTagSupport;

  /// No description provided for @registerTagVerified.
  ///
  /// In en_US, this message translates to:
  /// **'Verified services'**
  String get registerTagVerified;

  /// No description provided for @personalDataTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Personal information'**
  String get personalDataTitle;

  /// No description provided for @nameLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Full name'**
  String get nameLabel;

  /// No description provided for @nameMinError.
  ///
  /// In en_US, this message translates to:
  /// **'Enter your name (minimum 3 characters)'**
  String get nameMinError;

  /// No description provided for @phoneLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Phone'**
  String get phoneLabel;

  /// No description provided for @phoneEmptyError.
  ///
  /// In en_US, this message translates to:
  /// **'Enter your phone number'**
  String get phoneEmptyError;

  /// No description provided for @phoneInvalidError.
  ///
  /// In en_US, this message translates to:
  /// **'Invalid number'**
  String get phoneInvalidError;

  /// No description provided for @passwordMinError.
  ///
  /// In en_US, this message translates to:
  /// **'Minimum 6 characters'**
  String get passwordMinError;

  /// No description provided for @confirmPasswordLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Confirm password'**
  String get confirmPasswordLabel;

  /// No description provided for @confirmPasswordError.
  ///
  /// In en_US, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordError;

  /// No description provided for @termsAgreement.
  ///
  /// In en_US, this message translates to:
  /// **'I accept the terms and conditions and the privacy policy.'**
  String get termsAgreement;

  /// No description provided for @termsError.
  ///
  /// In en_US, this message translates to:
  /// **'You must accept the terms and conditions.'**
  String get termsError;

  /// No description provided for @passwordsMismatch.
  ///
  /// In en_US, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsMismatch;

  /// No description provided for @createAccountButton.
  ///
  /// In en_US, this message translates to:
  /// **'Create account'**
  String get createAccountButton;

  /// No description provided for @registrationReceived.
  ///
  /// In en_US, this message translates to:
  /// **'Registration received. Check your email to activate the account.'**
  String get registrationReceived;

  /// No description provided for @unknownError.
  ///
  /// In en_US, this message translates to:
  /// **'Unknown error: please try again.'**
  String get unknownError;

  /// No description provided for @connectionError.
  ///
  /// In en_US, this message translates to:
  /// **'Connection error: {message}'**
  String connectionError(Object message);

  /// No description provided for @registerTitleWorker.
  ///
  /// In en_US, this message translates to:
  /// **'Worker registration'**
  String get registerTitleWorker;

  /// No description provided for @registerSubtitleWorker.
  ///
  /// In en_US, this message translates to:
  /// **'List your services, set your availability and connect with clients.'**
  String get registerSubtitleWorker;

  /// No description provided for @serviceCategoryLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Category *'**
  String get serviceCategoryLabel;

  /// No description provided for @categoriesLoading.
  ///
  /// In en_US, this message translates to:
  /// **'Loading categories...'**
  String get categoriesLoading;

  /// No description provided for @categoriesUnavailable.
  ///
  /// In en_US, this message translates to:
  /// **'No categories available'**
  String get categoriesUnavailable;

  /// No description provided for @selectCategoryPrompt.
  ///
  /// In en_US, this message translates to:
  /// **'Select a category'**
  String get selectCategoryPrompt;

  /// No description provided for @categoryInvalid.
  ///
  /// In en_US, this message translates to:
  /// **'Selected category is invalid'**
  String get categoryInvalid;

  /// No description provided for @registerButtonWorker.
  ///
  /// In en_US, this message translates to:
  /// **'Register'**
  String get registerButtonWorker;

  /// No description provided for @cancelButton.
  ///
  /// In en_US, this message translates to:
  /// **'Cancel'**
  String get cancelButton;

  /// No description provided for @haveAccountCarryOn.
  ///
  /// In en_US, this message translates to:
  /// **'Already have an account? '**
  String get haveAccountCarryOn;

  /// No description provided for @loginHere.
  ///
  /// In en_US, this message translates to:
  /// **'Sign in'**
  String get loginHere;

  /// No description provided for @categoriesFallback.
  ///
  /// In en_US, this message translates to:
  /// **'Categories loaded locally. Details: {message}'**
  String categoriesFallback(Object message);

  /// No description provided for @categoriesLocalFallback.
  ///
  /// In en_US, this message translates to:
  /// **'Could not load categories from the server. Local values were used.'**
  String get categoriesLocalFallback;

  /// No description provided for @categoriesError.
  ///
  /// In en_US, this message translates to:
  /// **'Could not load categories: {message}'**
  String categoriesError(Object message);

  /// No description provided for @publishServiceTooltip.
  ///
  /// In en_US, this message translates to:
  /// **'Publish service'**
  String get publishServiceTooltip;

  /// No description provided for @notificationsTooltip.
  ///
  /// In en_US, this message translates to:
  /// **'Notifications'**
  String get notificationsTooltip;

  /// No description provided for @refreshTooltip.
  ///
  /// In en_US, this message translates to:
  /// **'Refresh'**
  String get refreshTooltip;

  /// No description provided for @optionsTooltip.
  ///
  /// In en_US, this message translates to:
  /// **'Options'**
  String get optionsTooltip;

  /// No description provided for @viewMapLabel.
  ///
  /// In en_US, this message translates to:
  /// **'View map'**
  String get viewMapLabel;

  /// No description provided for @viewButton.
  ///
  /// In en_US, this message translates to:
  /// **'View'**
  String get viewButton;

  /// No description provided for @expiredServicesTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Expired requests'**
  String get expiredServicesTitle;

  /// No description provided for @noExpiredServices.
  ///
  /// In en_US, this message translates to:
  /// **'No expired requests.'**
  String get noExpiredServices;

  /// No description provided for @expiredServiceSingle.
  ///
  /// In en_US, this message translates to:
  /// **'1 request expired and was hidden from the list.'**
  String get expiredServiceSingle;

  /// No description provided for @expiredServiceMultiple.
  ///
  /// In en_US, this message translates to:
  /// **'{count} requests expired and were hidden from the list.'**
  String expiredServiceMultiple(Object count);

  /// No description provided for @expiredServiceDateLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Expired on {date}'**
  String expiredServiceDateLabel(Object date);

  /// No description provided for @dateUnavailable.
  ///
  /// In en_US, this message translates to:
  /// **'Date unavailable'**
  String get dateUnavailable;

  /// No description provided for @serviceLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Service: {title}'**
  String serviceLabel(Object title);

  /// No description provided for @serviceDateLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Date: {date}'**
  String serviceDateLabel(Object date);

  /// No description provided for @serviceStateLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Status: {status}'**
  String serviceStateLabel(Object status);

  /// No description provided for @serviceTurnLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Turn: {turn}'**
  String serviceTurnLabel(Object turn);

  /// No description provided for @lastOfferLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Last offer: {actor}'**
  String lastOfferLabel(Object actor);

  /// No description provided for @currentAmountLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Current amount: {amount}'**
  String currentAmountLabel(Object amount);

  /// No description provided for @workerProposalLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Worker proposal: {amount}'**
  String workerProposalLabel(Object amount);

  /// No description provided for @clientOfferLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Your offer: {amount}'**
  String clientOfferLabel(Object amount);

  /// No description provided for @notificationsTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @pendingPaymentsSection.
  ///
  /// In en_US, this message translates to:
  /// **'Pending payments'**
  String get pendingPaymentsSection;

  /// No description provided for @offersInNegotiationSection.
  ///
  /// In en_US, this message translates to:
  /// **'Offers in negotiation'**
  String get offersInNegotiationSection;

  /// No description provided for @noNewOffers.
  ///
  /// In en_US, this message translates to:
  /// **'You have no new offers.'**
  String get noNewOffers;

  /// No description provided for @offerAcceptedMessage.
  ///
  /// In en_US, this message translates to:
  /// **'Offer accepted. Complete payment to assign the service.'**
  String get offerAcceptedMessage;

  /// No description provided for @serviceAssignedMessage.
  ///
  /// In en_US, this message translates to:
  /// **'Service assigned'**
  String get serviceAssignedMessage;

  /// No description provided for @offerRejectedMessage.
  ///
  /// In en_US, this message translates to:
  /// **'Offer rejected'**
  String get offerRejectedMessage;

  /// No description provided for @counterofferTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Send counteroffer'**
  String get counterofferTitle;

  /// No description provided for @counterofferPriceLabel.
  ///
  /// In en_US, this message translates to:
  /// **'New price'**
  String get counterofferPriceLabel;

  /// No description provided for @counterofferNoteLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Message (optional)'**
  String get counterofferNoteLabel;

  /// No description provided for @enterValidAmount.
  ///
  /// In en_US, this message translates to:
  /// **'Enter a valid amount'**
  String get enterValidAmount;

  /// No description provided for @sendButton.
  ///
  /// In en_US, this message translates to:
  /// **'Send'**
  String get sendButton;

  /// No description provided for @counterofferSent.
  ///
  /// In en_US, this message translates to:
  /// **'Counteroffer sent'**
  String get counterofferSent;

  /// No description provided for @acceptTooltip.
  ///
  /// In en_US, this message translates to:
  /// **'Accept'**
  String get acceptTooltip;

  /// No description provided for @rejectTooltip.
  ///
  /// In en_US, this message translates to:
  /// **'Reject'**
  String get rejectTooltip;

  /// No description provided for @counterofferTooltip.
  ///
  /// In en_US, this message translates to:
  /// **'Counteroffer'**
  String get counterofferTooltip;

  /// No description provided for @workerOfferLabel.
  ///
  /// In en_US, this message translates to:
  /// **'{worker} offered'**
  String workerOfferLabel(Object worker);

  /// No description provided for @serviceUpdatedMessage.
  ///
  /// In en_US, this message translates to:
  /// **'Service updated'**
  String get serviceUpdatedMessage;

  /// No description provided for @paymentStatusLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Payment status: {status}'**
  String paymentStatusLabel(Object status);

  /// No description provided for @paymentPendingTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Pending payment'**
  String get paymentPendingTitle;

  /// No description provided for @awaitingClientPayment.
  ///
  /// In en_US, this message translates to:
  /// **'Waiting for the client to start the payment for this service.'**
  String get awaitingClientPayment;

  /// No description provided for @proceedToPayment.
  ///
  /// In en_US, this message translates to:
  /// **'Proceed to payment'**
  String get proceedToPayment;

  /// No description provided for @updateStatus.
  ///
  /// In en_US, this message translates to:
  /// **'Update status'**
  String get updateStatus;

  /// No description provided for @paymentRetryInfo.
  ///
  /// In en_US, this message translates to:
  /// **'Your last attempt was rejected. You can retry so the worker can start.'**
  String get paymentRetryInfo;

  /// No description provided for @paymentContinueInfo.
  ///
  /// In en_US, this message translates to:
  /// **'Complete the payment to confirm the worker assignment.'**
  String get paymentContinueInfo;

  /// No description provided for @paymentSyncInfo.
  ///
  /// In en_US, this message translates to:
  /// **'We are syncing the payment info. If you already paid, use the update button in notifications.'**
  String get paymentSyncInfo;

  /// No description provided for @servicePublishedMessage.
  ///
  /// In en_US, this message translates to:
  /// **'Service published successfully'**
  String get servicePublishedMessage;

  /// No description provided for @deleteServiceTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Delete service'**
  String get deleteServiceTitle;

  /// No description provided for @deleteServiceConfirmation.
  ///
  /// In en_US, this message translates to:
  /// **'Are you sure you want to delete this listing?'**
  String get deleteServiceConfirmation;

  /// No description provided for @deleteButton.
  ///
  /// In en_US, this message translates to:
  /// **'Delete'**
  String get deleteButton;

  /// No description provided for @serviceDefaultTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Service'**
  String get serviceDefaultTitle;

  /// No description provided for @myAccount.
  ///
  /// In en_US, this message translates to:
  /// **'My account'**
  String get myAccount;

  /// No description provided for @serviceFormPublishTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Service publication'**
  String get serviceFormPublishTitle;

  /// No description provided for @serviceFormEditTitle.
  ///
  /// In en_US, this message translates to:
  /// **'Edit service'**
  String get serviceFormEditTitle;

  /// No description provided for @serviceTitleLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Title *'**
  String get serviceTitleLabel;

  /// No description provided for @serviceDescriptionLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Description *'**
  String get serviceDescriptionLabel;

  /// No description provided for @serviceLocationLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Location *'**
  String get serviceLocationLabel;

  /// No description provided for @serviceEstimatedDateLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Estimated date *'**
  String get serviceEstimatedDateLabel;

  /// No description provided for @selectDatePrompt.
  ///
  /// In en_US, this message translates to:
  /// **'Select a date'**
  String get selectDatePrompt;

  /// No description provided for @datePickerHelp.
  ///
  /// In en_US, this message translates to:
  /// **'Select estimated date'**
  String get datePickerHelp;

  /// No description provided for @titleRequiredError.
  ///
  /// In en_US, this message translates to:
  /// **'Title must not be empty'**
  String get titleRequiredError;

  /// No description provided for @descriptionRequiredError.
  ///
  /// In en_US, this message translates to:
  /// **'Description must not be empty'**
  String get descriptionRequiredError;

  /// No description provided for @categoryRequiredError.
  ///
  /// In en_US, this message translates to:
  /// **'Select a category'**
  String get categoryRequiredError;

  /// No description provided for @locationRequiredError.
  ///
  /// In en_US, this message translates to:
  /// **'Location is required'**
  String get locationRequiredError;

  /// No description provided for @dateInPastError.
  ///
  /// In en_US, this message translates to:
  /// **'The date cannot be before today'**
  String get dateInPastError;

  /// No description provided for @invalidCategoryError.
  ///
  /// In en_US, this message translates to:
  /// **'Invalid category'**
  String get invalidCategoryError;

  /// No description provided for @requiredFieldsNote.
  ///
  /// In en_US, this message translates to:
  /// **'* Required fields'**
  String get requiredFieldsNote;

  /// No description provided for @saveButton.
  ///
  /// In en_US, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @clientLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Client'**
  String get clientLabel;

  /// No description provided for @workerLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Worker'**
  String get workerLabel;

  /// No description provided for @negotiationInNegotiation.
  ///
  /// In en_US, this message translates to:
  /// **'In negotiation'**
  String get negotiationInNegotiation;

  /// No description provided for @negotiationInProgress.
  ///
  /// In en_US, this message translates to:
  /// **'In progress'**
  String get negotiationInProgress;

  /// No description provided for @negotiationAccepted.
  ///
  /// In en_US, this message translates to:
  /// **'Accepted'**
  String get negotiationAccepted;

  /// No description provided for @negotiationRejected.
  ///
  /// In en_US, this message translates to:
  /// **'Rejected'**
  String get negotiationRejected;

  /// No description provided for @negotiationClosed.
  ///
  /// In en_US, this message translates to:
  /// **'Closed'**
  String get negotiationClosed;

  /// No description provided for @negotiationPending.
  ///
  /// In en_US, this message translates to:
  /// **'Pending'**
  String get negotiationPending;

  /// No description provided for @serviceStatePending.
  ///
  /// In en_US, this message translates to:
  /// **'Pending'**
  String get serviceStatePending;

  /// No description provided for @serviceStatePaymentPending.
  ///
  /// In en_US, this message translates to:
  /// **'Payment pending'**
  String get serviceStatePaymentPending;

  /// No description provided for @serviceStateInProgress.
  ///
  /// In en_US, this message translates to:
  /// **'In progress'**
  String get serviceStateInProgress;

  /// No description provided for @serviceStateFinished.
  ///
  /// In en_US, this message translates to:
  /// **'Finished'**
  String get serviceStateFinished;

  /// No description provided for @serviceStateExpired.
  ///
  /// In en_US, this message translates to:
  /// **'Expired'**
  String get serviceStateExpired;

  /// No description provided for @paymentStatusPending.
  ///
  /// In en_US, this message translates to:
  /// **'Pending payment'**
  String get paymentStatusPending;

  /// No description provided for @paymentStatusRequiresPaymentMethod.
  ///
  /// In en_US, this message translates to:
  /// **'Requires another method'**
  String get paymentStatusRequiresPaymentMethod;

  /// No description provided for @paymentStatusRequiresAction.
  ///
  /// In en_US, this message translates to:
  /// **'Action required'**
  String get paymentStatusRequiresAction;

  /// No description provided for @paymentStatusSucceeded.
  ///
  /// In en_US, this message translates to:
  /// **'Payment confirmed'**
  String get paymentStatusSucceeded;

  /// No description provided for @paymentStatusFailed.
  ///
  /// In en_US, this message translates to:
  /// **'Payment failed'**
  String get paymentStatusFailed;

  /// No description provided for @paymentStatusNotRequired.
  ///
  /// In en_US, this message translates to:
  /// **'Not required'**
  String get paymentStatusNotRequired;

  /// No description provided for @paymentStatusDefault.
  ///
  /// In en_US, this message translates to:
  /// **'Payment'**
  String get paymentStatusDefault;

  /// No description provided for @manageAccountLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Manage account'**
  String get manageAccountLabel;

  /// No description provided for @logoutLabel.
  ///
  /// In en_US, this message translates to:
  /// **'Log out'**
  String get logoutLabel;

  /// No description provided for @closeTooltip.
  ///
  /// In en_US, this message translates to:
  /// **'Close'**
  String get closeTooltip;

  /// No description provided for @profileGreeting.
  ///
  /// In en_US, this message translates to:
  /// **'Hello!'**
  String get profileGreeting;

  /// No description provided for @profileGreetingWithName.
  ///
  /// In en_US, this message translates to:
  /// **'Hello, {name}!'**
  String profileGreetingWithName(Object name);

  /// No description provided for @serviceExpirationWarning.
  ///
  /// In en_US, this message translates to:
  /// **'Attention: the service \"{title}\" expires today and will be automatically removed at midnight if still pending.'**
  String serviceExpirationWarning(Object title);

  /// No description provided for @serviceDeletedMessage.
  ///
  /// In en_US, this message translates to:
  /// **'Service deleted'**
  String get serviceDeletedMessage;

  /// No description provided for @serviceDeleteBlockedMessage.
  ///
  /// In en_US, this message translates to:
  /// **'Cannot delete an accepted service.'**
  String get serviceDeleteBlockedMessage;
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
      <String>['de', 'en', 'es', 'fr', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'de':
      {
        switch (locale.countryCode) {
          case 'DE':
            return AppLocalizationsDeDe();
        }
        break;
      }
    case 'en':
      {
        switch (locale.countryCode) {
          case 'US':
            return AppLocalizationsEnUs();
        }
        break;
      }
    case 'es':
      {
        switch (locale.countryCode) {
          case 'CO':
            return AppLocalizationsEsCo();
        }
        break;
      }
    case 'fr':
      {
        switch (locale.countryCode) {
          case 'FR':
            return AppLocalizationsFrFr();
        }
        break;
      }
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
