import 'package:firebase_analytics/firebase_analytics.dart';

import 'firebase_remote_config_service.dart';

class AnalyticsService {
  const AnalyticsService({
    required this.analytics,
    required this.firebaseRemoteConfigService,
  });

  final FirebaseAnalytics analytics;
  final FirebaseRemoteConfigService firebaseRemoteConfigService;

  Future<void> setChangeButton() async {
    await FirebaseAnalytics.instance.logEvent(name: 'change');
  }

  Future<void> doOrder() async {
    await  FirebaseAnalytics.instance.logEvent(name: 'order');
  }

  Future<void> cancelProduct() async {
    await   FirebaseAnalytics.instance.logEvent(name: 'cancel_product');
  }

  Future<void> cancelOrder() async {
    await  FirebaseAnalytics.instance.logEvent(name: 'cancel_order');
  }

  Future<void> init() async {
    await   FirebaseAnalytics.instance.logEvent(name: 'view');
  }

  Future<void> addProduct() async {
    await   FirebaseAnalytics.instance.logEvent(name: 'add_product');
  }
}
