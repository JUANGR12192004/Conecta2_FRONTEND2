import 'package:flutter/material.dart';
import '../services/api_service.dart'; // <-- ajusta la ruta si es distinta

class RegisterWorkerPage extends StatefulWidget {
  const RegisterWorkerPage({super.key});

  @override
  State<RegisterWorkerPage> createState() => _RegisterWorkerPageState();
}

class _RegisterWorkerPageState extends State<RegisterWorkerPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _serviceCtrl = TextEditingController();

  bool _termsAccepted = false;
  bool _loading = false;
  bool _obscurePass = true;
  bool _obscureConfirm = true;

  // Si en el futuro decides mapear errores por campo
  Map<String, String> fieldErrors = {};

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

  void _clearFieldErrors() {
    setState(() => fieldErrors = {});
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

    try {
      final resp = await ApiService.registerWorker(
        nombreCompleto: _nameCtrl.text.trim(),
        correo: _emailCtrl.text.trim(),
        celular: _phoneCtrl.text.trim(),
        areaServicio: _serviceCtrl.text.trim(),
        contrasena: _passCtrl.text,
        confirmarContrasena: _confirmCtrl.text,
      );

      // Mensaje del backend o mensaje por defecto
      final msg = (resp['mensaje'] as String?) ??
          "Registro recibido. Revisa tu correo para activar la cuenta ✅";

      _showSnack(msg, background: Colors.green);

      // Pequeña pausa para que vea el SnackBar
      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;

      // Ir a login con el rol preseleccionado
      Navigator.pushReplacementNamed(
        context,
        "/login",
        arguments: {"role": "worker"},
      );
    } catch (e) {
      // ApiService lanza Exception con mensaje amigable (p.ej. 400/401/403)
      _showSnack(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // Widget de error por campo (si luego quieres mapearlos)
  Widget _fieldError(String key) {
    final msg = fieldErrors[key];
    if (msg == null || msg.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 6.0, left: 6.0),
      child: Text(msg, style: const TextStyle(color: Colors.red, fontSize: 12)),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    _phoneCtrl.dispose();
    _serviceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Paleta estilo trabajador (azul) pero con mismos patrones de UI del cliente
    const Color primary = Color(0xFF1E88E5);
    const Color secondary = Color(0xFF64B5F6);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primary, secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const Icon(Icons.work, size: 56, color: primary),
                          const SizedBox(height: 12),
                          const Text(
                            "Registro de trabajador",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 24),

                          // Nombre completo
                          TextFormField(
                            controller: _nameCtrl,
                            decoration: const InputDecoration(
                              labelText: "Nombre completo",
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? "Ingresa tu nombre" : null,
                          ),
                          _fieldError("nombreCompleto"),
                          const SizedBox(height: 14),

                          // Correo electrónico
                          TextFormField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: "Correo electrónico",
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) return "Ingresa tu correo";
                              final rx = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                              if (!rx.hasMatch(v.trim())) return "Correo inválido";
                              return null;
                            },
                          ),
                          _fieldError("correo"),
                          const SizedBox(height: 14),

                          // Contraseña
                          TextFormField(
                            controller: _passCtrl,
                            obscureText: _obscurePass,
                            decoration: InputDecoration(
                              labelText: "Contraseña",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => _obscurePass = !_obscurePass),
                                icon: Icon(_obscurePass ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Ingresa tu contraseña";
                              }
                              if (v.length < 8) {
                                return "La contraseña debe tener al menos 8 caracteres";
                              }
                              final rx = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).+$');
                              if (!rx.hasMatch(v)) {
                                return "Debe incluir mayúsculas, minúsculas, números y un carácter especial";
                              }
                              return null;
                            },
                          ),
                          _fieldError("contrasena"),
                          const SizedBox(height: 14),

                          // Confirmar contraseña
                          TextFormField(
                            controller: _confirmCtrl,
                            obscureText: _obscureConfirm,
                            decoration: InputDecoration(
                              labelText: "Confirmar contraseña",
                              prefixIcon: const Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                                icon: Icon(_obscureConfirm ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) return "Confirma tu contraseña";
                              if (v != _passCtrl.text) return "Las contraseñas no coinciden";
                              return null;
                            },
                          ),
                          _fieldError("confirmarContrasena"),
                          const SizedBox(height: 14),

                          // Número de celular
                          TextFormField(
                            controller: _phoneCtrl,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: "Número de celular",
                              prefixIcon: Icon(Icons.phone),
                            ),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? "Ingresa tu número de celular" : null,
                          ),
                          _fieldError("celular"),
                          const SizedBox(height: 14),

                          // Área de servicio
                          TextFormField(
                            controller: _serviceCtrl,
                            decoration: const InputDecoration(
                              labelText: "Área de servicio",
                              prefixIcon: Icon(Icons.build),
                            ),
                            validator: (v) =>
                                (v == null || v.trim().isEmpty) ? "Ingresa tu área de servicio" : null,
                          ),
                          _fieldError("areaServicio"),
                          const SizedBox(height: 10),

                          // Términos
                          Row(
                            children: [
                              Checkbox(
                                value: _termsAccepted,
                                onChanged: (v) => setState(() => _termsAccepted = v ?? false),
                              ),
                              const Expanded(
                                child: Text("Acepto términos y condiciones"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Botón registrar
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _loading ? null : _register,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: _loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text("Registrarse"),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Botón cancelar
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: _loading ? null : () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text("Cancelar"),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Ya tienes cuenta
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              const Text("¿Ya tienes cuenta? "),
                              InkWell(
                                onTap: _loading
                                    ? null
                                    : () => Navigator.pushReplacementNamed(
                                          context,
                                          "/login",
                                          arguments: {"role": "worker"},
                                        ),
                                child: const Text(
                                  "Inicia sesión",
                                  style: TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Volver al inicio (cambiar rol)
                          TextButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false),
                            child: const Text("⬅️ Volver al inicio"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
