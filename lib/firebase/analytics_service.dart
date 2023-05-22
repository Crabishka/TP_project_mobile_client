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
    await analytics.logEvent(name: 'change');
  }

  Future<void> reg() async {
    await analytics.logEvent(name: 'change');
  }

  Future<void> doOrder() async {
    await  analytics.logEvent(name: 'order');
  }

  Future<void> cancelProduct() async {
    await   analytics.logEvent(name: 'cancel_product');
  }

  Future<void> cancelOrder() async {
    await  analytics.logEvent(name: 'cancel_order');
  }

  Future<void> init() async {
    await   analytics.logEvent(name: 'view');
  }

  Future<void> addProduct(int id) async {
    await   analytics.logEvent(name: 'add_to_cart', parameters: {
      "content_type": 'add_to_cart',
      "item_id": id,
    });
  }
}
