// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Welcome to Workify';

  @override
  String get subtitle => 'Choose your role to continue';

  @override
  String get roleHint => 'Pick Worker or Client to proceed';

  @override
  String get workerButton => 'I\'m a Worker';

  @override
  String get clientButton => 'I\'m a Client';

  @override
  String get selectCountry => 'Select a country';

  @override
  String get currencyLabel => 'Current currency';

  @override
  String get dateLabel => 'Local date';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Sign in as Worker';

  @override
  String get loginTitleClient => 'Sign in as Client';

  @override
  String get loginDescription =>
      'Connect with verified trades, pay securely and track your service in real time.';

  @override
  String get loginFeaturePayments => 'Secure payments';

  @override
  String get loginFeatureIdentity => 'Verified identity';

  @override
  String get loginFeatureSupport => 'Support and security';

  @override
  String get accessTitle => 'Secure access';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailEmptyError => 'Enter your email';

  @override
  String get emailInvalidError => 'Invalid email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordEmptyError => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get loginButton => 'Sign in';

  @override
  String get registerPrompt => 'Don\'t have an account? Register here';

  @override
  String get backHome => '⬅️ Return to home';

  @override
  String get unverifiedAccountMessage =>
      'Your account is not verified. Check your email and activate it to sign in.';

  @override
  String get understood => 'Understood';

  @override
  String errorMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Welcome $name';
  }

  @override
  String get registerTitleClient => 'Create your account';

  @override
  String get registerSubtitleClient =>
      'Connect with trustworthy workers and pay securely.';

  @override
  String get verifiedIdentity => 'Verified identity';

  @override
  String get registerTagProtected => 'Protected payments';

  @override
  String get registerTagSupport => '24/7 support';

  @override
  String get registerTagVerified => 'Verified services';

  @override
  String get personalDataTitle => 'Personal information';

  @override
  String get nameLabel => 'Full name';

  @override
  String get nameMinError => 'Enter your name (minimum 3 characters)';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get phoneEmptyError => 'Enter your phone number';

  @override
  String get phoneInvalidError => 'Invalid number';

  @override
  String get passwordMinError => 'Minimum 6 characters';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get confirmPasswordError => 'Confirm your password';

  @override
  String get termsAgreement =>
      'I accept the terms and conditions and the privacy policy.';

  @override
  String get termsError => 'You must accept the terms and conditions.';

  @override
  String get passwordsMismatch => 'Passwords do not match.';

  @override
  String get createAccountButton => 'Create account';

  @override
  String get registrationReceived =>
      'Registration received. Check your email to activate the account.';

  @override
  String get unknownError => 'Unknown error: please try again.';

  @override
  String connectionError(Object message) {
    return 'Connection error: $message';
  }

  @override
  String get registerTitleWorker => 'Worker registration';

  @override
  String get registerSubtitleWorker =>
      'List your services, set your availability and connect with clients.';

  @override
  String get serviceCategoryLabel => 'Category *';

  @override
  String get categoriesLoading => 'Loading categories...';

  @override
  String get categoriesUnavailable => 'No categories available';

  @override
  String get selectCategoryPrompt => 'Select a category';

  @override
  String get categoryInvalid => 'Selected category is invalid';

  @override
  String get registerButtonWorker => 'Register';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get haveAccountCarryOn => 'Already have an account? ';

  @override
  String get loginHere => 'Sign in';

  @override
  String categoriesFallback(Object message) {
    return 'Categories loaded locally. Details: $message';
  }

  @override
  String get categoriesLocalFallback =>
      'Could not load categories from the server. Local values were used.';

  @override
  String categoriesError(Object message) {
    return 'Could not load categories: $message';
  }

  @override
  String get publishServiceTooltip => 'Publish service';

  @override
  String get notificationsTooltip => 'Notifications';

  @override
  String get refreshTooltip => 'Refresh';

  @override
  String get optionsTooltip => 'Options';

  @override
  String get viewMapLabel => 'View map';

  @override
  String get viewButton => 'View';

  @override
  String get expiredServicesTitle => 'Expired requests';

  @override
  String get noExpiredServices => 'No expired requests.';

  @override
  String get expiredServiceSingle =>
      '1 request expired and was hidden from the list.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count requests expired and were hidden from the list.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Expired on $date';
  }

  @override
  String get dateUnavailable => 'Date unavailable';

  @override
  String serviceLabel(Object title) {
    return 'Service: $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Date: $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Turn: $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Last offer: $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Current amount: $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Worker proposal: $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Your offer: $amount';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get pendingPaymentsSection => 'Pending payments';

  @override
  String get offersInNegotiationSection => 'Offers in negotiation';

  @override
  String get noNewOffers => 'You have no new offers.';

  @override
  String get offerAcceptedMessage =>
      'Offer accepted. Complete payment to assign the service.';

  @override
  String get serviceAssignedMessage => 'Service assigned';

  @override
  String get offerRejectedMessage => 'Offer rejected';

  @override
  String get counterofferTitle => 'Send counteroffer';

  @override
  String get counterofferPriceLabel => 'New price';

  @override
  String get counterofferNoteLabel => 'Message (optional)';

  @override
  String get enterValidAmount => 'Enter a valid amount';

  @override
  String get sendButton => 'Send';

  @override
  String get counterofferSent => 'Counteroffer sent';

  @override
  String get acceptTooltip => 'Accept';

  @override
  String get rejectTooltip => 'Reject';

  @override
  String get counterofferTooltip => 'Counteroffer';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker offered';
  }

  @override
  String get serviceUpdatedMessage => 'Service updated';

  @override
  String paymentStatusLabel(Object status) {
    return 'Payment status: $status';
  }

  @override
  String get paymentPendingTitle => 'Pending payment';

  @override
  String get awaitingClientPayment =>
      'Waiting for the client to start the payment for this service.';

  @override
  String get proceedToPayment => 'Proceed to payment';

  @override
  String get updateStatus => 'Update status';

  @override
  String get paymentRetryInfo =>
      'Your last attempt was rejected. You can retry so the worker can start.';

  @override
  String get paymentContinueInfo =>
      'Complete the payment to confirm the worker assignment.';

  @override
  String get paymentSyncInfo =>
      'We are syncing the payment info. If you already paid, use the update button in notifications.';

  @override
  String get servicePublishedMessage => 'Service published successfully';

  @override
  String get deleteServiceTitle => 'Delete service';

  @override
  String get deleteServiceConfirmation =>
      'Are you sure you want to delete this listing?';

  @override
  String get deleteButton => 'Delete';

  @override
  String get serviceDefaultTitle => 'Service';

  @override
  String get myAccount => 'My account';

  @override
  String get serviceFormPublishTitle => 'Service publication';

  @override
  String get serviceFormEditTitle => 'Edit service';

  @override
  String get serviceTitleLabel => 'Title *';

  @override
  String get serviceDescriptionLabel => 'Description *';

  @override
  String get serviceLocationLabel => 'Location *';

  @override
  String get serviceEstimatedDateLabel => 'Estimated date *';

  @override
  String get selectDatePrompt => 'Select a date';

  @override
  String get datePickerHelp => 'Select estimated date';

  @override
  String get titleRequiredError => 'Title must not be empty';

  @override
  String get descriptionRequiredError => 'Description must not be empty';

  @override
  String get categoryRequiredError => 'Select a category';

  @override
  String get locationRequiredError => 'Location is required';

  @override
  String get dateInPastError => 'The date cannot be before today';

  @override
  String get invalidCategoryError => 'Invalid category';

  @override
  String get requiredFieldsNote => '* Required fields';

  @override
  String get saveButton => 'Save';

  @override
  String get clientLabel => 'Client';

  @override
  String get workerLabel => 'Worker';

  @override
  String get negotiationInNegotiation => 'In negotiation';

  @override
  String get negotiationInProgress => 'In progress';

  @override
  String get negotiationAccepted => 'Accepted';

  @override
  String get negotiationRejected => 'Rejected';

  @override
  String get negotiationClosed => 'Closed';

  @override
  String get negotiationPending => 'Pending';

  @override
  String get serviceStatePending => 'Pending';

  @override
  String get serviceStatePaymentPending => 'Payment pending';

  @override
  String get serviceStateInProgress => 'In progress';

  @override
  String get serviceStateFinished => 'Finished';

  @override
  String get serviceStateExpired => 'Expired';

  @override
  String get paymentStatusPending => 'Pending payment';

  @override
  String get paymentStatusRequiresPaymentMethod => 'Requires another method';

  @override
  String get paymentStatusRequiresAction => 'Action required';

  @override
  String get paymentStatusSucceeded => 'Payment confirmed';

  @override
  String get paymentStatusFailed => 'Payment failed';

  @override
  String get paymentStatusNotRequired => 'Not required';

  @override
  String get paymentStatusDefault => 'Payment';

  @override
  String get manageAccountLabel => 'Manage account';

  @override
  String get logoutLabel => 'Log out';

  @override
  String get closeTooltip => 'Close';

  @override
  String get profileGreeting => 'Hello!';

  @override
  String profileGreetingWithName(Object name) {
    return 'Hello, $name!';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Attention: the service \"$title\" expires today and will be automatically removed at midnight if still pending.';
  }

  @override
  String get serviceDeletedMessage => 'Service deleted';

  @override
  String get serviceDeleteBlockedMessage =>
      'Cannot delete an accepted service.';
}

/// The translations for English, as used in the United States (`en_US`).
class AppLocalizationsEnUs extends AppLocalizationsEn {
  AppLocalizationsEnUs() : super('en_US');

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Welcome to Workify';

  @override
  String get subtitle => 'Choose your role to continue';

  @override
  String get roleHint => 'Pick Worker or Client to proceed';

  @override
  String get workerButton => 'I\'m a Worker';

  @override
  String get clientButton => 'I\'m a Client';

  @override
  String get selectCountry => 'Select a country';

  @override
  String get currencyLabel => 'Current currency';

  @override
  String get dateLabel => 'Local date';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Sign in as Worker';

  @override
  String get loginTitleClient => 'Sign in as Client';

  @override
  String get loginDescription =>
      'Connect with verified trades, pay securely and track your service in real time.';

  @override
  String get loginFeaturePayments => 'Secure payments';

  @override
  String get loginFeatureIdentity => 'Verified identity';

  @override
  String get loginFeatureSupport => 'Support and security';

  @override
  String get accessTitle => 'Secure access';

  @override
  String get emailLabel => 'Email';

  @override
  String get emailEmptyError => 'Enter your email';

  @override
  String get emailInvalidError => 'Invalid email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get passwordEmptyError => 'Enter your password';

  @override
  String get forgotPassword => 'Forgot your password?';

  @override
  String get loginButton => 'Sign in';

  @override
  String get registerPrompt => 'Don\'t have an account? Register here';

  @override
  String get backHome => '⬅️ Return to home';

  @override
  String get unverifiedAccountMessage =>
      'Your account is not verified. Check your email and activate it to sign in.';

  @override
  String get understood => 'Understood';

  @override
  String errorMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Welcome $name';
  }

  @override
  String get registerTitleClient => 'Create your account';

  @override
  String get registerSubtitleClient =>
      'Connect with trustworthy workers and pay securely.';

  @override
  String get verifiedIdentity => 'Verified identity';

  @override
  String get registerTagProtected => 'Protected payments';

  @override
  String get registerTagSupport => '24/7 support';

  @override
  String get registerTagVerified => 'Verified services';

  @override
  String get personalDataTitle => 'Personal information';

  @override
  String get nameLabel => 'Full name';

  @override
  String get nameMinError => 'Enter your name (minimum 3 characters)';

  @override
  String get phoneLabel => 'Phone';

  @override
  String get phoneEmptyError => 'Enter your phone number';

  @override
  String get phoneInvalidError => 'Invalid number';

  @override
  String get passwordMinError => 'Minimum 6 characters';

  @override
  String get confirmPasswordLabel => 'Confirm password';

  @override
  String get confirmPasswordError => 'Confirm your password';

  @override
  String get termsAgreement =>
      'I accept the terms and conditions and the privacy policy.';

  @override
  String get termsError => 'You must accept the terms and conditions.';

  @override
  String get passwordsMismatch => 'Passwords do not match.';

  @override
  String get createAccountButton => 'Create account';

  @override
  String get registrationReceived =>
      'Registration received. Check your email to activate the account.';

  @override
  String get unknownError => 'Unknown error: please try again.';

  @override
  String connectionError(Object message) {
    return 'Connection error: $message';
  }

  @override
  String get registerTitleWorker => 'Worker registration';

  @override
  String get registerSubtitleWorker =>
      'List your services, set your availability and connect with clients.';

  @override
  String get serviceCategoryLabel => 'Category *';

  @override
  String get categoriesLoading => 'Loading categories...';

  @override
  String get categoriesUnavailable => 'No categories available';

  @override
  String get selectCategoryPrompt => 'Select a category';

  @override
  String get categoryInvalid => 'Selected category is invalid';

  @override
  String get registerButtonWorker => 'Register';

  @override
  String get cancelButton => 'Cancel';

  @override
  String get haveAccountCarryOn => 'Already have an account? ';

  @override
  String get loginHere => 'Sign in';

  @override
  String categoriesFallback(Object message) {
    return 'Categories loaded locally. Details: $message';
  }

  @override
  String get categoriesLocalFallback =>
      'Could not load categories from the server. Local values were used.';

  @override
  String categoriesError(Object message) {
    return 'Could not load categories: $message';
  }

  @override
  String get publishServiceTooltip => 'Publish service';

  @override
  String get notificationsTooltip => 'Notifications';

  @override
  String get refreshTooltip => 'Refresh';

  @override
  String get optionsTooltip => 'Options';

  @override
  String get viewMapLabel => 'View map';

  @override
  String get viewButton => 'View';

  @override
  String get expiredServicesTitle => 'Expired requests';

  @override
  String get noExpiredServices => 'No expired requests.';

  @override
  String get expiredServiceSingle =>
      '1 request expired and was hidden from the list.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count requests expired and were hidden from the list.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Expired on $date';
  }

  @override
  String get dateUnavailable => 'Date unavailable';

  @override
  String serviceLabel(Object title) {
    return 'Service: $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Date: $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Turn: $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Last offer: $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Current amount: $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Worker proposal: $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Your offer: $amount';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get pendingPaymentsSection => 'Pending payments';

  @override
  String get offersInNegotiationSection => 'Offers in negotiation';

  @override
  String get noNewOffers => 'You have no new offers.';

  @override
  String get offerAcceptedMessage =>
      'Offer accepted. Complete payment to assign the service.';

  @override
  String get serviceAssignedMessage => 'Service assigned';

  @override
  String get offerRejectedMessage => 'Offer rejected';

  @override
  String get counterofferTitle => 'Send counteroffer';

  @override
  String get counterofferPriceLabel => 'New price';

  @override
  String get counterofferNoteLabel => 'Message (optional)';

  @override
  String get enterValidAmount => 'Enter a valid amount';

  @override
  String get sendButton => 'Send';

  @override
  String get counterofferSent => 'Counteroffer sent';

  @override
  String get acceptTooltip => 'Accept';

  @override
  String get rejectTooltip => 'Reject';

  @override
  String get counterofferTooltip => 'Counteroffer';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker offered';
  }

  @override
  String get serviceUpdatedMessage => 'Service updated';

  @override
  String paymentStatusLabel(Object status) {
    return 'Payment status: $status';
  }

  @override
  String get paymentPendingTitle => 'Pending payment';

  @override
  String get awaitingClientPayment =>
      'Waiting for the client to start the payment for this service.';

  @override
  String get proceedToPayment => 'Proceed to payment';

  @override
  String get updateStatus => 'Update status';

  @override
  String get paymentRetryInfo =>
      'Your last attempt was rejected. You can retry so the worker can start.';

  @override
  String get paymentContinueInfo =>
      'Complete the payment to confirm the worker assignment.';

  @override
  String get paymentSyncInfo =>
      'We are syncing the payment info. If you already paid, use the update button in notifications.';

  @override
  String get servicePublishedMessage => 'Service published successfully';

  @override
  String get deleteServiceTitle => 'Delete service';

  @override
  String get deleteServiceConfirmation =>
      'Are you sure you want to delete this listing?';

  @override
  String get deleteButton => 'Delete';

  @override
  String get serviceDefaultTitle => 'Service';

  @override
  String get myAccount => 'My account';

  @override
  String get serviceFormPublishTitle => 'Service publication';

  @override
  String get serviceFormEditTitle => 'Edit service';

  @override
  String get serviceTitleLabel => 'Title *';

  @override
  String get serviceDescriptionLabel => 'Description *';

  @override
  String get serviceLocationLabel => 'Location *';

  @override
  String get serviceEstimatedDateLabel => 'Estimated date *';

  @override
  String get selectDatePrompt => 'Select a date';

  @override
  String get datePickerHelp => 'Select estimated date';

  @override
  String get titleRequiredError => 'Title must not be empty';

  @override
  String get descriptionRequiredError => 'Description must not be empty';

  @override
  String get categoryRequiredError => 'Select a category';

  @override
  String get locationRequiredError => 'Location is required';

  @override
  String get dateInPastError => 'The date cannot be before today';

  @override
  String get invalidCategoryError => 'Invalid category';

  @override
  String get requiredFieldsNote => '* Required fields';

  @override
  String get saveButton => 'Save';

  @override
  String get clientLabel => 'Client';

  @override
  String get workerLabel => 'Worker';

  @override
  String get negotiationInNegotiation => 'In negotiation';

  @override
  String get negotiationInProgress => 'In progress';

  @override
  String get negotiationAccepted => 'Accepted';

  @override
  String get negotiationRejected => 'Rejected';

  @override
  String get negotiationClosed => 'Closed';

  @override
  String get negotiationPending => 'Pending';

  @override
  String get serviceStatePending => 'Pending';

  @override
  String get serviceStatePaymentPending => 'Payment pending';

  @override
  String get serviceStateInProgress => 'In progress';

  @override
  String get serviceStateFinished => 'Finished';

  @override
  String get serviceStateExpired => 'Expired';

  @override
  String get paymentStatusPending => 'Pending payment';

  @override
  String get paymentStatusRequiresPaymentMethod => 'Requires another method';

  @override
  String get paymentStatusRequiresAction => 'Action required';

  @override
  String get paymentStatusSucceeded => 'Payment confirmed';

  @override
  String get paymentStatusFailed => 'Payment failed';

  @override
  String get paymentStatusNotRequired => 'Not required';

  @override
  String get paymentStatusDefault => 'Payment';

  @override
  String get manageAccountLabel => 'Manage account';

  @override
  String get logoutLabel => 'Log out';

  @override
  String get closeTooltip => 'Close';

  @override
  String get profileGreeting => 'Hello!';

  @override
  String profileGreetingWithName(Object name) {
    return 'Hello, $name!';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Attention: the service \"$title\" expires today and will be automatically removed at midnight if still pending.';
  }

  @override
  String get serviceDeletedMessage => 'Service deleted';

  @override
  String get serviceDeleteBlockedMessage =>
      'Cannot delete an accepted service.';
}
