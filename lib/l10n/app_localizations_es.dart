// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Bienvenido a Workify';

  @override
  String get subtitle => 'Elige tu rol para continuar';

  @override
  String get roleHint => 'Selecciona Trabajador o Cliente para avanzar';

  @override
  String get workerButton => 'Soy Trabajador';

  @override
  String get clientButton => 'Soy Cliente';

  @override
  String get selectCountry => 'Selecciona un país';

  @override
  String get currencyLabel => 'Moneda actual';

  @override
  String get dateLabel => 'Fecha local';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Inicia sesión como Trabajador';

  @override
  String get loginTitleClient => 'Inicia sesión como Cliente';

  @override
  String get loginDescription =>
      'Conecta con oficios verificados, paga seguro y lleva seguimiento en tiempo real.';

  @override
  String get loginFeaturePayments => 'Pagos seguros';

  @override
  String get loginFeatureIdentity => 'Identidad verificada';

  @override
  String get loginFeatureSupport => 'Soporte y seguridad';

  @override
  String get accessTitle => 'Acceso seguro';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailEmptyError => 'Ingresa tu correo';

  @override
  String get emailInvalidError => 'Correo inválido';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordEmptyError => 'Ingresa tu contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get registerPrompt => '¿No tienes cuenta? Regístrate aquí';

  @override
  String get backHome => '⬅️ Volver al inicio';

  @override
  String get unverifiedAccountMessage =>
      'Tu cuenta no está verificada. Revisa tu correo y activa tu cuenta para iniciar sesión.';

  @override
  String get understood => 'Entendido';

  @override
  String errorMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Bienvenido $name';
  }

  @override
  String get registerTitleClient => 'Crea tu cuenta';

  @override
  String get registerSubtitleClient =>
      'Conecta con trabajadores confiables y paga seguro.';

  @override
  String get verifiedIdentity => 'Identidad verificada';

  @override
  String get registerTagProtected => 'Pagos protegidos';

  @override
  String get registerTagSupport => 'Soporte 24/7';

  @override
  String get registerTagVerified => 'Servicios verificados';

  @override
  String get personalDataTitle => 'Datos personales';

  @override
  String get nameLabel => 'Nombre completo';

  @override
  String get nameMinError => 'Ingresa tu nombre (mínimo 3 caracteres)';

  @override
  String get phoneLabel => 'Celular';

  @override
  String get phoneEmptyError => 'Ingresa tu celular';

  @override
  String get phoneInvalidError => 'Número inválido';

  @override
  String get passwordMinError => 'Mínimo 6 caracteres';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get confirmPasswordError => 'Confirma tu contraseña';

  @override
  String get termsAgreement =>
      'Acepto los términos y condiciones y la política de privacidad.';

  @override
  String get termsError => 'Debes aceptar los términos y condiciones.';

  @override
  String get passwordsMismatch => 'Las contraseñas no coinciden.';

  @override
  String get createAccountButton => 'Crear cuenta';

  @override
  String get registrationReceived =>
      'Registro recibido. Revisa tu correo para activar la cuenta.';

  @override
  String get unknownError => 'Error desconocido. Intenta de nuevo.';

  @override
  String connectionError(Object message) {
    return 'Error de conexión: $message';
  }

  @override
  String get registerTitleWorker => 'Registro de trabajador';

  @override
  String get registerSubtitleWorker =>
      'Lista tus servicios, define tu disponibilidad y conecta con clientes.';

  @override
  String get serviceCategoryLabel => 'Categoría *';

  @override
  String get categoriesLoading => 'Cargando categorías...';

  @override
  String get categoriesUnavailable => 'No hay categorías disponibles';

  @override
  String get selectCategoryPrompt => 'Selecciona una categoría';

  @override
  String get categoryInvalid => 'La categoría seleccionada no es válida';

  @override
  String get registerButtonWorker => 'Registrarse';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get haveAccountCarryOn => '¿Ya tienes cuenta? ';

  @override
  String get loginHere => 'Inicia sesión';

  @override
  String categoriesFallback(Object message) {
    return 'Categorías cargadas localmente. Detalle: $message';
  }

  @override
  String get categoriesLocalFallback =>
      'No se pudieron cargar las categorías del servidor. Se usaron valores locales.';

  @override
  String categoriesError(Object message) {
    return 'No se pudieron cargar las categorías: $message';
  }

  @override
  String get publishServiceTooltip => 'Publicar servicio';

  @override
  String get notificationsTooltip => 'Notificaciones';

  @override
  String get refreshTooltip => 'Actualizar';

  @override
  String get optionsTooltip => 'Opciones';

  @override
  String get viewMapLabel => 'Ver mapa';

  @override
  String get viewButton => 'Ver';

  @override
  String get expiredServicesTitle => 'Solicitudes vencidas';

  @override
  String get noExpiredServices => 'No hay solicitudes vencidas.';

  @override
  String get expiredServiceSingle =>
      '1 solicitud expiró y se ocultó del listado.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count solicitudes expiraron y se ocultaron del listado.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Expiró el $date';
  }

  @override
  String get dateUnavailable => 'Fecha no disponible';

  @override
  String serviceLabel(Object title) {
    return 'Servicio: $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Fecha: $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Estado: $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Turno: $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Última oferta: $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Monto vigente: $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Propuesta del trabajador: $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Tu oferta: $amount';
  }

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get pendingPaymentsSection => 'Pagos pendientes';

  @override
  String get offersInNegotiationSection => 'Ofertas en negociación';

  @override
  String get noNewOffers => 'No tienes ofertas nuevas.';

  @override
  String get offerAcceptedMessage =>
      'Oferta aceptada. Completa el pago para asignar el servicio.';

  @override
  String get serviceAssignedMessage => 'Servicio asignado';

  @override
  String get offerRejectedMessage => 'Oferta rechazada';

  @override
  String get counterofferTitle => 'Enviar contraoferta';

  @override
  String get counterofferPriceLabel => 'Nuevo precio';

  @override
  String get counterofferNoteLabel => 'Mensaje (opcional)';

  @override
  String get enterValidAmount => 'Ingresa un monto válido';

  @override
  String get sendButton => 'Enviar';

  @override
  String get counterofferSent => 'Contraoferta enviada';

  @override
  String get acceptTooltip => 'Aceptar';

  @override
  String get rejectTooltip => 'Rechazar';

  @override
  String get counterofferTooltip => 'Contraoferta';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker ofertó';
  }

  @override
  String get serviceUpdatedMessage => 'Servicio actualizado';

  @override
  String paymentStatusLabel(Object status) {
    return 'Estado de pago: $status';
  }

  @override
  String get paymentPendingTitle => 'Pago pendiente';

  @override
  String get awaitingClientPayment =>
      'Esperando que el cliente inicie el pago para este servicio.';

  @override
  String get proceedToPayment => 'Proceder al pago';

  @override
  String get updateStatus => 'Actualizar estado';

  @override
  String get paymentRetryInfo =>
      'Tu último intento fue rechazado. Puedes reintentar para que el trabajador empiece.';

  @override
  String get paymentContinueInfo =>
      'Completa el pago para confirmar la asignación del trabajador.';

  @override
  String get paymentSyncInfo =>
      'Estamos sincronizando la información del pago. Si ya pagaste, usa el botón de actualizar en notificaciones.';

  @override
  String get servicePublishedMessage => 'Servicio publicado con éxito';

  @override
  String get deleteServiceTitle => 'Eliminar servicio';

  @override
  String get deleteServiceConfirmation =>
      '¿Seguro que deseas eliminar esta publicación?';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get serviceDefaultTitle => 'Servicio';

  @override
  String get myAccount => 'Mi cuenta';

  @override
  String get serviceFormPublishTitle => 'Publicación de servicios';

  @override
  String get serviceFormEditTitle => 'Editar servicio';

  @override
  String get serviceTitleLabel => 'Título *';

  @override
  String get serviceDescriptionLabel => 'Descripción *';

  @override
  String get serviceLocationLabel => 'Ubicación *';

  @override
  String get serviceEstimatedDateLabel => 'Fecha estimada *';

  @override
  String get selectDatePrompt => 'Selecciona una fecha';

  @override
  String get datePickerHelp => 'Selecciona fecha estimada';

  @override
  String get titleRequiredError => 'El título no debe estar vacío';

  @override
  String get descriptionRequiredError => 'La descripción no debe estar vacía';

  @override
  String get categoryRequiredError => 'Selecciona una categoría';

  @override
  String get locationRequiredError => 'La ubicación es obligatoria';

  @override
  String get dateInPastError => 'La fecha no puede ser anterior a hoy';

  @override
  String get invalidCategoryError => 'Categoría inválida';

  @override
  String get requiredFieldsNote => '* Campos obligatorios';

  @override
  String get saveButton => 'Guardar';

  @override
  String get clientLabel => 'Cliente';

  @override
  String get workerLabel => 'Trabajador';

  @override
  String get negotiationInNegotiation => 'En negociación';

  @override
  String get negotiationInProgress => 'En curso';

  @override
  String get negotiationAccepted => 'Aceptada';

  @override
  String get negotiationRejected => 'Rechazada';

  @override
  String get negotiationClosed => 'Cerrada';

  @override
  String get negotiationPending => 'Pendiente';

  @override
  String get serviceStatePending => 'Pendiente';

  @override
  String get serviceStatePaymentPending => 'Pago pendiente';

  @override
  String get serviceStateInProgress => 'En curso';

  @override
  String get serviceStateFinished => 'Finalizado';

  @override
  String get serviceStateExpired => 'Expirado';

  @override
  String get paymentStatusPending => 'Pago pendiente';

  @override
  String get paymentStatusRequiresPaymentMethod => 'Requiere otro método';

  @override
  String get paymentStatusRequiresAction => 'Se requiere acción';

  @override
  String get paymentStatusSucceeded => 'Pago confirmado';

  @override
  String get paymentStatusFailed => 'Pago rechazado';

  @override
  String get paymentStatusNotRequired => 'No requiere pago';

  @override
  String get paymentStatusDefault => 'Pago';

  @override
  String get manageAccountLabel => 'Administrar cuenta';

  @override
  String get logoutLabel => 'Cerrar sesión';

  @override
  String get closeTooltip => 'Cerrar';

  @override
  String get profileGreeting => '¡Hola!';

  @override
  String profileGreetingWithName(Object name) {
    return '¡Hola, $name!';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Atención: el servicio \"$title\" vence hoy y será eliminado automáticamente a las 00:00 si sigue pendiente.';
  }

  @override
  String get serviceDeletedMessage => 'Servicio eliminado';

  @override
  String get serviceDeleteBlockedMessage =>
      'No se puede eliminar un servicio aceptado.';

  @override
  String get workerEditAccount => 'Editar cuenta';

  @override
  String get workerActiveAccount => 'Cuenta activa';

  @override
  String get workerInactiveAccount => 'Cuenta inactiva';

  @override
  String get workerHomeTitle => 'Workify Trabajador';

  @override
  String get workerNoResponses => 'No tienes nuevas respuestas.';

  @override
  String get workerInvalidAmount => 'Monto inválido';

  @override
  String workerOfferForService(Object title) {
    return 'Ofertar para $title';
  }

  @override
  String get workerPriceProposed => 'Precio propuesto';

  @override
  String get workerOfferButton => 'Enviar oferta';

  @override
  String get workerOfferTooltip => 'Enviar una nueva oferta';

  @override
  String get workerOfferDisabled => 'Este servicio ya no admite nuevas ofertas';

  @override
  String workerHiddenExpiredPipe(Object count) {
    return 'Se ocultaron $count solicitudes vencidas.';
  }

  @override
  String get workerNoOpportunities =>
      'No hay oportunidades disponibles en tu área por ahora.';

  @override
  String workerNegotiationLabel(Object status) {
    return 'Negociación: $status';
  }

  @override
  String get workerOfferSent => 'Oferta enviada';

  @override
  String get workerAccountLoadButton => 'Cargar datos de mi cuenta';

  @override
  String get workerAccountUpdated => 'Datos de cuenta actualizados';

  @override
  String get workerLoadError => 'No fue posible cargar los datos de tu cuenta.';

  @override
  String workerClientOfferLabel(Object amount, Object client) {
    return '$client ofertó $amount';
  }

  @override
  String get workerOpportunitiesTitle => 'Tus oportunidades';

  @override
  String get optionalMessageLabel => 'Mensaje (opcional)';

  @override
  String workerOfferError(Object message) {
    return 'Error al ofertar: $message';
  }
}

/// The translations for Spanish Castilian, as used in Colombia (`es_CO`).
class AppLocalizationsEsCo extends AppLocalizationsEs {
  AppLocalizationsEsCo() : super('es_CO');

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Bienvenido a Workify';

  @override
  String get subtitle => 'Elige tu rol para continuar';

  @override
  String get roleHint => 'Selecciona Trabajador o Cliente para avanzar';

  @override
  String get workerButton => 'Soy Trabajador';

  @override
  String get clientButton => 'Soy Cliente';

  @override
  String get selectCountry => 'Selecciona un país';

  @override
  String get currencyLabel => 'Moneda actual';

  @override
  String get dateLabel => 'Fecha local';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Inicia sesión como Trabajador';

  @override
  String get loginTitleClient => 'Inicia sesión como Cliente';

  @override
  String get loginDescription =>
      'Conecta con oficios verificados, paga seguro y lleva seguimiento en tiempo real.';

  @override
  String get loginFeaturePayments => 'Pagos seguros';

  @override
  String get loginFeatureIdentity => 'Identidad verificada';

  @override
  String get loginFeatureSupport => 'Soporte y seguridad';

  @override
  String get accessTitle => 'Acceso seguro';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get emailEmptyError => 'Ingresa tu correo';

  @override
  String get emailInvalidError => 'Correo inválido';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get passwordEmptyError => 'Ingresa tu contraseña';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get registerPrompt => '¿No tienes cuenta? Regístrate aquí';

  @override
  String get backHome => '⬅️ Volver al inicio';

  @override
  String get unverifiedAccountMessage =>
      'Tu cuenta no está verificada. Revisa tu correo y activa tu cuenta para iniciar sesión.';

  @override
  String get understood => 'Entendido';

  @override
  String errorMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Bienvenido $name';
  }

  @override
  String get registerTitleClient => 'Crea tu cuenta';

  @override
  String get registerSubtitleClient =>
      'Conecta con trabajadores confiables y paga seguro.';

  @override
  String get verifiedIdentity => 'Identidad verificada';

  @override
  String get registerTagProtected => 'Pagos protegidos';

  @override
  String get registerTagSupport => 'Soporte 24/7';

  @override
  String get registerTagVerified => 'Servicios verificados';

  @override
  String get personalDataTitle => 'Datos personales';

  @override
  String get nameLabel => 'Nombre completo';

  @override
  String get nameMinError => 'Ingresa tu nombre (mínimo 3 caracteres)';

  @override
  String get phoneLabel => 'Celular';

  @override
  String get phoneEmptyError => 'Ingresa tu celular';

  @override
  String get phoneInvalidError => 'Número inválido';

  @override
  String get passwordMinError => 'Mínimo 6 caracteres';

  @override
  String get confirmPasswordLabel => 'Confirmar contraseña';

  @override
  String get confirmPasswordError => 'Confirma tu contraseña';

  @override
  String get termsAgreement =>
      'Acepto los términos y condiciones y la política de privacidad.';

  @override
  String get termsError => 'Debes aceptar los términos y condiciones.';

  @override
  String get passwordsMismatch => 'Las contraseñas no coinciden.';

  @override
  String get createAccountButton => 'Crear cuenta';

  @override
  String get registrationReceived =>
      'Registro recibido. Revisa tu correo para activar la cuenta.';

  @override
  String get unknownError => 'Error desconocido. Intenta de nuevo.';

  @override
  String connectionError(Object message) {
    return 'Error de conexión: $message';
  }

  @override
  String get registerTitleWorker => 'Registro de trabajador';

  @override
  String get registerSubtitleWorker =>
      'Lista tus servicios, define tu disponibilidad y conecta con clientes.';

  @override
  String get serviceCategoryLabel => 'Categoría *';

  @override
  String get categoriesLoading => 'Cargando categorías...';

  @override
  String get categoriesUnavailable => 'No hay categorías disponibles';

  @override
  String get selectCategoryPrompt => 'Selecciona una categoría';

  @override
  String get categoryInvalid => 'La categoría seleccionada no es válida';

  @override
  String get registerButtonWorker => 'Registrarse';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get haveAccountCarryOn => '¿Ya tienes cuenta? ';

  @override
  String get loginHere => 'Inicia sesión';

  @override
  String categoriesFallback(Object message) {
    return 'Categorías cargadas localmente. Detalle: $message';
  }

  @override
  String get categoriesLocalFallback =>
      'No se pudieron cargar las categorías del servidor. Se usaron valores locales.';

  @override
  String categoriesError(Object message) {
    return 'No se pudieron cargar las categorías: $message';
  }

  @override
  String get publishServiceTooltip => 'Publicar servicio';

  @override
  String get notificationsTooltip => 'Notificaciones';

  @override
  String get refreshTooltip => 'Actualizar';

  @override
  String get optionsTooltip => 'Opciones';

  @override
  String get viewMapLabel => 'Ver mapa';

  @override
  String get viewButton => 'Ver';

  @override
  String get expiredServicesTitle => 'Solicitudes vencidas';

  @override
  String get noExpiredServices => 'No hay solicitudes vencidas.';

  @override
  String get expiredServiceSingle =>
      '1 solicitud expiró y se ocultó del listado.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count solicitudes expiraron y se ocultaron del listado.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Expiró el $date';
  }

  @override
  String get dateUnavailable => 'Fecha no disponible';

  @override
  String serviceLabel(Object title) {
    return 'Servicio: $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Fecha: $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Estado: $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Turno: $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Última oferta: $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Monto vigente: $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Propuesta del trabajador: $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Tu oferta: $amount';
  }

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get pendingPaymentsSection => 'Pagos pendientes';

  @override
  String get offersInNegotiationSection => 'Ofertas en negociación';

  @override
  String get noNewOffers => 'No tienes ofertas nuevas.';

  @override
  String get offerAcceptedMessage =>
      'Oferta aceptada. Completa el pago para asignar el servicio.';

  @override
  String get serviceAssignedMessage => 'Servicio asignado';

  @override
  String get offerRejectedMessage => 'Oferta rechazada';

  @override
  String get counterofferTitle => 'Enviar contraoferta';

  @override
  String get counterofferPriceLabel => 'Nuevo precio';

  @override
  String get counterofferNoteLabel => 'Mensaje (opcional)';

  @override
  String get enterValidAmount => 'Ingresa un monto válido';

  @override
  String get sendButton => 'Enviar';

  @override
  String get counterofferSent => 'Contraoferta enviada';

  @override
  String get acceptTooltip => 'Aceptar';

  @override
  String get rejectTooltip => 'Rechazar';

  @override
  String get counterofferTooltip => 'Contraoferta';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker ofertó';
  }

  @override
  String get serviceUpdatedMessage => 'Servicio actualizado';

  @override
  String paymentStatusLabel(Object status) {
    return 'Estado de pago: $status';
  }

  @override
  String get paymentPendingTitle => 'Pago pendiente';

  @override
  String get awaitingClientPayment =>
      'Esperando que el cliente inicie el pago para este servicio.';

  @override
  String get proceedToPayment => 'Proceder al pago';

  @override
  String get updateStatus => 'Actualizar estado';

  @override
  String get paymentRetryInfo =>
      'Tu último intento fue rechazado. Puedes reintentar para que el trabajador empiece.';

  @override
  String get paymentContinueInfo =>
      'Completa el pago para confirmar la asignación del trabajador.';

  @override
  String get paymentSyncInfo =>
      'Estamos sincronizando la información del pago. Si ya pagaste, usa el botón de actualizar en notificaciones.';

  @override
  String get servicePublishedMessage => 'Servicio publicado con éxito';

  @override
  String get deleteServiceTitle => 'Eliminar servicio';

  @override
  String get deleteServiceConfirmation =>
      '¿Seguro que deseas eliminar esta publicación?';

  @override
  String get deleteButton => 'Eliminar';

  @override
  String get serviceDefaultTitle => 'Servicio';

  @override
  String get myAccount => 'Mi cuenta';

  @override
  String get serviceFormPublishTitle => 'Publicación de servicios';

  @override
  String get serviceFormEditTitle => 'Editar servicio';

  @override
  String get serviceTitleLabel => 'Título *';

  @override
  String get serviceDescriptionLabel => 'Descripción *';

  @override
  String get serviceLocationLabel => 'Ubicación *';

  @override
  String get serviceEstimatedDateLabel => 'Fecha estimada *';

  @override
  String get selectDatePrompt => 'Selecciona una fecha';

  @override
  String get datePickerHelp => 'Selecciona fecha estimada';

  @override
  String get titleRequiredError => 'El título no debe estar vacío';

  @override
  String get descriptionRequiredError => 'La descripción no debe estar vacía';

  @override
  String get categoryRequiredError => 'Selecciona una categoría';

  @override
  String get locationRequiredError => 'La ubicación es obligatoria';

  @override
  String get dateInPastError => 'La fecha no puede ser anterior a hoy';

  @override
  String get invalidCategoryError => 'Categoría inválida';

  @override
  String get requiredFieldsNote => '* Campos obligatorios';

  @override
  String get saveButton => 'Guardar';

  @override
  String get clientLabel => 'Cliente';

  @override
  String get workerLabel => 'Trabajador';

  @override
  String get negotiationInNegotiation => 'En negociación';

  @override
  String get negotiationInProgress => 'En curso';

  @override
  String get negotiationAccepted => 'Aceptada';

  @override
  String get negotiationRejected => 'Rechazada';

  @override
  String get negotiationClosed => 'Cerrada';

  @override
  String get negotiationPending => 'Pendiente';

  @override
  String get serviceStatePending => 'Pendiente';

  @override
  String get serviceStatePaymentPending => 'Pago pendiente';

  @override
  String get serviceStateInProgress => 'En curso';

  @override
  String get serviceStateFinished => 'Finalizado';

  @override
  String get serviceStateExpired => 'Expirado';

  @override
  String get paymentStatusPending => 'Pago pendiente';

  @override
  String get paymentStatusRequiresPaymentMethod => 'Requiere otro método';

  @override
  String get paymentStatusRequiresAction => 'Se requiere acción';

  @override
  String get paymentStatusSucceeded => 'Pago confirmado';

  @override
  String get paymentStatusFailed => 'Pago rechazado';

  @override
  String get paymentStatusNotRequired => 'No requiere pago';

  @override
  String get paymentStatusDefault => 'Pago';

  @override
  String get manageAccountLabel => 'Administrar cuenta';

  @override
  String get logoutLabel => 'Cerrar sesión';

  @override
  String get closeTooltip => 'Cerrar';

  @override
  String get profileGreeting => '¡Hola!';

  @override
  String profileGreetingWithName(Object name) {
    return '¡Hola, $name!';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Atención: el servicio \"$title\" vence hoy y será eliminado automáticamente a las 00:00 si sigue pendiente.';
  }

  @override
  String get serviceDeletedMessage => 'Servicio eliminado';

  @override
  String get serviceDeleteBlockedMessage =>
      'No se puede eliminar un servicio aceptado.';

  @override
  String get workerEditAccount => 'Editar cuenta';

  @override
  String get workerActiveAccount => 'Cuenta activa';

  @override
  String get workerInactiveAccount => 'Cuenta inactiva';

  @override
  String get workerHomeTitle => 'Workify Trabajador';

  @override
  String get workerNoResponses => 'No tienes nuevas respuestas.';

  @override
  String get workerInvalidAmount => 'Monto inválido';

  @override
  String workerOfferForService(Object title) {
    return 'Ofertar para $title';
  }

  @override
  String get workerPriceProposed => 'Precio propuesto';

  @override
  String get workerOfferButton => 'Enviar oferta';

  @override
  String get workerOfferTooltip => 'Enviar una nueva oferta';

  @override
  String get workerOfferDisabled => 'Este servicio ya no admite nuevas ofertas';

  @override
  String workerHiddenExpiredPipe(Object count) {
    return 'Se ocultaron $count solicitudes vencidas.';
  }

  @override
  String get workerNoOpportunities =>
      'No hay oportunidades disponibles en tu área por ahora.';

  @override
  String workerNegotiationLabel(Object status) {
    return 'Negociación: $status';
  }

  @override
  String get workerOfferSent => 'Oferta enviada';

  @override
  String get workerAccountLoadButton => 'Cargar datos de mi cuenta';

  @override
  String get workerAccountUpdated => 'Datos de cuenta actualizados';

  @override
  String get workerLoadError => 'No fue posible cargar los datos de tu cuenta.';

  @override
  String workerClientOfferLabel(Object amount, Object client) {
    return '$client ofertó $amount';
  }

  @override
  String get workerOpportunitiesTitle => 'Tus oportunidades';

  @override
  String get optionalMessageLabel => 'Mensaje (opcional)';

  @override
  String workerOfferError(Object message) {
    return 'Error al ofertar: $message';
  }
}
