import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:developer' as developer;

import 'package:get_it/get_it.dart';
import 'package:sportique/viewmodel/internal/app_data.dart';

class FirebaseRemoteConfigService {
  FirebaseRemoteConfigService({
    required this.firebaseRemoteConfig,
  });

  final FirebaseRemoteConfig firebaseRemoteConfig;
  GetIt getIt = GetIt.instance;

  Future<void> init() async {
    try {
      await firebaseRemoteConfig.ensureInitialized();
      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      getIsChange();
      await firebaseRemoteConfig.fetchAndActivate();
    } on FirebaseException catch (e, st) {
      developer.log(
        'Unable to initialize Firebase Remote Config',
        error: e,
        stackTrace: st,
      );
    }
  }

  bool getIsChange() {
    bool isChange = firebaseRemoteConfig.getBool("isChange");
    getIt.get<AppData>().setIsChange(isChange);
    print(isChange);
    return isChange;
  }
}
