import 'package:flutter/material.dart';
import 'package:flutter_applicatiomconecta2/l10n/app_localizations.dart';

import '../services/api_service.dart'; // <-- ajusta la ruta si es distinta
import '../utils/categories.dart';

class RegisterWorkerPage extends StatefulWidget {
  const RegisterWorkerPage({super.key});

  @override
  State<RegisterWorkerPage> createState() => _RegisterWorkerPageState();
}

class _RegisterWorkerPageState extends State<RegisterWorkerPage> {
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

  List<String> _categories = [];
  bool _categoriesLoading = false;
  String? _categoriesError;
  String? _selectedCategory;
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

  void _clearFieldErrors() => setState(() => fieldErrors = {});

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _categoriesLoading = true;
      _categoriesError = null;
    });

    try {
      final list = await ApiService.getPublicServiceCategories();
      if (!mounted) return;
      final deduped = List<String>.from(list.toSet());
      deduped.sort((a, b) => categoryDisplayLabel(a).compareTo(categoryDisplayLabel(b)));
      setState(() {
        _categories = deduped;
        _categoriesLoading = false;
        if (!_categories.contains(_selectedCategory)) {
          _selectedCategory = null;
        }
      });
    } catch (e) {
      if (!mounted) return;
      final msg = e.toString();
      final l10n = AppLocalizations.of(context)!;
      final fallback = List<String>.from(kServiceCategoryLabels.keys);
      fallback.sort((a, b) => categoryDisplayLabel(a).compareTo(categoryDisplayLabel(b)));
      setState(() {
        _categories = fallback;
        _categoriesLoading = false;
        if (!_categories.contains(_selectedCategory)) {
          _selectedCategory = null;
        }
        _categoriesError = fallback.isEmpty
            ? l10n.categoriesError(msg)
            : l10n.categoriesFallback(msg);
      });
      if (fallback.isEmpty) {
        _showSnack(l10n.categoriesError(msg));
      } else {
        _showSnack(l10n.categoriesLocalFallback);
      }
    }
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
    if (_categoriesLoading) {
      _showSnack(l10n.categoriesLoading);
      return;
    }
    if (_categories.isEmpty) {
      _showSnack(l10n.categoriesUnavailable);
      return;
    }
    if (_selectedCategory == null || _selectedCategory!.isEmpty) {
      _showSnack(l10n.selectCategoryPrompt);
      return;
    }

    final categoriaEnum = normalizeCategoryValue(_selectedCategory);
    if (categoriaEnum.isEmpty) {
      _showSnack(l10n.categoryInvalid);
      return;
    }

    setState(() {
      _loading = true;
      _selectedCategory = categoriaEnum;
    });

    try {
      final resp = await ApiService.registerWorker(
        nombreCompleto: _nameCtrl.text.trim(),
        correo: _emailCtrl.text.trim(),
        celular: _phoneCtrl.text.trim(),
        categoriaServicio: categoriaEnum,
        contrasena: _passCtrl.text,
        confirmarContrasena: _confirmCtrl.text,
      );

      final msg = (resp['mensaje'] as String?) ?? l10n.registrationReceived;
      _showSnack(msg, background: Colors.green);
      await Future.delayed(const Duration(milliseconds: 800));
      if (!mounted) return;
      Navigator.pushReplacementNamed(context, "/login", arguments: {"role": "worker"});
    } catch (e) {
      _showSnack(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                          Text(
                            l10n.registerTitleWorker,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            l10n.registerSubtitleWorker,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 14),
                          DropdownButtonFormField<String>(
                            value: _selectedCategory,
                            items: _categories
                                .map(
                                  (c) => DropdownMenuItem(
                                    value: c,
                                    child: Text(categoryDisplayLabel(c)),
                                  ),
                                )
                                .toList(),
                            onChanged: (_categoriesLoading || _loading)
                                ? null
                                : (value) => setState(
                                      () => _selectedCategory = value == null
                                          ? null
                                          : normalizeCategoryValue(value),
                                    ),
                            decoration: InputDecoration(
                              labelText: l10n.serviceCategoryLabel,
                              prefixIcon: const Icon(Icons.build),
                            ),
                            validator: (value) {
                              if (_categoriesLoading) return l10n.categoriesLoading;
                              if (_categories.isEmpty) return l10n.categoriesUnavailable;
                              if (value == null || value.isEmpty) return l10n.selectCategoryPrompt;
                              return null;
                            },
                          ),
                          if (_categoriesLoading)
                            const Padding(
                              padding: EdgeInsets.only(top: 6.0),
                              child: LinearProgressIndicator(minHeight: 3),
                            ),
                          if (_categoriesError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0, left: 6.0),
                              child: Text(
                                _categoriesError!,
                                style: const TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                          _fieldError("categoriaServicio"),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Checkbox(
                                value: _termsAccepted,
                                onChanged: (v) => setState(() => _termsAccepted = v ?? false),
                              ),
                              Expanded(
                                child: Text(l10n.termsAgreement),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
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
                                  : Text(l10n.registerButtonWorker),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                              child: Text(l10n.cancelButton),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(l10n.haveAccountCarryOn),
                              InkWell(
                                onTap: _loading
                                    ? null
                                    : () => Navigator.pushReplacementNamed(
                                          context,
                                          "/login",
                                          arguments: {"role": "worker"},
                                        ),
                                child: Text(
                                  l10n.loginHere,
                                  style: const TextStyle(
                                    color: primary,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/", (r) => false),
                            child: Text(l10n.backHome),
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
