import 'dart:ui';

import 'package:every_day/Utils/cached_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Widgets/connection.dart';
import 'Widgets/home.dart';
import 'constant.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  FirebasePerformance _performance = FirebasePerformance.instance;
  _performance.setPerformanceCollectionEnabled(true);
  _performance.app.setAutomaticDataCollectionEnabled(true);
  _performance.app.setAutomaticResourceManagementEnabled(true);

  runApp(const Events());
}


class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Events",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: mainColor,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.hasData) {
              return Home(
                memberUid: snapshot.data!.uid,
              );
            } else {
              return Connection();
            }
          },
        ));
  }
}
