// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Willkommen bei Workify';

  @override
  String get subtitle => 'Wähle deine Rolle, um fortzufahren';

  @override
  String get roleHint => 'Wähle Arbeiter oder Kunde, um weiterzumachen';

  @override
  String get workerButton => 'Ich bin Arbeiter';

  @override
  String get clientButton => 'Ich bin Kunde';

  @override
  String get selectCountry => 'Wähle ein Land';

  @override
  String get currencyLabel => 'Aktuelle Währung';

  @override
  String get dateLabel => 'Lokales Datum';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Als Arbeiter anmelden';

  @override
  String get loginTitleClient => 'Als Kunde anmelden';

  @override
  String get loginDescription =>
      'Verbinde dich mit geprüften Handwerkern, zahle sicher und verfolge deinen Service in Echtzeit.';

  @override
  String get loginFeaturePayments => 'Sichere Zahlungen';

  @override
  String get loginFeatureIdentity => 'Verifizierte Identität';

  @override
  String get loginFeatureSupport => 'Support und Sicherheit';

  @override
  String get accessTitle => 'Sicherer Zugang';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get emailEmptyError => 'Gib deine E-Mail ein';

  @override
  String get emailInvalidError => 'Ungültige E-Mail';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get passwordEmptyError => 'Gib dein Passwort ein';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get registerPrompt => 'Noch keinen Account? Hier registrieren';

  @override
  String get backHome => '⬅️ Zurück zur Startseite';

  @override
  String get unverifiedAccountMessage =>
      'Dein Konto ist nicht verifiziert. Prüfe deine E-Mail und aktiviere es.';

  @override
  String get understood => 'Verstanden';

  @override
  String errorMessage(Object message) {
    return 'Fehler: $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Willkommen $name';
  }

  @override
  String get registerTitleClient => 'Erstelle dein Konto';

  @override
  String get registerSubtitleClient =>
      'Verbinde dich mit verifizierten Handwerkern und zahle sicher.';

  @override
  String get verifiedIdentity => 'Verifizierte Identität';

  @override
  String get registerTagProtected => 'Sichere Zahlungen';

  @override
  String get registerTagSupport => '24/7 Support';

  @override
  String get registerTagVerified => 'Verifizierte Dienste';

  @override
  String get personalDataTitle => 'Persönliche Daten';

  @override
  String get nameLabel => 'Vollständiger Name';

  @override
  String get nameMinError => 'Gib deinen Namen ein (mindestens 3 Zeichen)';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get phoneEmptyError => 'Gib deine Telefonnummer ein';

  @override
  String get phoneInvalidError => 'Ungültige Nummer';

  @override
  String get passwordMinError => 'Mindestens 6 Zeichen';

  @override
  String get confirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get confirmPasswordError => 'Bestätige dein Passwort';

  @override
  String get termsAgreement =>
      'Ich akzeptiere die Allgemeinen Geschäftsbedingungen und die Datenschutzerklärung.';

  @override
  String get termsError => 'Du musst die AGB akzeptieren.';

  @override
  String get passwordsMismatch => 'Die Passwörter stimmen nicht überein.';

  @override
  String get createAccountButton => 'Konto erstellen';

  @override
  String get registrationReceived =>
      'Anmeldung eingegangen. Überprüfe deine E-Mails, um das Konto zu aktivieren.';

  @override
  String get unknownError => 'Unbekannter Fehler. Bitte erneut versuchen.';

  @override
  String connectionError(Object message) {
    return 'Verbindungsfehler: $message';
  }

  @override
  String get registerTitleWorker => 'Arbeiterregistrierung';

  @override
  String get registerSubtitleWorker =>
      'Stellen Sie Ihre Dienste ein, definieren Sie Verfügbarkeit und verbinden Sie sich mit Kunden.';

  @override
  String get serviceCategoryLabel => 'Kategorie *';

  @override
  String get categoriesLoading => 'Kategorien werden geladen...';

  @override
  String get categoriesUnavailable => 'Keine Kategorien verfügbar';

  @override
  String get selectCategoryPrompt => 'Wähle eine Kategorie';

  @override
  String get categoryInvalid => 'Die gewählte Kategorie ist ungültig';

  @override
  String get registerButtonWorker => 'Registrieren';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get haveAccountCarryOn => 'Bereits ein Konto? ';

  @override
  String get loginHere => 'Einloggen';

  @override
  String categoriesFallback(Object message) {
    return 'Kategorien lokal geladen. Details: $message';
  }

  @override
  String get categoriesLocalFallback =>
      'Kategorien konnten nicht vom Server geladen werden. Lokale Werte verwendet.';

  @override
  String categoriesError(Object message) {
    return 'Kategorien konnten nicht geladen werden: $message';
  }

  @override
  String get publishServiceTooltip => 'Dienst veröffentlichen';

  @override
  String get notificationsTooltip => 'Benachrichtigungen';

  @override
  String get refreshTooltip => 'Aktualisieren';

  @override
  String get optionsTooltip => 'Optionen';

  @override
  String get viewMapLabel => 'Karte anzeigen';

  @override
  String get viewButton => 'Ansehen';

  @override
  String get expiredServicesTitle => 'Abgelaufene Anfragen';

  @override
  String get noExpiredServices => 'Keine abgelaufenen Anfragen.';

  @override
  String get expiredServiceSingle =>
      '1 Anfrage ist abgelaufen und wurde aus der Liste entfernt.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count Anfragen sind abgelaufen und wurden aus der Liste entfernt.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Abgelaufen am $date';
  }

  @override
  String get dateUnavailable => 'Datum nicht verfügbar';

  @override
  String serviceLabel(Object title) {
    return 'Dienst: $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Datum: $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Zug: $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Letztes Angebot: $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Aktueller Betrag: $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Angebot des Arbeiters: $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Dein Angebot: $amount';
  }

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get pendingPaymentsSection => 'Ausstehende Zahlungen';

  @override
  String get offersInNegotiationSection => 'Angebote in Verhandlung';

  @override
  String get noNewOffers => 'Du hast keine neuen Angebote.';

  @override
  String get offerAcceptedMessage =>
      'Angebot angenommen. Schließe die Zahlung ab, um den Dienst zu vergeben.';

  @override
  String get serviceAssignedMessage => 'Dienst vergeben';

  @override
  String get offerRejectedMessage => 'Angebot abgelehnt';

  @override
  String get counterofferTitle => 'Gegenangebot senden';

  @override
  String get counterofferPriceLabel => 'Neuer Preis';

  @override
  String get counterofferNoteLabel => 'Nachricht (optional)';

  @override
  String get enterValidAmount => 'Gib einen gültigen Betrag ein';

  @override
  String get sendButton => 'Senden';

  @override
  String get counterofferSent => 'Gegenangebot gesendet';

  @override
  String get acceptTooltip => 'Akzeptieren';

  @override
  String get rejectTooltip => 'Ablehnen';

  @override
  String get counterofferTooltip => 'Gegenangebot';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker hat ein Angebot abgegeben';
  }

  @override
  String get serviceUpdatedMessage => 'Dienst aktualisiert';

  @override
  String paymentStatusLabel(Object status) {
    return 'Zahlungsstatus: $status';
  }

  @override
  String get paymentPendingTitle => 'Zahlung ausstehend';

  @override
  String get awaitingClientPayment =>
      'Warten darauf, dass der Kunde die Zahlung für diesen Dienst startet.';

  @override
  String get proceedToPayment => 'Zur Zahlung';

  @override
  String get updateStatus => 'Status aktualisieren';

  @override
  String get paymentRetryInfo =>
      'Dein letzter Versuch wurde abgelehnt. Du kannst es erneut versuchen, damit der Arbeiter beginnen kann.';

  @override
  String get paymentContinueInfo =>
      'Schließe die Zahlung ab, um die Zuweisung des Arbeiters zu bestätigen.';

  @override
  String get paymentSyncInfo =>
      'Wir synchronisieren die Zahlungsdaten. Wenn du bereits bezahlt hast, nutze den Aktualisieren-Button in den Benachrichtigungen.';

  @override
  String get servicePublishedMessage => 'Dienst erfolgreich veröffentlicht';

  @override
  String get deleteServiceTitle => 'Dienst löschen';

  @override
  String get deleteServiceConfirmation =>
      'Möchtest du dieses Angebot wirklich löschen?';

  @override
  String get deleteButton => 'Löschen';

  @override
  String get serviceDefaultTitle => 'Dienst';

  @override
  String get myAccount => 'Mein Konto';

  @override
  String get serviceFormPublishTitle => 'Dienstveröffentlichung';

  @override
  String get serviceFormEditTitle => 'Dienst bearbeiten';

  @override
  String get serviceTitleLabel => 'Titel *';

  @override
  String get serviceDescriptionLabel => 'Beschreibung *';

  @override
  String get serviceLocationLabel => 'Ort *';

  @override
  String get serviceEstimatedDateLabel => 'Geschätztes Datum *';

  @override
  String get selectDatePrompt => 'Wähle ein Datum';

  @override
  String get datePickerHelp => 'Geschätztes Datum auswählen';

  @override
  String get titleRequiredError => 'Der Titel darf nicht leer sein';

  @override
  String get descriptionRequiredError =>
      'Die Beschreibung darf nicht leer sein';

  @override
  String get categoryRequiredError => 'Wähle eine Kategorie';

  @override
  String get locationRequiredError => 'Der Ort ist erforderlich';

  @override
  String get dateInPastError => 'Das Datum darf nicht vor heute liegen';

  @override
  String get invalidCategoryError => 'Ungültige Kategorie';

  @override
  String get requiredFieldsNote => '* Pflichtfelder';

  @override
  String get saveButton => 'Speichern';

  @override
  String get clientLabel => 'Kunde';

  @override
  String get workerLabel => 'Arbeiter';

  @override
  String get negotiationInNegotiation => 'In Verhandlung';

  @override
  String get negotiationInProgress => 'In Bearbeitung';

  @override
  String get negotiationAccepted => 'Akzeptiert';

  @override
  String get negotiationRejected => 'Abgelehnt';

  @override
  String get negotiationClosed => 'Abgeschlossen';

  @override
  String get negotiationPending => 'Ausstehend';

  @override
  String get serviceStatePending => 'Ausstehend';

  @override
  String get serviceStatePaymentPending => 'Zahlung ausstehend';

  @override
  String get serviceStateInProgress => 'In Bearbeitung';

  @override
  String get serviceStateFinished => 'Abgeschlossen';

  @override
  String get serviceStateExpired => 'Abgelaufen';

  @override
  String get paymentStatusPending => 'Zahlung ausstehend';

  @override
  String get paymentStatusRequiresPaymentMethod =>
      'Weitere Zahlungsmethode erforderlich';

  @override
  String get paymentStatusRequiresAction => 'Aktion erforderlich';

  @override
  String get paymentStatusSucceeded => 'Zahlung bestätigt';

  @override
  String get paymentStatusFailed => 'Zahlung fehlgeschlagen';

  @override
  String get paymentStatusNotRequired => 'Nicht erforderlich';

  @override
  String get paymentStatusDefault => 'Zahlung';

  @override
  String get manageAccountLabel => 'Konto verwalten';

  @override
  String get logoutLabel => 'Abmelden';

  @override
  String get closeTooltip => 'Schließen';

  @override
  String get profileGreeting => 'Hallo!';

  @override
  String profileGreetingWithName(Object name) {
    return 'Hallo, $name!';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Achtung: Der Dienst \"$title\" läuft heute aus und wird automatisch um Mitternacht entfernt, falls er noch ausstehend ist.';
  }

  @override
  String get serviceDeletedMessage => 'Dienst gelöscht';

  @override
  String get serviceDeleteBlockedMessage =>
      'Ein akzeptierter Dienst kann nicht gelöscht werden.';

  @override
  String get workerEditAccount => 'Konto bearbeiten';

  @override
  String get workerActiveAccount => 'Aktives Konto';

  @override
  String get workerInactiveAccount => 'Inaktives Konto';

  @override
  String get workerHomeTitle => 'Worker-Bereich';

  @override
  String get workerNoResponses => 'Du hast keine neuen Antworten.';

  @override
  String get workerInvalidAmount => 'Ungültiger Betrag';

  @override
  String workerOfferForService(Object title) {
    return 'Angebot für $title';
  }

  @override
  String get workerPriceProposed => 'Vorgeschlagener Preis';

  @override
  String get workerOfferButton => 'Angebot senden';

  @override
  String get workerOfferTooltip => 'Neues Angebot senden';

  @override
  String get workerOfferDisabled =>
      'Dieser Dienst akzeptiert keine neuen Angebote mehr';

  @override
  String workerHiddenExpiredPipe(Object count) {
    return '$count abgelaufene Anfragen wurden ausgeblendet.';
  }

  @override
  String get workerNoOpportunities =>
      'Derzeit gibt es keine Möglichkeiten in Ihrer Region.';

  @override
  String workerNegotiationLabel(Object status) {
    return 'Verhandlung: $status';
  }

  @override
  String get workerOfferSent => 'Angebot gesendet';

  @override
  String get workerAccountLoadButton => 'Meine Kontodaten laden';

  @override
  String get workerAccountUpdated => 'Kontodaten aktualisiert';

  @override
  String get workerLoadError => 'Kontodaten konnten nicht geladen werden.';

  @override
  String workerClientOfferLabel(Object amount, Object client) {
    return '$client bot $amount';
  }

  @override
  String get workerOpportunitiesTitle => 'Verfügbare Chancen';

  @override
  String get optionalMessageLabel => 'Nachricht (optional)';

  @override
  String workerOfferError(Object message) {
    return 'Fehler beim Abgeben des Angebots: $message';
  }
}

/// The translations for German, as used in Germany (`de_DE`).
class AppLocalizationsDeDe extends AppLocalizationsDe {
  AppLocalizationsDeDe() : super('de_DE');

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Willkommen bei Workify';

  @override
  String get subtitle => 'Wähle deine Rolle, um fortzufahren';

  @override
  String get roleHint => 'Wähle Arbeiter oder Kunde, um weiterzumachen';

  @override
  String get workerButton => 'Ich bin Arbeiter';

  @override
  String get clientButton => 'Ich bin Kunde';

  @override
  String get selectCountry => 'Wähle ein Land';

  @override
  String get currencyLabel => 'Aktuelle Währung';

  @override
  String get dateLabel => 'Lokales Datum';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Als Arbeiter anmelden';

  @override
  String get loginTitleClient => 'Als Kunde anmelden';

  @override
  String get loginDescription =>
      'Verbinde dich mit geprüften Handwerkern, zahle sicher und verfolge deinen Service in Echtzeit.';

  @override
  String get loginFeaturePayments => 'Sichere Zahlungen';

  @override
  String get loginFeatureIdentity => 'Verifizierte Identität';

  @override
  String get loginFeatureSupport => 'Support und Sicherheit';

  @override
  String get accessTitle => 'Sicherer Zugang';

  @override
  String get emailLabel => 'E-Mail';

  @override
  String get emailEmptyError => 'Gib deine E-Mail ein';

  @override
  String get emailInvalidError => 'Ungültige E-Mail';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get passwordEmptyError => 'Gib dein Passwort ein';

  @override
  String get forgotPassword => 'Passwort vergessen?';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get registerPrompt => 'Noch keinen Account? Hier registrieren';

  @override
  String get backHome => '⬅️ Zurück zur Startseite';

  @override
  String get unverifiedAccountMessage =>
      'Dein Konto ist nicht verifiziert. Prüfe deine E-Mail und aktiviere es.';

  @override
  String get understood => 'Verstanden';

  @override
  String errorMessage(Object message) {
    return 'Fehler: $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Willkommen $name';
  }

  @override
  String get registerTitleClient => 'Erstelle dein Konto';

  @override
  String get registerSubtitleClient =>
      'Verbinde dich mit verifizierten Handwerkern und zahle sicher.';

  @override
  String get verifiedIdentity => 'Verifizierte Identität';

  @override
  String get registerTagProtected => 'Sichere Zahlungen';

  @override
  String get registerTagSupport => '24/7 Support';

  @override
  String get registerTagVerified => 'Verifizierte Dienste';

  @override
  String get personalDataTitle => 'Persönliche Daten';

  @override
  String get nameLabel => 'Vollständiger Name';

  @override
  String get nameMinError => 'Gib deinen Namen ein (mindestens 3 Zeichen)';

  @override
  String get phoneLabel => 'Telefon';

  @override
  String get phoneEmptyError => 'Gib deine Telefonnummer ein';

  @override
  String get phoneInvalidError => 'Ungültige Nummer';

  @override
  String get passwordMinError => 'Mindestens 6 Zeichen';

  @override
  String get confirmPasswordLabel => 'Passwort bestätigen';

  @override
  String get confirmPasswordError => 'Bestätige dein Passwort';

  @override
  String get termsAgreement =>
      'Ich akzeptiere die Allgemeinen Geschäftsbedingungen und die Datenschutzerklärung.';

  @override
  String get termsError => 'Du musst die AGB akzeptieren.';

  @override
  String get passwordsMismatch => 'Die Passwörter stimmen nicht überein.';

  @override
  String get createAccountButton => 'Konto erstellen';

  @override
  String get registrationReceived =>
      'Anmeldung eingegangen. Überprüfe deine E-Mails, um das Konto zu aktivieren.';

  @override
  String get unknownError => 'Unbekannter Fehler. Bitte erneut versuchen.';

  @override
  String connectionError(Object message) {
    return 'Verbindungsfehler: $message';
  }

  @override
  String get registerTitleWorker => 'Arbeiterregistrierung';

  @override
  String get registerSubtitleWorker =>
      'Stellen Sie Ihre Dienste ein, definieren Sie Verfügbarkeit und verbinden Sie sich mit Kunden.';

  @override
  String get serviceCategoryLabel => 'Kategorie *';

  @override
  String get categoriesLoading => 'Kategorien werden geladen...';

  @override
  String get categoriesUnavailable => 'Keine Kategorien verfügbar';

  @override
  String get selectCategoryPrompt => 'Wähle eine Kategorie';

  @override
  String get categoryInvalid => 'Die gewählte Kategorie ist ungültig';

  @override
  String get registerButtonWorker => 'Registrieren';

  @override
  String get cancelButton => 'Abbrechen';

  @override
  String get haveAccountCarryOn => 'Bereits ein Konto? ';

  @override
  String get loginHere => 'Einloggen';

  @override
  String categoriesFallback(Object message) {
    return 'Kategorien lokal geladen. Details: $message';
  }

  @override
  String get categoriesLocalFallback =>
      'Kategorien konnten nicht vom Server geladen werden. Lokale Werte verwendet.';

  @override
  String categoriesError(Object message) {
    return 'Kategorien konnten nicht geladen werden: $message';
  }

  @override
  String get publishServiceTooltip => 'Dienst veröffentlichen';

  @override
  String get notificationsTooltip => 'Benachrichtigungen';

  @override
  String get refreshTooltip => 'Aktualisieren';

  @override
  String get optionsTooltip => 'Optionen';

  @override
  String get viewMapLabel => 'Karte anzeigen';

  @override
  String get viewButton => 'Ansehen';

  @override
  String get expiredServicesTitle => 'Abgelaufene Anfragen';

  @override
  String get noExpiredServices => 'Keine abgelaufenen Anfragen.';

  @override
  String get expiredServiceSingle =>
      '1 Anfrage ist abgelaufen und wurde aus der Liste entfernt.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count Anfragen sind abgelaufen und wurden aus der Liste entfernt.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Abgelaufen am $date';
  }

  @override
  String get dateUnavailable => 'Datum nicht verfügbar';

  @override
  String serviceLabel(Object title) {
    return 'Dienst: $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Datum: $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Zug: $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Letztes Angebot: $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Aktueller Betrag: $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Angebot des Arbeiters: $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Dein Angebot: $amount';
  }

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get pendingPaymentsSection => 'Ausstehende Zahlungen';

  @override
  String get offersInNegotiationSection => 'Angebote in Verhandlung';

  @override
  String get noNewOffers => 'Du hast keine neuen Angebote.';

  @override
  String get offerAcceptedMessage =>
      'Angebot angenommen. Schließe die Zahlung ab, um den Dienst zu vergeben.';

  @override
  String get serviceAssignedMessage => 'Dienst vergeben';

  @override
  String get offerRejectedMessage => 'Angebot abgelehnt';

  @override
  String get counterofferTitle => 'Gegenangebot senden';

  @override
  String get counterofferPriceLabel => 'Neuer Preis';

  @override
  String get counterofferNoteLabel => 'Nachricht (optional)';

  @override
  String get enterValidAmount => 'Gib einen gültigen Betrag ein';

  @override
  String get sendButton => 'Senden';

  @override
  String get counterofferSent => 'Gegenangebot gesendet';

  @override
  String get acceptTooltip => 'Akzeptieren';

  @override
  String get rejectTooltip => 'Ablehnen';

  @override
  String get counterofferTooltip => 'Gegenangebot';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker hat ein Angebot abgegeben';
  }

  @override
  String get serviceUpdatedMessage => 'Dienst aktualisiert';

  @override
  String paymentStatusLabel(Object status) {
    return 'Zahlungsstatus: $status';
  }

  @override
  String get paymentPendingTitle => 'Zahlung ausstehend';

  @override
  String get awaitingClientPayment =>
      'Warten darauf, dass der Kunde die Zahlung für diesen Dienst startet.';

  @override
  String get proceedToPayment => 'Zur Zahlung';

  @override
  String get updateStatus => 'Status aktualisieren';

  @override
  String get paymentRetryInfo =>
      'Dein letzter Versuch wurde abgelehnt. Du kannst es erneut versuchen, damit der Arbeiter beginnen kann.';

  @override
  String get paymentContinueInfo =>
      'Schließe die Zahlung ab, um die Zuweisung des Arbeiters zu bestätigen.';

  @override
  String get paymentSyncInfo =>
      'Wir synchronisieren die Zahlungsdaten. Wenn du bereits bezahlt hast, nutze den Aktualisieren-Button in den Benachrichtigungen.';

  @override
  String get servicePublishedMessage => 'Dienst erfolgreich veröffentlicht';

  @override
  String get deleteServiceTitle => 'Dienst löschen';

  @override
  String get deleteServiceConfirmation =>
      'Möchtest du dieses Angebot wirklich löschen?';

  @override
  String get deleteButton => 'Löschen';

  @override
  String get serviceDefaultTitle => 'Dienst';

  @override
  String get myAccount => 'Mein Konto';

  @override
  String get serviceFormPublishTitle => 'Dienstveröffentlichung';

  @override
  String get serviceFormEditTitle => 'Dienst bearbeiten';

  @override
  String get serviceTitleLabel => 'Titel *';

  @override
  String get serviceDescriptionLabel => 'Beschreibung *';

  @override
  String get serviceLocationLabel => 'Ort *';

  @override
  String get serviceEstimatedDateLabel => 'Geschätztes Datum *';

  @override
  String get selectDatePrompt => 'Wähle ein Datum';

  @override
  String get datePickerHelp => 'Geschätztes Datum auswählen';

  @override
  String get titleRequiredError => 'Der Titel darf nicht leer sein';

  @override
  String get descriptionRequiredError =>
      'Die Beschreibung darf nicht leer sein';

  @override
  String get categoryRequiredError => 'Wähle eine Kategorie';

  @override
  String get locationRequiredError => 'Der Ort ist erforderlich';

  @override
  String get dateInPastError => 'Das Datum darf nicht vor heute liegen';

  @override
  String get invalidCategoryError => 'Ungültige Kategorie';

  @override
  String get requiredFieldsNote => '* Pflichtfelder';

  @override
  String get saveButton => 'Speichern';

  @override
  String get clientLabel => 'Kunde';

  @override
  String get workerLabel => 'Arbeiter';

  @override
  String get negotiationInNegotiation => 'In Verhandlung';

  @override
  String get negotiationInProgress => 'In Bearbeitung';

  @override
  String get negotiationAccepted => 'Akzeptiert';

  @override
  String get negotiationRejected => 'Abgelehnt';

  @override
  String get negotiationClosed => 'Abgeschlossen';

  @override
  String get negotiationPending => 'Ausstehend';

  @override
  String get serviceStatePending => 'Ausstehend';

  @override
  String get serviceStatePaymentPending => 'Zahlung ausstehend';

  @override
  String get serviceStateInProgress => 'In Bearbeitung';

  @override
  String get serviceStateFinished => 'Abgeschlossen';

  @override
  String get serviceStateExpired => 'Abgelaufen';

  @override
  String get paymentStatusPending => 'Zahlung ausstehend';

  @override
  String get paymentStatusRequiresPaymentMethod =>
      'Weitere Zahlungsmethode erforderlich';

  @override
  String get paymentStatusRequiresAction => 'Aktion erforderlich';

  @override
  String get paymentStatusSucceeded => 'Zahlung bestätigt';

  @override
  String get paymentStatusFailed => 'Zahlung fehlgeschlagen';

  @override
  String get paymentStatusNotRequired => 'Nicht erforderlich';

  @override
  String get paymentStatusDefault => 'Zahlung';

  @override
  String get manageAccountLabel => 'Konto verwalten';

  @override
  String get logoutLabel => 'Abmelden';

  @override
  String get closeTooltip => 'Schließen';

  @override
  String get profileGreeting => 'Hallo!';

  @override
  String profileGreetingWithName(Object name) {
    return 'Hallo, $name!';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Achtung: Der Dienst \"$title\" läuft heute aus und wird automatisch um Mitternacht entfernt, falls er noch ausstehend ist.';
  }

  @override
  String get serviceDeletedMessage => 'Dienst gelöscht';

  @override
  String get serviceDeleteBlockedMessage =>
      'Ein akzeptierter Dienst kann nicht gelöscht werden.';

  @override
  String get workerEditAccount => 'Konto bearbeiten';

  @override
  String get workerActiveAccount => 'Aktives Konto';

  @override
  String get workerInactiveAccount => 'Inaktives Konto';

  @override
  String get workerHomeTitle => 'Worker-Bereich';

  @override
  String get workerNoResponses => 'Du hast keine neuen Antworten.';

  @override
  String get workerInvalidAmount => 'Ungültiger Betrag';

  @override
  String workerOfferForService(Object title) {
    return 'Angebot für $title';
  }

  @override
  String get workerPriceProposed => 'Vorgeschlagener Preis';

  @override
  String get workerOfferButton => 'Angebot senden';

  @override
  String get workerOfferTooltip => 'Neues Angebot senden';

  @override
  String get workerOfferDisabled =>
      'Dieser Dienst akzeptiert keine neuen Angebote mehr';

  @override
  String workerHiddenExpiredPipe(Object count) {
    return '$count abgelaufene Anfragen wurden ausgeblendet.';
  }

  @override
  String get workerNoOpportunities =>
      'Derzeit gibt es keine Möglichkeiten in Ihrer Region.';

  @override
  String workerNegotiationLabel(Object status) {
    return 'Verhandlung: $status';
  }

  @override
  String get workerOfferSent => 'Angebot gesendet';

  @override
  String get workerAccountLoadButton => 'Meine Kontodaten laden';

  @override
  String get workerAccountUpdated => 'Kontodaten aktualisiert';

  @override
  String get workerLoadError => 'Kontodaten konnten nicht geladen werden.';

  @override
  String workerClientOfferLabel(Object amount, Object client) {
    return '$client bot $amount';
  }

  @override
  String get workerOpportunitiesTitle => 'Verfügbare Chancen';

  @override
  String get optionalMessageLabel => 'Nachricht (optional)';

  @override
  String workerOfferError(Object message) {
    return 'Fehler beim Abgeben des Angebots: $message';
  }
}
