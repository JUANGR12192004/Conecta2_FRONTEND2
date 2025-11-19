import 'package:flutter/material.dart';
import 'package:flutter_applicatiomconecta2/l10n/app_localizations.dart';

import '../services/api_service.dart';
import '../ui/theme/app_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;
  bool _obscure = true;
  late String _role; // "worker" | "client"

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final raw = (args?['role'] as String?)?.toLowerCase().trim();
    _role = (raw == 'worker' || raw == 'client') ? raw! : 'client';
  }

  Color get primary =>
      _role == 'worker' ? const Color(0xFF0B8AD9) : AppColors.primary;
  Color get secondary =>
      _role == 'worker' ? const Color(0xFF19C3FF) : const Color(0xFF00D7B0);

  String title(AppLocalizations l10n) => _role == 'worker'
      ? l10n.loginTitleWorker
      : l10n.loginTitleClient;

  int? _extractUserId(Map<String, dynamic> payload) {
    const candidates = [
      'id',
      'userId',
      'usuarioId',
      'clienteId',
      'trabajadorId',
    ];
    for (final key in candidates) {
      final value = payload[key];
      if (value == null) continue;
      if (value is int) return value;
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) return parsed;
      }
    }
    return null;
  }

  void _showUnverifiedBanner(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearMaterialBanners();
    messenger.showMaterialBanner(
      MaterialBanner(
        content: Text(AppLocalizations.of(context)!.unverifiedAccountMessage),
        leading: const Icon(Icons.info_outline),
        backgroundColor: Colors.amber.shade100,
        actions: [
          TextButton(
            onPressed: () => messenger.hideCurrentMaterialBanner(),
            child: Text(AppLocalizations.of(context)!.understood),
          ),
        ],
      ),
    );
  }

  Future<void> _doLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    try {
      Map<String, dynamic> resp;
      if (_role == 'worker') {
        resp = await ApiService.loginWorker(
          correo: _emailCtrl.text.trim(),
          contrasena: _passwordCtrl.text,
        );
      } else {
        resp = await ApiService.loginClient(
          correo: _emailCtrl.text.trim(),
          contrasena: _passwordCtrl.text,
        );
      }

      if (!mounted) return;
      final nombre = resp['nombreCompleto'] ?? resp['nombre'] ?? '';
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            l10n.welcomeUser(nombre.isNotEmpty ? nombre : l10n.appTitle),
          ),
          backgroundColor: primary,
          behavior: SnackBarBehavior.floating,
        ),
      );

      final route = _role == 'worker' ? '/workerHome' : '/clientHome';
      final args = <String, dynamic>{"role": _role, "profile": resp};
      final userId = _extractUserId(resp);
      if (userId != null) args["userId"] = userId;

      Navigator.pushReplacementNamed(context, route, arguments: args);
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString();
      final noVerificada = msg.toLowerCase().contains("no verificada");
      final l10n = AppLocalizations.of(context)!;

      if (noVerificada && _role == 'worker') {
        _showUnverifiedBanner(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorMessage(e.toString())),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _goToRegister() {
    if (_role == 'worker') {
      Navigator.pushNamed(context, "/registerWorker");
    } else {
      Navigator.pushNamed(context, "/registerClient");
    }
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final featureItems = [
      _FeatureItem(Icons.lock_outline, l10n.loginFeaturePayments),
      _FeatureItem(Icons.verified_user, l10n.loginFeatureIdentity),
      _FeatureItem(Icons.shield, l10n.loginFeatureSupport),
    ];

    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary, secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white.withOpacity(0.15),
                          child: Icon(
                            _role == 'worker' ? Icons.handyman : Icons.emoji_people,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          title(l10n),
                          style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.loginDescription,
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: featureItems
                          .map(
                            (item) => Chip(
                              avatar: Icon(item.icon, size: 18, color: primary),
                              label: Text(item.label),
                              backgroundColor: Colors.white,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 18),
                    Card(
                      elevation: 8,
                      shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                      _role == 'worker'
                                          ? Icons.construction
                                          : Icons.home_repair_service,
                                      color: primary),
                                  const SizedBox(width: 10),
                                  Text(l10n.accessTitle,
                                      style: theme.textTheme.titleMedium),
                                ],
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _emailCtrl,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: l10n.emailLabel,
                                  prefixIcon: const Icon(Icons.email_outlined),
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return l10n.emailEmptyError;
                                  }
                                  final rx = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                                  if (!rx.hasMatch(v.trim())) {
                                    return l10n.emailInvalidError;
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),
                              TextFormField(
                                controller: _passwordCtrl,
                                obscureText: _obscure,
                                decoration: InputDecoration(
                                  labelText: l10n.passwordLabel,
                                  prefixIcon: const Icon(Icons.lock_outline),
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(() => _obscure = !_obscure),
                                    icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
                                  ),
                                ),
                                validator: (v) =>
                                    (v == null || v.isEmpty) ? l10n.passwordEmptyError : null,
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(l10n.forgotPassword),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  onPressed: _loading ? null : _doLogin,
                                  child: _loading
                                      ? const SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(l10n.loginButton),
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextButton(
                                onPressed: _goToRegister,
                                child: Text(l10n.registerPrompt),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    "/",
                                    (route) => false,
                                  );
                                },
                                child: Text(l10n.backHome),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String label;

  const _FeatureItem(this.icon, this.label);
}
