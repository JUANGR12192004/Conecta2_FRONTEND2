import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/locale_provider.dart';
import 'package:flutter_applicatiomconecta2/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedRole; // "client" o "worker"

  List<Color> _gradientColorsForRole() {
    if (selectedRole == "worker") {
      return const [Color(0xFF0B4E9E), Color(0xFF4C8DFF)];
    }
    if (selectedRole == "client") {
      return const [Color(0xFF00796B), Color(0xFF00897B)];
    }
    return const [Color(0xFF00B59A), Color(0xFF0B8AD9)];
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = context.watch<LocaleProvider>();
    final localizations = AppLocalizations.of(context)!;
    final gradientColors = _gradientColorsForRole();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(localizations.appTitle),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: _CountrySelector(
              provider: localeProvider,
              tooltip: localizations.selectCountry,
            ),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 520),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Image.asset(
                      "assets/LogoConecta2.png",
                      height: 100,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      localizations.welcome,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      localizations.subtitle,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withOpacity(0.88),
                          ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      localizations.roleHint,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.white70,
                          ),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => selectedRole = "client");
                        Navigator.pushNamed(
                          context,
                          "/login",
                          arguments: {"role": "client"},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal.shade900,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(localizations.clientButton),
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () {
                        setState(() => selectedRole = "worker");
                        Navigator.pushNamed(
                          context,
                          "/login",
                          arguments: {"role": "worker"},
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white70,
                        foregroundColor: Colors.blue.shade900,
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Text(localizations.workerButton),
                    ),
                    const SizedBox(height: 32),
                    Card(
                      color: Colors.white.withOpacity(0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  localizations.currencyLabel,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  localeProvider.formatCurrency(1281.75),
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  localizations.dateLabel,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  localeProvider.formatDate(DateTime.now()),
                                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              localizations.countryLabel(
                                  localeProvider.selectedCountry.emoji,
                                  localeProvider.selectedCountry.name),
                              style: const TextStyle(color: Colors.white70),
                              textAlign: TextAlign.right,
                            ),
                          ],
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

class _CountrySelector extends StatelessWidget {
  const _CountrySelector({
    required this.provider,
    required this.tooltip,
  });

  final LocaleProvider provider;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CountryOption>(
      tooltip: tooltip,
      iconSize: 40,
      icon: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.15),
        child: Text(
          provider.selectedCountry.emoji,
          style: const TextStyle(fontSize: 22),
        ),
      ),
      onSelected: provider.updateCountry,
      itemBuilder: (context) {
        return provider.countries
            .map(
              (country) => PopupMenuItem<CountryOption>(
                value: country,
                child: Row(
                  children: [
                    Text(country.emoji, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 12),
                    Text(country.name),
                  ],
                ),
              ),
            )
            .toList();
      },
    );
  }
}
