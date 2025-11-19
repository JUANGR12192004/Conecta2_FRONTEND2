// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Bienvenue sur Workify';

  @override
  String get subtitle => 'Choisissez votre rôle pour continuer';

  @override
  String get roleHint => 'Sélectionnez Travailleur ou Client pour poursuivre';

  @override
  String get workerButton => 'Je suis Travailleur';

  @override
  String get clientButton => 'Je suis Client';

  @override
  String get selectCountry => 'Sélectionnez un pays';

  @override
  String get currencyLabel => 'Devise actuelle';

  @override
  String get dateLabel => 'Date locale';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Connexion en tant que Travailleur';

  @override
  String get loginTitleClient => 'Connexion en tant que Client';

  @override
  String get loginDescription =>
      'Connectez-vous à des artisans vérifiés, payez en toute sécurité et suivez votre service en temps réel.';

  @override
  String get loginFeaturePayments => 'Paiements sécurisés';

  @override
  String get loginFeatureIdentity => 'Identité vérifiée';

  @override
  String get loginFeatureSupport => 'Assistance et sécurité';

  @override
  String get accessTitle => 'Accès sécurisé';

  @override
  String get emailLabel => 'Courriel';

  @override
  String get emailEmptyError => 'Entrez votre courriel';

  @override
  String get emailInvalidError => 'Courriel invalide';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordEmptyError => 'Entrez votre mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get registerPrompt =>
      'Vous n\'avez pas de compte ? Inscrivez-vous ici';

  @override
  String get backHome => '⬅️ Retour à l\'accueil';

  @override
  String get unverifiedAccountMessage =>
      'Votre compte n\'est pas vérifié. Vérifiez votre courriel et activez-le pour vous connecter.';

  @override
  String get understood => 'Compris';

  @override
  String errorMessage(Object message) {
    return 'Erreur : $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Bienvenue $name';
  }

  @override
  String get registerTitleClient => 'Créez votre compte';

  @override
  String get registerSubtitleClient =>
      'Connectez-vous avec des professionnels vérifiés et payez en toute sécurité.';

  @override
  String get verifiedIdentity => 'Identité vérifiée';

  @override
  String get registerTagProtected => 'Paiements protégés';

  @override
  String get registerTagSupport => 'Assistance 24/7';

  @override
  String get registerTagVerified => 'Services vérifiés';

  @override
  String get personalDataTitle => 'Informations personnelles';

  @override
  String get nameLabel => 'Nom complet';

  @override
  String get nameMinError => 'Entrez votre nom (au moins 3 caractères)';

  @override
  String get phoneLabel => 'Téléphone';

  @override
  String get phoneEmptyError => 'Entrez votre téléphone';

  @override
  String get phoneInvalidError => 'Numéro invalide';

  @override
  String get passwordMinError => 'Minimum 6 caractères';

  @override
  String get confirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get confirmPasswordError => 'Confirmez votre mot de passe';

  @override
  String get termsAgreement =>
      'J\'accepte les termes et conditions et la politique de confidentialité.';

  @override
  String get termsError => 'Vous devez accepter les termes et conditions.';

  @override
  String get passwordsMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get createAccountButton => 'Créer un compte';

  @override
  String get registrationReceived =>
      'Inscription reçue. Vérifiez votre e-mail pour activer le compte.';

  @override
  String get unknownError => 'Erreur inconnue. Veuillez réessayer.';

  @override
  String connectionError(Object message) {
    return 'Erreur de connexion : $message';
  }

  @override
  String get registerTitleWorker => 'Inscription travailleur';

  @override
  String get registerSubtitleWorker =>
      'Publiez vos services, définissez vos disponibilités et connectez-vous aux clients.';

  @override
  String get serviceCategoryLabel => 'Catégorie *';

  @override
  String get categoriesLoading => 'Chargement des catégories...';

  @override
  String get categoriesUnavailable => 'Aucune catégorie disponible';

  @override
  String get selectCategoryPrompt => 'Sélectionnez une catégorie';

  @override
  String get categoryInvalid => 'La catégorie sélectionnée est invalide';

  @override
  String get registerButtonWorker => 'S\'inscrire';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get haveAccountCarryOn => 'Vous avez déjà un compte ? ';

  @override
  String get loginHere => 'Connectez-vous';

  @override
  String categoriesFallback(Object message) {
    return 'Catégories chargées localement. Détail : $message';
  }

  @override
  String get categoriesLocalFallback =>
      'Impossible de charger les catégories du serveur. Des valeurs locales ont été utilisées.';

  @override
  String categoriesError(Object message) {
    return 'Impossible de charger les catégories : $message';
  }

  @override
  String get publishServiceTooltip => 'Publier un service';

  @override
  String get notificationsTooltip => 'Notifications';

  @override
  String get refreshTooltip => 'Actualiser';

  @override
  String get optionsTooltip => 'Options';

  @override
  String get viewMapLabel => 'Voir la carte';

  @override
  String get viewButton => 'Voir';

  @override
  String get expiredServicesTitle => 'Demandes expirées';

  @override
  String get noExpiredServices => 'Aucune demande expirée.';

  @override
  String get expiredServiceSingle =>
      '1 demande a expiré et a été masquée de la liste.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count demandes ont expiré et ont été masquées de la liste.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Expiré le $date';
  }

  @override
  String get dateUnavailable => 'Date indisponible';

  @override
  String serviceLabel(Object title) {
    return 'Service : $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Date : $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Statut : $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Tour : $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Dernière offre : $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Montant actuel : $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Proposition du travailleur : $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Votre offre : $amount';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get pendingPaymentsSection => 'Paiements en attente';

  @override
  String get offersInNegotiationSection => 'Offres en négociation';

  @override
  String get noNewOffers => 'Vous n\'avez pas de nouvelles offres.';

  @override
  String get offerAcceptedMessage =>
      'Offre acceptée. Effectuez le paiement pour attribuer le service.';

  @override
  String get serviceAssignedMessage => 'Service attribué';

  @override
  String get offerRejectedMessage => 'Offre refusée';

  @override
  String get counterofferTitle => 'Envoyer une contre-offre';

  @override
  String get counterofferPriceLabel => 'Nouveau prix';

  @override
  String get counterofferNoteLabel => 'Message (optionnel)';

  @override
  String get enterValidAmount => 'Saisissez un montant valide';

  @override
  String get sendButton => 'Envoyer';

  @override
  String get counterofferSent => 'Contre-offre envoyée';

  @override
  String get acceptTooltip => 'Accepter';

  @override
  String get rejectTooltip => 'Refuser';

  @override
  String get counterofferTooltip => 'Contre-offre';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker a fait une offre';
  }

  @override
  String get serviceUpdatedMessage => 'Service mis à jour';

  @override
  String paymentStatusLabel(Object status) {
    return 'État du paiement : $status';
  }

  @override
  String get paymentPendingTitle => 'Paiement en attente';

  @override
  String get awaitingClientPayment =>
      'En attente que le client lance le paiement pour ce service.';

  @override
  String get proceedToPayment => 'Procéder au paiement';

  @override
  String get updateStatus => 'Mettre à jour le statut';

  @override
  String get paymentRetryInfo =>
      'Votre dernière tentative a été refusée. Vous pouvez réessayer pour que le travailleur commence.';

  @override
  String get paymentContinueInfo =>
      'Effectuez le paiement pour confirmer l’affectation du travailleur.';

  @override
  String get paymentSyncInfo =>
      'Nous synchronisons les informations de paiement. Si vous avez déjà payé, utilisez le bouton de mise à jour dans les notifications.';

  @override
  String get servicePublishedMessage => 'Service publié avec succès';

  @override
  String get deleteServiceTitle => 'Supprimer le service';

  @override
  String get deleteServiceConfirmation =>
      'Voulez-vous vraiment supprimer cette publication ?';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get serviceDefaultTitle => 'Service';

  @override
  String get myAccount => 'Mon compte';

  @override
  String get serviceFormPublishTitle => 'Publication de services';

  @override
  String get serviceFormEditTitle => 'Modifier le service';

  @override
  String get serviceTitleLabel => 'Titre *';

  @override
  String get serviceDescriptionLabel => 'Description *';

  @override
  String get serviceLocationLabel => 'Emplacement *';

  @override
  String get serviceEstimatedDateLabel => 'Date estimée *';

  @override
  String get selectDatePrompt => 'Sélectionnez une date';

  @override
  String get datePickerHelp => 'Sélectionnez la date estimée';

  @override
  String get titleRequiredError => 'Le titre ne doit pas être vide';

  @override
  String get descriptionRequiredError => 'La description ne doit pas être vide';

  @override
  String get categoryRequiredError => 'Sélectionnez une catégorie';

  @override
  String get locationRequiredError => 'L’emplacement est requis';

  @override
  String get dateInPastError =>
      'La date ne peut pas être antérieure à aujourd’hui';

  @override
  String get invalidCategoryError => 'Catégorie invalide';

  @override
  String get requiredFieldsNote => '* Champs obligatoires';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get clientLabel => 'Client';

  @override
  String get workerLabel => 'Travailleur';

  @override
  String get negotiationInNegotiation => 'En négociation';

  @override
  String get negotiationInProgress => 'En cours';

  @override
  String get negotiationAccepted => 'Acceptée';

  @override
  String get negotiationRejected => 'Rejetée';

  @override
  String get negotiationClosed => 'Clôturée';

  @override
  String get negotiationPending => 'En attente';

  @override
  String get serviceStatePending => 'En attente';

  @override
  String get serviceStatePaymentPending => 'Paiement en attente';

  @override
  String get serviceStateInProgress => 'En cours';

  @override
  String get serviceStateFinished => 'Terminé';

  @override
  String get serviceStateExpired => 'Expiré';

  @override
  String get paymentStatusPending => 'Paiement en attente';

  @override
  String get paymentStatusRequiresPaymentMethod => 'Nécessite un autre moyen';

  @override
  String get paymentStatusRequiresAction => 'Action requise';

  @override
  String get paymentStatusSucceeded => 'Paiement confirmé';

  @override
  String get paymentStatusFailed => 'Paiement refusé';

  @override
  String get paymentStatusNotRequired => 'Non requis';

  @override
  String get paymentStatusDefault => 'Paiement';

  @override
  String get manageAccountLabel => 'Gérer le compte';

  @override
  String get logoutLabel => 'Se déconnecter';

  @override
  String get closeTooltip => 'Fermer';

  @override
  String get profileGreeting => 'Bonjour !';

  @override
  String profileGreetingWithName(Object name) {
    return 'Bonjour, $name !';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Attention : le service \"$title\" expire aujourd’hui et sera automatiquement supprimé à minuit s’il reste en attente.';
  }

  @override
  String get serviceDeletedMessage => 'Service supprimé';

  @override
  String get serviceDeleteBlockedMessage =>
      'Impossible de supprimer un service accepté.';
}

/// The translations for French, as used in France (`fr_FR`).
class AppLocalizationsFrFr extends AppLocalizationsFr {
  AppLocalizationsFrFr() : super('fr_FR');

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Bienvenue sur Workify';

  @override
  String get subtitle => 'Choisissez votre rôle pour continuer';

  @override
  String get roleHint => 'Sélectionnez Travailleur ou Client pour poursuivre';

  @override
  String get workerButton => 'Je suis Travailleur';

  @override
  String get clientButton => 'Je suis Client';

  @override
  String get selectCountry => 'Sélectionnez un pays';

  @override
  String get currencyLabel => 'Devise actuelle';

  @override
  String get dateLabel => 'Date locale';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Connexion en tant que Travailleur';

  @override
  String get loginTitleClient => 'Connexion en tant que Client';

  @override
  String get loginDescription =>
      'Connectez-vous à des artisans vérifiés, payez en toute sécurité et suivez votre service en temps réel.';

  @override
  String get loginFeaturePayments => 'Paiements sécurisés';

  @override
  String get loginFeatureIdentity => 'Identité vérifiée';

  @override
  String get loginFeatureSupport => 'Assistance et sécurité';

  @override
  String get accessTitle => 'Accès sécurisé';

  @override
  String get emailLabel => 'Courriel';

  @override
  String get emailEmptyError => 'Entrez votre courriel';

  @override
  String get emailInvalidError => 'Courriel invalide';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get passwordEmptyError => 'Entrez votre mot de passe';

  @override
  String get forgotPassword => 'Mot de passe oublié ?';

  @override
  String get loginButton => 'Se connecter';

  @override
  String get registerPrompt =>
      'Vous n\'avez pas de compte ? Inscrivez-vous ici';

  @override
  String get backHome => '⬅️ Retour à l\'accueil';

  @override
  String get unverifiedAccountMessage =>
      'Votre compte n\'est pas vérifié. Vérifiez votre courriel et activez-le pour vous connecter.';

  @override
  String get understood => 'Compris';

  @override
  String errorMessage(Object message) {
    return 'Erreur : $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Bienvenue $name';
  }

  @override
  String get registerTitleClient => 'Créez votre compte';

  @override
  String get registerSubtitleClient =>
      'Connectez-vous avec des professionnels vérifiés et payez en toute sécurité.';

  @override
  String get verifiedIdentity => 'Identité vérifiée';

  @override
  String get registerTagProtected => 'Paiements protégés';

  @override
  String get registerTagSupport => 'Assistance 24/7';

  @override
  String get registerTagVerified => 'Services vérifiés';

  @override
  String get personalDataTitle => 'Informations personnelles';

  @override
  String get nameLabel => 'Nom complet';

  @override
  String get nameMinError => 'Entrez votre nom (au moins 3 caractères)';

  @override
  String get phoneLabel => 'Téléphone';

  @override
  String get phoneEmptyError => 'Entrez votre téléphone';

  @override
  String get phoneInvalidError => 'Numéro invalide';

  @override
  String get passwordMinError => 'Minimum 6 caractères';

  @override
  String get confirmPasswordLabel => 'Confirmer le mot de passe';

  @override
  String get confirmPasswordError => 'Confirmez votre mot de passe';

  @override
  String get termsAgreement =>
      'J\'accepte les termes et conditions et la politique de confidentialité.';

  @override
  String get termsError => 'Vous devez accepter les termes et conditions.';

  @override
  String get passwordsMismatch => 'Les mots de passe ne correspondent pas.';

  @override
  String get createAccountButton => 'Créer un compte';

  @override
  String get registrationReceived =>
      'Inscription reçue. Vérifiez votre e-mail pour activer le compte.';

  @override
  String get unknownError => 'Erreur inconnue. Veuillez réessayer.';

  @override
  String connectionError(Object message) {
    return 'Erreur de connexion : $message';
  }

  @override
  String get registerTitleWorker => 'Inscription travailleur';

  @override
  String get registerSubtitleWorker =>
      'Publiez vos services, définissez vos disponibilités et connectez-vous aux clients.';

  @override
  String get serviceCategoryLabel => 'Catégorie *';

  @override
  String get categoriesLoading => 'Chargement des catégories...';

  @override
  String get categoriesUnavailable => 'Aucune catégorie disponible';

  @override
  String get selectCategoryPrompt => 'Sélectionnez une catégorie';

  @override
  String get categoryInvalid => 'La catégorie sélectionnée est invalide';

  @override
  String get registerButtonWorker => 'S\'inscrire';

  @override
  String get cancelButton => 'Annuler';

  @override
  String get haveAccountCarryOn => 'Vous avez déjà un compte ? ';

  @override
  String get loginHere => 'Connectez-vous';

  @override
  String categoriesFallback(Object message) {
    return 'Catégories chargées localement. Détail : $message';
  }

  @override
  String get categoriesLocalFallback =>
      'Impossible de charger les catégories du serveur. Des valeurs locales ont été utilisées.';

  @override
  String categoriesError(Object message) {
    return 'Impossible de charger les catégories : $message';
  }

  @override
  String get publishServiceTooltip => 'Publier un service';

  @override
  String get notificationsTooltip => 'Notifications';

  @override
  String get refreshTooltip => 'Actualiser';

  @override
  String get optionsTooltip => 'Options';

  @override
  String get viewMapLabel => 'Voir la carte';

  @override
  String get viewButton => 'Voir';

  @override
  String get expiredServicesTitle => 'Demandes expirées';

  @override
  String get noExpiredServices => 'Aucune demande expirée.';

  @override
  String get expiredServiceSingle =>
      '1 demande a expiré et a été masquée de la liste.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count demandes ont expiré et ont été masquées de la liste.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Expiré le $date';
  }

  @override
  String get dateUnavailable => 'Date indisponible';

  @override
  String serviceLabel(Object title) {
    return 'Service : $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Date : $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Statut : $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Tour : $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Dernière offre : $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Montant actuel : $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Proposition du travailleur : $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Votre offre : $amount';
  }

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get pendingPaymentsSection => 'Paiements en attente';

  @override
  String get offersInNegotiationSection => 'Offres en négociation';

  @override
  String get noNewOffers => 'Vous n\'avez pas de nouvelles offres.';

  @override
  String get offerAcceptedMessage =>
      'Offre acceptée. Effectuez le paiement pour attribuer le service.';

  @override
  String get serviceAssignedMessage => 'Service attribué';

  @override
  String get offerRejectedMessage => 'Offre refusée';

  @override
  String get counterofferTitle => 'Envoyer une contre-offre';

  @override
  String get counterofferPriceLabel => 'Nouveau prix';

  @override
  String get counterofferNoteLabel => 'Message (optionnel)';

  @override
  String get enterValidAmount => 'Saisissez un montant valide';

  @override
  String get sendButton => 'Envoyer';

  @override
  String get counterofferSent => 'Contre-offre envoyée';

  @override
  String get acceptTooltip => 'Accepter';

  @override
  String get rejectTooltip => 'Refuser';

  @override
  String get counterofferTooltip => 'Contre-offre';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker a fait une offre';
  }

  @override
  String get serviceUpdatedMessage => 'Service mis à jour';

  @override
  String paymentStatusLabel(Object status) {
    return 'État du paiement : $status';
  }

  @override
  String get paymentPendingTitle => 'Paiement en attente';

  @override
  String get awaitingClientPayment =>
      'En attente que le client lance le paiement pour ce service.';

  @override
  String get proceedToPayment => 'Procéder au paiement';

  @override
  String get updateStatus => 'Mettre à jour le statut';

  @override
  String get paymentRetryInfo =>
      'Votre dernière tentative a été refusée. Vous pouvez réessayer pour que le travailleur commence.';

  @override
  String get paymentContinueInfo =>
      'Effectuez le paiement pour confirmer l’affectation du travailleur.';

  @override
  String get paymentSyncInfo =>
      'Nous synchronisons les informations de paiement. Si vous avez déjà payé, utilisez le bouton de mise à jour dans les notifications.';

  @override
  String get servicePublishedMessage => 'Service publié avec succès';

  @override
  String get deleteServiceTitle => 'Supprimer le service';

  @override
  String get deleteServiceConfirmation =>
      'Voulez-vous vraiment supprimer cette publication ?';

  @override
  String get deleteButton => 'Supprimer';

  @override
  String get serviceDefaultTitle => 'Service';

  @override
  String get myAccount => 'Mon compte';

  @override
  String get serviceFormPublishTitle => 'Publication de services';

  @override
  String get serviceFormEditTitle => 'Modifier le service';

  @override
  String get serviceTitleLabel => 'Titre *';

  @override
  String get serviceDescriptionLabel => 'Description *';

  @override
  String get serviceLocationLabel => 'Emplacement *';

  @override
  String get serviceEstimatedDateLabel => 'Date estimée *';

  @override
  String get selectDatePrompt => 'Sélectionnez une date';

  @override
  String get datePickerHelp => 'Sélectionnez la date estimée';

  @override
  String get titleRequiredError => 'Le titre ne doit pas être vide';

  @override
  String get descriptionRequiredError => 'La description ne doit pas être vide';

  @override
  String get categoryRequiredError => 'Sélectionnez une catégorie';

  @override
  String get locationRequiredError => 'L’emplacement est requis';

  @override
  String get dateInPastError =>
      'La date ne peut pas être antérieure à aujourd’hui';

  @override
  String get invalidCategoryError => 'Catégorie invalide';

  @override
  String get requiredFieldsNote => '* Champs obligatoires';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get clientLabel => 'Client';

  @override
  String get workerLabel => 'Travailleur';

  @override
  String get negotiationInNegotiation => 'En négociation';

  @override
  String get negotiationInProgress => 'En cours';

  @override
  String get negotiationAccepted => 'Acceptée';

  @override
  String get negotiationRejected => 'Rejetée';

  @override
  String get negotiationClosed => 'Clôturée';

  @override
  String get negotiationPending => 'En attente';

  @override
  String get serviceStatePending => 'En attente';

  @override
  String get serviceStatePaymentPending => 'Paiement en attente';

  @override
  String get serviceStateInProgress => 'En cours';

  @override
  String get serviceStateFinished => 'Terminé';

  @override
  String get serviceStateExpired => 'Expiré';

  @override
  String get paymentStatusPending => 'Paiement en attente';

  @override
  String get paymentStatusRequiresPaymentMethod => 'Nécessite un autre moyen';

  @override
  String get paymentStatusRequiresAction => 'Action requise';

  @override
  String get paymentStatusSucceeded => 'Paiement confirmé';

  @override
  String get paymentStatusFailed => 'Paiement refusé';

  @override
  String get paymentStatusNotRequired => 'Non requis';

  @override
  String get paymentStatusDefault => 'Paiement';

  @override
  String get manageAccountLabel => 'Gérer le compte';

  @override
  String get logoutLabel => 'Se déconnecter';

  @override
  String get closeTooltip => 'Fermer';

  @override
  String get profileGreeting => 'Bonjour !';

  @override
  String profileGreetingWithName(Object name) {
    return 'Bonjour, $name !';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Attention : le service \"$title\" expire aujourd’hui et sera automatiquement supprimé à minuit s’il reste en attente.';
  }

  @override
  String get serviceDeletedMessage => 'Service supprimé';

  @override
  String get serviceDeleteBlockedMessage =>
      'Impossible de supprimer un service accepté.';
}
