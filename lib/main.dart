import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/client_home.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'pages/register_client.dart';
import 'pages/register_worker.dart';
import 'pages/worker_home.dart';
import 'services/locale_provider.dart';
import 'ui/theme/app_theme.dart';
import 'package:flutter_applicatiomconecta2/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocaleProvider>(
      create: (_) => LocaleProvider(prefs),
      builder: (context, child) {
        final localeProvider = context.watch<LocaleProvider>();
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: localeProvider.supportedLocales,
          locale: localeProvider.locale,
          title: 'Workify',
          theme: AppTheme.light(),
          initialRoute: "/",
          routes: {
            "/": (context) => const HomePage(),
            "/login": (context) => const LoginPage(),
            "/registerWorker": (context) => const RegisterWorkerPage(),
            "/registerClient": (context) => const RegisterClientPage(),
            "/clientHome": (context) => const ClientHome(),
            "/workerHome": (context) => const WorkerHome(),
          },
        );
      },
    );
  }
}
