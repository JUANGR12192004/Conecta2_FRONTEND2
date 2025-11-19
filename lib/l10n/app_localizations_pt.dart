// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Bem-vindo ao Workify';

  @override
  String get subtitle => 'Escolha sua função para continuar';

  @override
  String get roleHint => 'Selecione Trabalhador ou Cliente para avançar';

  @override
  String get workerButton => 'Sou Trabalhador';

  @override
  String get clientButton => 'Sou Cliente';

  @override
  String get selectCountry => 'Selecione um país';

  @override
  String get currencyLabel => 'Moeda atual';

  @override
  String get dateLabel => 'Data local';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Entre como Trabalhador';

  @override
  String get loginTitleClient => 'Entre como Cliente';

  @override
  String get loginDescription =>
      'Conecte-se a serviços verificados, pague com segurança e acompanhe em tempo real.';

  @override
  String get loginFeaturePayments => 'Pagamentos seguros';

  @override
  String get loginFeatureIdentity => 'Identidade verificada';

  @override
  String get loginFeatureSupport => 'Suporte e segurança';

  @override
  String get accessTitle => 'Acesso seguro';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailEmptyError => 'Informe seu e-mail';

  @override
  String get emailInvalidError => 'E-mail inválido';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get passwordEmptyError => 'Informe sua senha';

  @override
  String get forgotPassword => 'Esqueceu sua senha?';

  @override
  String get loginButton => 'Entrar';

  @override
  String get registerPrompt => 'Não tem conta? Cadastre-se aqui';

  @override
  String get backHome => '⬅️ Voltar ao início';

  @override
  String get unverifiedAccountMessage =>
      'Sua conta não está verificada. Verifique seu e-mail e ative para entrar.';

  @override
  String get understood => 'Entendi';

  @override
  String errorMessage(Object message) {
    return 'Erro: $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Bem-vindo $name';
  }

  @override
  String get registerTitleClient => 'Crie sua conta';

  @override
  String get registerSubtitleClient =>
      'Conecte-se a profissionais confiáveis e pague com segurança.';

  @override
  String get verifiedIdentity => 'Identidade verificada';

  @override
  String get registerTagProtected => 'Pagamentos protegidos';

  @override
  String get registerTagSupport => 'Suporte 24/7';

  @override
  String get registerTagVerified => 'Serviços verificados';

  @override
  String get personalDataTitle => 'Informações pessoais';

  @override
  String get nameLabel => 'Nome completo';

  @override
  String get nameMinError => 'Informe seu nome (mínimo 3 caracteres)';

  @override
  String get phoneLabel => 'Celular';

  @override
  String get phoneEmptyError => 'Informe seu celular';

  @override
  String get phoneInvalidError => 'Número inválido';

  @override
  String get passwordMinError => 'Mínimo 6 caracteres';

  @override
  String get confirmPasswordLabel => 'Confirme a senha';

  @override
  String get confirmPasswordError => 'Confirme sua senha';

  @override
  String get termsAgreement =>
      'Aceito os termos e condições e a política de privacidade.';

  @override
  String get termsError => 'Você deve aceitar os termos e condições.';

  @override
  String get passwordsMismatch => 'As senhas não coincidem.';

  @override
  String get createAccountButton => 'Criar conta';

  @override
  String get registrationReceived =>
      'Registro recebido. Confira seu e-mail para ativar a conta.';

  @override
  String get unknownError => 'Erro desconhecido. Tente novamente.';

  @override
  String connectionError(Object message) {
    return 'Erro de conexão: $message';
  }

  @override
  String get registerTitleWorker => 'Registro de trabalhador';

  @override
  String get registerSubtitleWorker =>
      'Cadastre seus serviços, defina disponibilidade e conecte-se a clientes.';

  @override
  String get serviceCategoryLabel => 'Categoria *';

  @override
  String get categoriesLoading => 'Carregando categorias...';

  @override
  String get categoriesUnavailable => 'Sem categorias disponíveis';

  @override
  String get selectCategoryPrompt => 'Selecione uma categoria';

  @override
  String get categoryInvalid => 'Categoria selecionada inválida';

  @override
  String get registerButtonWorker => 'Registrar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get haveAccountCarryOn => 'Já tem conta? ';

  @override
  String get loginHere => 'Entrar';

  @override
  String categoriesFallback(Object message) {
    return 'Categorias carregadas localmente. Detalhe: $message';
  }

  @override
  String get categoriesLocalFallback =>
      'Não foi possível carregar categorias do servidor. Valores locais foram usados.';

  @override
  String categoriesError(Object message) {
    return 'Não foi possível carregar categorias: $message';
  }

  @override
  String get publishServiceTooltip => 'Publicar serviço';

  @override
  String get notificationsTooltip => 'Notificações';

  @override
  String get refreshTooltip => 'Atualizar';

  @override
  String get optionsTooltip => 'Opções';

  @override
  String get viewMapLabel => 'Ver mapa';

  @override
  String get viewButton => 'Ver';

  @override
  String get expiredServicesTitle => 'Solicitações expiradas';

  @override
  String get noExpiredServices => 'Não há solicitações expiradas.';

  @override
  String get expiredServiceSingle =>
      '1 solicitação expirou e foi ocultada da lista.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count solicitações expiraram e foram ocultadas da lista.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Expirou em $date';
  }

  @override
  String get dateUnavailable => 'Data indisponível';

  @override
  String serviceLabel(Object title) {
    return 'Serviço: $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Data: $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Vez: $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Última oferta: $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Valor atual: $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Proposta do trabalhador: $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Sua oferta: $amount';
  }

  @override
  String get notificationsTitle => 'Notificações';

  @override
  String get pendingPaymentsSection => 'Pagamentos pendentes';

  @override
  String get offersInNegotiationSection => 'Ofertas em negociação';

  @override
  String get noNewOffers => 'Você não tem ofertas novas.';

  @override
  String get offerAcceptedMessage =>
      'Oferta aceita. Complete o pagamento para atribuir o serviço.';

  @override
  String get serviceAssignedMessage => 'Serviço atribuído';

  @override
  String get offerRejectedMessage => 'Oferta rejeitada';

  @override
  String get counterofferTitle => 'Enviar contraproposta';

  @override
  String get counterofferPriceLabel => 'Novo valor';

  @override
  String get counterofferNoteLabel => 'Mensagem (opcional)';

  @override
  String get enterValidAmount => 'Digite um valor válido';

  @override
  String get sendButton => 'Enviar';

  @override
  String get counterofferSent => 'Contraproposta enviada';

  @override
  String get acceptTooltip => 'Aceitar';

  @override
  String get rejectTooltip => 'Rejeitar';

  @override
  String get counterofferTooltip => 'Contraproposta';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker fez a oferta';
  }

  @override
  String get serviceUpdatedMessage => 'Serviço atualizado';

  @override
  String paymentStatusLabel(Object status) {
    return 'Status do pagamento: $status';
  }

  @override
  String get paymentPendingTitle => 'Pagamento pendente';

  @override
  String get awaitingClientPayment =>
      'Aguardando que o cliente inicie o pagamento deste serviço.';

  @override
  String get proceedToPayment => 'Efetuar pagamento';

  @override
  String get updateStatus => 'Atualizar status';

  @override
  String get paymentRetryInfo =>
      'Sua última tentativa foi recusada. Você pode tentar novamente para que o trabalhador comece.';

  @override
  String get paymentContinueInfo =>
      'Complete o pagamento para confirmar a atribuição do trabalhador.';

  @override
  String get paymentSyncInfo =>
      'Estamos sincronizando as informações do pagamento. Se já pagou, use o botão atualizar nas notificações.';

  @override
  String get servicePublishedMessage => 'Serviço publicado com sucesso';

  @override
  String get deleteServiceTitle => 'Excluir serviço';

  @override
  String get deleteServiceConfirmation =>
      'Tem certeza de que deseja excluir essa publicação?';

  @override
  String get deleteButton => 'Excluir';

  @override
  String get serviceDefaultTitle => 'Serviço';

  @override
  String get myAccount => 'Minha conta';

  @override
  String get serviceFormPublishTitle => 'Publicação de serviços';

  @override
  String get serviceFormEditTitle => 'Editar serviço';

  @override
  String get serviceTitleLabel => 'Título *';

  @override
  String get serviceDescriptionLabel => 'Descrição *';

  @override
  String get serviceLocationLabel => 'Localização *';

  @override
  String get serviceEstimatedDateLabel => 'Data estimada *';

  @override
  String get selectDatePrompt => 'Selecione uma data';

  @override
  String get datePickerHelp => 'Selecione a data estimada';

  @override
  String get titleRequiredError => 'O título não pode ficar em branco';

  @override
  String get descriptionRequiredError => 'A descrição não pode ficar em branco';

  @override
  String get categoryRequiredError => 'Selecione uma categoria';

  @override
  String get locationRequiredError => 'A localização é obrigatória';

  @override
  String get dateInPastError => 'A data não pode ser anterior a hoje';

  @override
  String get invalidCategoryError => 'Categoria inválida';

  @override
  String get requiredFieldsNote => '* Campos obrigatórios';

  @override
  String get saveButton => 'Salvar';

  @override
  String get clientLabel => 'Cliente';

  @override
  String get workerLabel => 'Trabalhador';

  @override
  String get negotiationInNegotiation => 'Em negociação';

  @override
  String get negotiationInProgress => 'Em andamento';

  @override
  String get negotiationAccepted => 'Aceita';

  @override
  String get negotiationRejected => 'Rejeitada';

  @override
  String get negotiationClosed => 'Fechada';

  @override
  String get negotiationPending => 'Pendente';

  @override
  String get serviceStatePending => 'Pendente';

  @override
  String get serviceStatePaymentPending => 'Pagamento pendente';

  @override
  String get serviceStateInProgress => 'Em andamento';

  @override
  String get serviceStateFinished => 'Finalizado';

  @override
  String get serviceStateExpired => 'Expirado';

  @override
  String get paymentStatusPending => 'Pagamento pendente';

  @override
  String get paymentStatusRequiresPaymentMethod => 'Requer outro método';

  @override
  String get paymentStatusRequiresAction => 'Ação necessária';

  @override
  String get paymentStatusSucceeded => 'Pagamento confirmado';

  @override
  String get paymentStatusFailed => 'Pagamento recusado';

  @override
  String get paymentStatusNotRequired => 'Não requer pagamento';

  @override
  String get paymentStatusDefault => 'Pagamento';

  @override
  String get manageAccountLabel => 'Gerenciar conta';

  @override
  String get logoutLabel => 'Sair';

  @override
  String get closeTooltip => 'Fechar';

  @override
  String get profileGreeting => 'Olá!';

  @override
  String profileGreetingWithName(Object name) {
    return 'Olá, $name!';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Atenção: o serviço \"$title\" expira hoje e será removido automaticamente à meia-noite se permanecer pendente.';
  }

  @override
  String get serviceDeletedMessage => 'Serviço excluído';

  @override
  String get serviceDeleteBlockedMessage =>
      'Não é possível excluir um serviço aceito.';

  @override
  String get workerEditAccount => 'Editar conta';

  @override
  String get workerActiveAccount => 'Conta ativa';

  @override
  String get workerInactiveAccount => 'Conta inativa';

  @override
  String get workerHomeTitle => 'Painel do trabalhador';

  @override
  String get workerNoResponses => 'Você não tem novas respostas.';

  @override
  String get workerInvalidAmount => 'Valor inválido';

  @override
  String workerOfferForService(Object title) {
    return 'Ofertar por $title';
  }

  @override
  String get workerPriceProposed => 'Preço proposto';

  @override
  String get workerOfferButton => 'Enviar proposta';

  @override
  String get workerOfferTooltip => 'Enviar uma nova proposta';

  @override
  String get workerOfferDisabled => 'Este serviço não aceita novas propostas';

  @override
  String workerHiddenExpiredPipe(Object count) {
    return '$count solicitações expiradas foram ocultadas.';
  }

  @override
  String get workerNoOpportunities =>
      'Não há oportunidades disponíveis na sua região no momento.';

  @override
  String workerNegotiationLabel(Object status) {
    return 'Negociação: $status';
  }

  @override
  String get workerOfferSent => 'Proposta enviada';

  @override
  String get workerAccountLoadButton => 'Carregar dados da minha conta';

  @override
  String get workerAccountUpdated => 'Dados da conta atualizados';

  @override
  String get workerLoadError =>
      'Não foi possível carregar os dados da sua conta.';

  @override
  String workerClientOfferLabel(Object amount, Object client) {
    return '$client ofereceu $amount';
  }

  @override
  String get workerOpportunitiesTitle => 'Suas oportunidades';

  @override
  String get optionalMessageLabel => 'Mensagem (opcional)';

  @override
  String workerOfferError(Object message) {
    return 'Erro ao enviar a oferta: $message';
  }
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get appTitle => 'Workify';

  @override
  String get welcome => 'Bem-vindo ao Workify';

  @override
  String get subtitle => 'Escolha sua função para continuar';

  @override
  String get roleHint => 'Selecione Trabalhador ou Cliente para avançar';

  @override
  String get workerButton => 'Sou Trabalhador';

  @override
  String get clientButton => 'Sou Cliente';

  @override
  String get selectCountry => 'Selecione um país';

  @override
  String get currencyLabel => 'Moeda atual';

  @override
  String get dateLabel => 'Data local';

  @override
  String countryLabel(Object emoji, Object name) {
    return '$emoji $name';
  }

  @override
  String get loginTitleWorker => 'Entre como Trabalhador';

  @override
  String get loginTitleClient => 'Entre como Cliente';

  @override
  String get loginDescription =>
      'Conecte-se a serviços verificados, pague com segurança e acompanhe em tempo real.';

  @override
  String get loginFeaturePayments => 'Pagamentos seguros';

  @override
  String get loginFeatureIdentity => 'Identidade verificada';

  @override
  String get loginFeatureSupport => 'Suporte e segurança';

  @override
  String get accessTitle => 'Acesso seguro';

  @override
  String get emailLabel => 'E-mail';

  @override
  String get emailEmptyError => 'Informe seu e-mail';

  @override
  String get emailInvalidError => 'E-mail inválido';

  @override
  String get passwordLabel => 'Senha';

  @override
  String get passwordEmptyError => 'Informe sua senha';

  @override
  String get forgotPassword => 'Esqueceu sua senha?';

  @override
  String get loginButton => 'Entrar';

  @override
  String get registerPrompt => 'Não tem conta? Cadastre-se aqui';

  @override
  String get backHome => '⬅️ Voltar ao início';

  @override
  String get unverifiedAccountMessage =>
      'Sua conta não está verificada. Verifique seu e-mail e ative para entrar.';

  @override
  String get understood => 'Entendi';

  @override
  String errorMessage(Object message) {
    return 'Erro: $message';
  }

  @override
  String welcomeUser(Object name) {
    return 'Bem-vindo $name';
  }

  @override
  String get registerTitleClient => 'Crie sua conta';

  @override
  String get registerSubtitleClient =>
      'Conecte-se a profissionais confiáveis e pague com segurança.';

  @override
  String get verifiedIdentity => 'Identidade verificada';

  @override
  String get registerTagProtected => 'Pagamentos protegidos';

  @override
  String get registerTagSupport => 'Suporte 24/7';

  @override
  String get registerTagVerified => 'Serviços verificados';

  @override
  String get personalDataTitle => 'Informações pessoais';

  @override
  String get nameLabel => 'Nome completo';

  @override
  String get nameMinError => 'Informe seu nome (mínimo 3 caracteres)';

  @override
  String get phoneLabel => 'Celular';

  @override
  String get phoneEmptyError => 'Informe seu celular';

  @override
  String get phoneInvalidError => 'Número inválido';

  @override
  String get passwordMinError => 'Mínimo 6 caracteres';

  @override
  String get confirmPasswordLabel => 'Confirme a senha';

  @override
  String get confirmPasswordError => 'Confirme sua senha';

  @override
  String get termsAgreement =>
      'Aceito os termos e condições e a política de privacidade.';

  @override
  String get termsError => 'Você deve aceitar os termos e condições.';

  @override
  String get passwordsMismatch => 'As senhas não coincidem.';

  @override
  String get createAccountButton => 'Criar conta';

  @override
  String get registrationReceived =>
      'Registro recebido. Confira seu e-mail para ativar a conta.';

  @override
  String get unknownError => 'Erro desconhecido. Tente novamente.';

  @override
  String connectionError(Object message) {
    return 'Erro de conexão: $message';
  }

  @override
  String get registerTitleWorker => 'Registro de trabalhador';

  @override
  String get registerSubtitleWorker =>
      'Cadastre seus serviços, defina disponibilidade e conecte-se a clientes.';

  @override
  String get serviceCategoryLabel => 'Categoria *';

  @override
  String get categoriesLoading => 'Carregando categorias...';

  @override
  String get categoriesUnavailable => 'Sem categorias disponíveis';

  @override
  String get selectCategoryPrompt => 'Selecione uma categoria';

  @override
  String get categoryInvalid => 'Categoria selecionada inválida';

  @override
  String get registerButtonWorker => 'Registrar';

  @override
  String get cancelButton => 'Cancelar';

  @override
  String get haveAccountCarryOn => 'Já tem conta? ';

  @override
  String get loginHere => 'Entrar';

  @override
  String categoriesFallback(Object message) {
    return 'Categorias carregadas localmente. Detalhe: $message';
  }

  @override
  String get categoriesLocalFallback =>
      'Não foi possível carregar categorias do servidor. Valores locais foram usados.';

  @override
  String categoriesError(Object message) {
    return 'Não foi possível carregar categorias: $message';
  }

  @override
  String get publishServiceTooltip => 'Publicar serviço';

  @override
  String get notificationsTooltip => 'Notificações';

  @override
  String get refreshTooltip => 'Atualizar';

  @override
  String get optionsTooltip => 'Opções';

  @override
  String get viewMapLabel => 'Ver mapa';

  @override
  String get viewButton => 'Ver';

  @override
  String get expiredServicesTitle => 'Solicitações expiradas';

  @override
  String get noExpiredServices => 'Não há solicitações expiradas.';

  @override
  String get expiredServiceSingle =>
      '1 solicitação expirou e foi ocultada da lista.';

  @override
  String expiredServiceMultiple(Object count) {
    return '$count solicitações expiraram e foram ocultadas da lista.';
  }

  @override
  String expiredServiceDateLabel(Object date) {
    return 'Expirou em $date';
  }

  @override
  String get dateUnavailable => 'Data indisponível';

  @override
  String serviceLabel(Object title) {
    return 'Serviço: $title';
  }

  @override
  String serviceDateLabel(Object date) {
    return 'Data: $date';
  }

  @override
  String serviceStateLabel(Object status) {
    return 'Status: $status';
  }

  @override
  String serviceTurnLabel(Object turn) {
    return 'Vez: $turn';
  }

  @override
  String lastOfferLabel(Object actor) {
    return 'Última oferta: $actor';
  }

  @override
  String currentAmountLabel(Object amount) {
    return 'Valor atual: $amount';
  }

  @override
  String workerProposalLabel(Object amount) {
    return 'Proposta do trabalhador: $amount';
  }

  @override
  String clientOfferLabel(Object amount) {
    return 'Sua oferta: $amount';
  }

  @override
  String get notificationsTitle => 'Notificações';

  @override
  String get pendingPaymentsSection => 'Pagamentos pendentes';

  @override
  String get offersInNegotiationSection => 'Ofertas em negociação';

  @override
  String get noNewOffers => 'Você não tem ofertas novas.';

  @override
  String get offerAcceptedMessage =>
      'Oferta aceita. Complete o pagamento para atribuir o serviço.';

  @override
  String get serviceAssignedMessage => 'Serviço atribuído';

  @override
  String get offerRejectedMessage => 'Oferta rejeitada';

  @override
  String get counterofferTitle => 'Enviar contraproposta';

  @override
  String get counterofferPriceLabel => 'Novo valor';

  @override
  String get counterofferNoteLabel => 'Mensagem (opcional)';

  @override
  String get enterValidAmount => 'Digite um valor válido';

  @override
  String get sendButton => 'Enviar';

  @override
  String get counterofferSent => 'Contraproposta enviada';

  @override
  String get acceptTooltip => 'Aceitar';

  @override
  String get rejectTooltip => 'Rejeitar';

  @override
  String get counterofferTooltip => 'Contraproposta';

  @override
  String workerOfferLabel(Object worker) {
    return '$worker fez a oferta';
  }

  @override
  String get serviceUpdatedMessage => 'Serviço atualizado';

  @override
  String paymentStatusLabel(Object status) {
    return 'Status do pagamento: $status';
  }

  @override
  String get paymentPendingTitle => 'Pagamento pendente';

  @override
  String get awaitingClientPayment =>
      'Aguardando que o cliente inicie o pagamento deste serviço.';

  @override
  String get proceedToPayment => 'Efetuar pagamento';

  @override
  String get updateStatus => 'Atualizar status';

  @override
  String get paymentRetryInfo =>
      'Sua última tentativa foi recusada. Você pode tentar novamente para que o trabalhador comece.';

  @override
  String get paymentContinueInfo =>
      'Complete o pagamento para confirmar a atribuição do trabalhador.';

  @override
  String get paymentSyncInfo =>
      'Estamos sincronizando as informações do pagamento. Se já pagou, use o botão atualizar nas notificações.';

  @override
  String get servicePublishedMessage => 'Serviço publicado com sucesso';

  @override
  String get deleteServiceTitle => 'Excluir serviço';

  @override
  String get deleteServiceConfirmation =>
      'Tem certeza de que deseja excluir essa publicação?';

  @override
  String get deleteButton => 'Excluir';

  @override
  String get serviceDefaultTitle => 'Serviço';

  @override
  String get myAccount => 'Minha conta';

  @override
  String get serviceFormPublishTitle => 'Publicação de serviços';

  @override
  String get serviceFormEditTitle => 'Editar serviço';

  @override
  String get serviceTitleLabel => 'Título *';

  @override
  String get serviceDescriptionLabel => 'Descrição *';

  @override
  String get serviceLocationLabel => 'Localização *';

  @override
  String get serviceEstimatedDateLabel => 'Data estimada *';

  @override
  String get selectDatePrompt => 'Selecione uma data';

  @override
  String get datePickerHelp => 'Selecione a data estimada';

  @override
  String get titleRequiredError => 'O título não pode ficar em branco';

  @override
  String get descriptionRequiredError => 'A descrição não pode ficar em branco';

  @override
  String get categoryRequiredError => 'Selecione uma categoria';

  @override
  String get locationRequiredError => 'A localização é obrigatória';

  @override
  String get dateInPastError => 'A data não pode ser anterior a hoje';

  @override
  String get invalidCategoryError => 'Categoria inválida';

  @override
  String get requiredFieldsNote => '* Campos obrigatórios';

  @override
  String get saveButton => 'Salvar';

  @override
  String get clientLabel => 'Cliente';

  @override
  String get workerLabel => 'Trabalhador';

  @override
  String get negotiationInNegotiation => 'Em negociação';

  @override
  String get negotiationInProgress => 'Em andamento';

  @override
  String get negotiationAccepted => 'Aceita';

  @override
  String get negotiationRejected => 'Rejeitada';

  @override
  String get negotiationClosed => 'Fechada';

  @override
  String get negotiationPending => 'Pendente';

  @override
  String get serviceStatePending => 'Pendente';

  @override
  String get serviceStatePaymentPending => 'Pagamento pendente';

  @override
  String get serviceStateInProgress => 'Em andamento';

  @override
  String get serviceStateFinished => 'Finalizado';

  @override
  String get serviceStateExpired => 'Expirado';

  @override
  String get paymentStatusPending => 'Pagamento pendente';

  @override
  String get paymentStatusRequiresPaymentMethod => 'Requer outro método';

  @override
  String get paymentStatusRequiresAction => 'Ação necessária';

  @override
  String get paymentStatusSucceeded => 'Pagamento confirmado';

  @override
  String get paymentStatusFailed => 'Pagamento recusado';

  @override
  String get paymentStatusNotRequired => 'Não requer pagamento';

  @override
  String get paymentStatusDefault => 'Pagamento';

  @override
  String get manageAccountLabel => 'Gerenciar conta';

  @override
  String get logoutLabel => 'Sair';

  @override
  String get closeTooltip => 'Fechar';

  @override
  String get profileGreeting => 'Olá!';

  @override
  String profileGreetingWithName(Object name) {
    return 'Olá, $name!';
  }

  @override
  String serviceExpirationWarning(Object title) {
    return 'Atenção: o serviço \"$title\" expira hoje e será removido automaticamente à meia-noite se permanecer pendente.';
  }

  @override
  String get serviceDeletedMessage => 'Serviço excluído';

  @override
  String get serviceDeleteBlockedMessage =>
      'Não é possível excluir um serviço aceito.';

  @override
  String get workerEditAccount => 'Editar conta';

  @override
  String get workerActiveAccount => 'Conta ativa';

  @override
  String get workerInactiveAccount => 'Conta inativa';

  @override
  String get workerHomeTitle => 'Painel do trabalhador';

  @override
  String get workerNoResponses => 'Você não tem novas respostas.';

  @override
  String get workerInvalidAmount => 'Valor inválido';

  @override
  String workerOfferForService(Object title) {
    return 'Ofertar por $title';
  }

  @override
  String get workerPriceProposed => 'Preço proposto';

  @override
  String get workerOfferButton => 'Enviar proposta';

  @override
  String get workerOfferTooltip => 'Enviar uma nova proposta';

  @override
  String get workerOfferDisabled => 'Este serviço não aceita novas propostas';

  @override
  String workerHiddenExpiredPipe(Object count) {
    return '$count solicitações expiradas foram ocultadas.';
  }

  @override
  String get workerNoOpportunities =>
      'Não há oportunidades disponíveis na sua região no momento.';

  @override
  String workerNegotiationLabel(Object status) {
    return 'Negociação: $status';
  }

  @override
  String get workerOfferSent => 'Proposta enviada';

  @override
  String get workerAccountLoadButton => 'Carregar dados da minha conta';

  @override
  String get workerAccountUpdated => 'Dados da conta atualizados';

  @override
  String get workerLoadError =>
      'Não foi possível carregar os dados da sua conta.';

  @override
  String workerClientOfferLabel(Object amount, Object client) {
    return '$client ofereceu $amount';
  }

  @override
  String get workerOpportunitiesTitle => 'Suas oportunidades';

  @override
  String get optionalMessageLabel => 'Mensagem (opcional)';

  @override
  String workerOfferError(Object message) {
    return 'Erro ao enviar a oferta: $message';
  }
}
