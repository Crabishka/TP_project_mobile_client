import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:sportique/app.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sportique/firebase/analytics_service.dart';
import 'package:sportique/firebase/firebase_remote_config_service.dart';
import 'package:sportique/firebase_options.dart';
import 'package:sportique/view/pages/onboarding_screen.dart';
import 'package:sportique/viewmodel/internal/app_data.dart';
import 'package:sportique/viewmodel/token_hepler.dart';
import 'package:sportique/viewmodel/user_model.dart';

import 'model/client_api/product_description_repository.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'model/client_api/user_repository.dart';
import 'dart:io';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AppData>(AppData());
  getIt.registerSingleton<TokenHelper>(TokenHelper());
  getIt.registerSingleton<UserRepository>(UserRepository());

  getIt.registerSingleton<ProductDescriptionRepository>(
      ProductDescriptionRepository());

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firebaseRemoteConfigService = FirebaseRemoteConfigService(
    firebaseRemoteConfig: FirebaseRemoteConfig.instance,
  );
  await firebaseRemoteConfigService.init();

  getIt.registerSingleton<FirebaseRemoteConfigService>(
      firebaseRemoteConfigService);

  getIt.registerSingleton<AnalyticsService>(AnalyticsService(
      analytics: FirebaseAnalytics.instance,
      firebaseRemoteConfigService: firebaseRemoteConfigService));

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserModel>(create: (_) => UserModel()),
      ChangeNotifierProvider<AppData>(create: (_) => AppData()),
    ],
    child: MyApp(),
  ));
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> _initIsFirst() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFirst = prefs.getBool("isFirst") ?? true;
      print(_isFirst);
      prefs.setBool("isFirst", false);
    });
  }

  GetIt getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    getIt.get<AnalyticsService>().init();
    _initIsFirst();
  }

  bool _isFirst = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'),
        ],
        debugShowCheckedModeBanner: false,
        title: 'Sportique',
        theme: ThemeData(
          fontFamily: 'Mont',
          primarySwatch: Colors.blue,
        ),
        home: _isFirst ? OnBoardingScreen() : App());
  }
}
