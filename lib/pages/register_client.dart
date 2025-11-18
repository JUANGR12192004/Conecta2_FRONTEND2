import 'dart:convert';
import 'package:flutter/material.dart';
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

  // Controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  bool _termsAccepted = false;
  bool _loading = false;
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  // Errores específicos por campo devueltos por el backend
  Map<String, String> fieldErrors = {};

  // Cambia host si ejecutas en emulador Android (10.0.2.2) o IP de tu PC
  final String baseHost = "http://localhost:8080";
  String get registerUrl => "$baseHost/api/v1/auth/clients/register";

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

  // Muestra error específico bajo cada TextFormField
  Widget _fieldError(String key) {
    final msg = fieldErrors[key];
    if (msg == null || msg.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 6.0),
      child: Text(msg, style: const TextStyle(color: Colors.red, fontSize: 12)),
    );
  }

  Future<void> _register() async {
    _clearFieldErrors();

    if (!_formKey.currentState!.validate()) return;
    if (!_termsAccepted) {
      _showSnack("Debes aceptar los términos y condiciones.");
      return;
    }
    if (_passCtrl.text != _confirmCtrl.text) {
      _showSnack("Las contraseñas no coinciden.");
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
        String msg = "Registro recibido. Revisa tu correo para activar la cuenta.";
        try {
          final Map<String, dynamic> data = jsonDecode(response.body);
          if (data["mensaje"] is String) msg = data["mensaje"];
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
        final List<dynamic> errores = decoded["errores"];
        final Map<String, String> parsed = {};
        for (var e in errores) {
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
          _showSnack(decoded["mensaje"]);
        }
        return;
      }

      if (decoded is Map && decoded.containsKey("mensaje")) {
        _showSnack(decoded["mensaje"]);
        return;
      }

      if (content.isNotEmpty) {
        _showSnack(content);
        return;
      }

      _showSnack("Error desconocido: ${response.statusCode}");
    } on http.ClientException catch (e) {
      _showSnack("Error de conexión: ${e.message}");
    } on Exception catch (e) {
      _showSnack("Ocurrió un error: $e");
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
                  Text("Crea tu cuenta", style: theme.textTheme.headlineSmall),
                  Chip(
                    avatar: const Icon(Icons.verified, color: AppColors.primary, size: 18),
                    label: const Text("Identidad verificada"),
                    backgroundColor: AppColors.surface,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "Conecta con trabajadores confiables y paga seguro.",
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: const [
                  _Tag(text: "Pagos protegidos", icon: Icons.lock_outline),
                  _Tag(text: "Soporte 24/7", icon: Icons.support_agent),
                  _Tag(text: "Servicios verificados", icon: Icons.shield_moon_outlined),
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
                        Text("Datos personales", style: theme.textTheme.titleMedium),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _nameCtrl,
                          decoration: const InputDecoration(
                            labelText: "Nombre completo",
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().length < 3) {
                              return "Ingresa tu nombre (mínimo 3 caracteres)";
                            }
                            return null;
                          },
                        ),
                        _fieldError("nombreCompleto"),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _emailCtrl,
                          decoration: const InputDecoration(
                            labelText: "Correo electrónico",
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Ingresa tu correo";
                            final regex = RegExp(r"^[^@]+@[^@]+\.[^@]+");
                            if (!regex.hasMatch(value)) return "Correo inválido";
                            return null;
                          },
                        ),
                        _fieldError("correo"),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _phoneCtrl,
                          decoration: const InputDecoration(
                            labelText: "Celular",
                            prefixIcon: Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Ingresa tu celular";
                            if (value.length < 7) return "Número inválido";
                            return null;
                          },
                        ),
                        _fieldError("celular"),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _passCtrl,
                          obscureText: _obscurePass,
                          decoration: InputDecoration(
                            labelText: "Contraseña",
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePass ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _obscurePass = !_obscurePass),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.length < 6) return "Mínimo 6 caracteres";
                            return null;
                          },
                        ),
                        _fieldError("contrasena"),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _confirmCtrl,
                          obscureText: _obscureConfirm,
                          decoration: InputDecoration(
                            labelText: "Confirmar contraseña",
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                              onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Confirma tu contraseña";
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
                            const Expanded(
                              child: Text("Acepto los términos y condiciones y la política de privacidad."),
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
                                : const Text("Crear cuenta"),
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
