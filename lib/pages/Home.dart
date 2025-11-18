import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedRole; // "client" o "worker"

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00B59A), Color(0xFF0B8AD9)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.white.withOpacity(0.12),
                            child: Image.asset(
                              "assets/LogoConecta2.png",
                              height: 56,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Chip(
                          backgroundColor: Colors.white.withOpacity(0.12),
                          label: const Text(
                            "Pagos seguros · Identidad verificada",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 22),
                    Text(
                      "Conecta rápido con\ntrabajadores de confianza",
                      style: theme.textTheme.headlineLarge?.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Solicita oficios verificados, paga seguro y sigue tu servicio en tiempo real.",
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 26),
                    _RoleCard(
                      title: "Soy Cliente",
                      subtitle: "Encuentra profesionales verificados y paga con total seguridad.",
                      icon: Icons.verified_user,
                      accent: Colors.white,
                      onTap: () {
                        setState(() => selectedRole = "client");
                        Navigator.pushNamed(
                          context,
                          "/login",
                          arguments: {"role": "client"},
                        );
                      },
                    ),
                    const SizedBox(height: 14),
                    _RoleCard(
                      title: "Soy Trabajador",
                      subtitle: "Recibe solicitudes confiables y cobra de forma segura.",
                      icon: Icons.handyman,
                      accent: Colors.white70,
                      onTap: () {
                        setState(() => selectedRole = "worker");
                        Navigator.pushNamed(
                          context,
                          "/login",
                          arguments: {"role": "worker"},
                        );
                      },
                    ),
                    const SizedBox(height: 28),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: const [
                        _Pill(text: "Pagos protegidos", icon: Icons.lock_outline),
                        _Pill(text: "Identidad verificada", icon: Icons.verified),
                        _Pill(text: "Soporte 24/7", icon: Icons.support_agent),
                      ],
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

class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(subtitle, style: theme.textTheme.bodyMedium),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: theme.colorScheme.primary),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final String text;
  final IconData icon;
  const _Pill({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 6),
          Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
