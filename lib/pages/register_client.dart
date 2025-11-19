import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_applicatiomconecta2/l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

import '../ui/theme/app_theme.dart';

/// Página de registro para CLIENTE con estilo renovado
class RegisterClientPage extends StatefulWidget {
  const RegisterClientPage({super.key});

  @override
  State<RegisterClientPage> createState() => _RegisterClientPageState();
}

class _RegisterClientPageState extends State<RegisterClientPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  bool _termsAccepted = false;
  bool _loading = false;
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  Map<String, String> fieldErrors = {};
  final String baseHost = "http://localhost:8080";
  String get registerUrl => "/api/v1/auth/clients/register";

  void _showSnack(String message, {Color? background}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: background ?? Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _clearFieldErrors() => setState(() => fieldErrors = {});

  Widget _fieldError(String key) {
    final msg = fieldErrors[key];
    if (msg == null || msg.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 6.0),
      child: Text(msg, style: const TextStyle(color: Colors.red, fontSize: 12)),
    );
  }

  Future<void> _register() async {
    final l10n = AppLocalizations.of(context)!;
    _clearFieldErrors();

    if (!_formKey.currentState!.validate()) return;
    if (!_termsAccepted) {
      _showSnack(l10n.termsError);
      return;
    }
    if (_passCtrl.text != _confirmCtrl.text) {
      _showSnack(l10n.passwordsMismatch);
      return;
    }

    setState(() => _loading = true);

    final payload = {
      "nombreCompleto": _nameCtrl.text.trim(),
      "correo": _emailCtrl.text.trim(),
      "contrasena": _passCtrl.text,
      "confirmarContrasena": _confirmCtrl.text,
      "celular": _phoneCtrl.text.trim(),
    };

    try {
      final uri = Uri.parse(registerUrl);
      final response = await http
          .post(uri, headers: {"Content-Type": "application/json"}, body: jsonEncode(payload))
          .timeout(const Duration(seconds: 15));

      if (!mounted) return;

      if (response.statusCode == 200 || response.statusCode == 201) {
        var msg = l10n.registrationReceived;
        try {
          final data = jsonDecode(response.body);
          if (data["mensaje"] is String) msg = data["mensaje"] as String;
        } catch (_) {}

        _showSnack(msg, background: Colors.green);
        await Future.delayed(const Duration(milliseconds: 900));
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, "/login", arguments: {"role": "client"});
        return;
      }

      final content = response.body;
      dynamic decoded;
      try {
        decoded = jsonDecode(content);
      } catch (_) {
        decoded = null;
      }

      if (decoded is Map && decoded.containsKey("errores")) {
        final parsed = <String, String>{};
        for (var e in decoded["errores"] as List<dynamic>) {
          if (e is String && e.contains(":")) {
            final parts = e.split(":");
            final key = parts[0].trim();
            final msg = parts.sublist(1).join(":").trim();
            parsed[key] = msg;
          } else if (e is String) {
            _showSnack(e);
          }
        }
        setState(() => fieldErrors = parsed);
        if (decoded.containsKey("mensaje")) {
          _showSnack(decoded["mensaje"].toString());
        }
        return;
      }

      if (decoded is Map && decoded.containsKey("mensaje")) {
        _showSnack(decoded["mensaje"].toString());
        return;
      }

      if (content.isNotEmpty) {
        _showSnack(content);
        return;
      }

      _showSnack(l10n.unknownError);
    } on http.ClientException catch (e) {
      _showSnack(l10n.connectionError(e.message ?? e.toString()));
    } on Exception catch (e) {
      _showSnack(l10n.errorMessage(e.toString()));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.registerTitleClient, style: theme.textTheme.headlineSmall),
                  Chip(
                    avatar: const Icon(Icons.verified, color: AppColors.primary, size: 18),
                    label: Text(l10n.verifiedIdentity),
                    backgroundColor: AppColors.surface,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(l10n.registerSubtitleClient, style: theme.textTheme.bodyMedium),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _Tag(text: l10n.registerTagProtected, icon: Icons.lock_outline),
                  _Tag(text: l10n.registerTagSupport, icon: Icons.support_agent),
                  _Tag(text: l10n.registerTagVerified, icon: Icons.shield_moon_outlined),
                ],
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.personalDataTitle, style: theme.textTheme.titleMedium),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _nameCtrl,
                          decoration: InputDecoration(
                            labelText: l10n.nameLabel,
                            prefixIcon: const Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().length < 3) {
                              return l10n.nameMinError;
                            }
                            return null;
                          },
                        ),
                        _fieldError("nombreCompleto"),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailCtrl,
                          decoration: InputDecoration(
                            labelText: l10n.emailLabel,
                            prefixIcon: const Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) return l10n.emailEmptyError;
                            final regex = RegExp(r"^[^@]+@[^@]+\.[^@]+");
                            if (!regex.hasMatch(value)) return l10n.emailInvalidError;
                            return null;
                          },
                        ),
                        _fieldError("correo"),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _phoneCtrl,
                          decoration: InputDecoration(
                            labelText: l10n.phoneLabel,
                            prefixIcon: const Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) return l10n.phoneEmptyError;
                            if (value.length < 7) return l10n.phoneInvalidError;
                            return null;
                          },
                        ),
                        _fieldError("celular"),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _passCtrl,
                          obscureText: _obscurePass,
                          decoration: InputDecoration(
                            labelText: l10n.passwordLabel,
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePass ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _obscurePass = !_obscurePass),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) return l10n.passwordMinError;
                            return null;
                          },
                        ),
                        _fieldError("contrasena"),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _confirmCtrl,
                          obscureText: _obscureConfirm,
                          decoration: InputDecoration(
                            labelText: l10n.confirmPasswordLabel,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return l10n.confirmPasswordError;
                            return null;
                          },
                        ),
                        _fieldError("confirmarContrasena"),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Checkbox(
                              value: _termsAccepted,
                              onChanged: (val) => setState(() => _termsAccepted = val ?? false),
                            ),
                            Expanded(
                              child: Text(l10n.termsAgreement),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: _loading ? null : _register,
                            child: _loading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(l10n.createAccountButton),
                          ),
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
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  final IconData icon;
  const _Tag({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
