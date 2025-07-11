import 'dart:developer';

import 'package:doclib/core/Di/di.dart';
import 'package:doclib/core/navigation/app_router.dart';
import 'package:doclib/core/widgets/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );
  await initAuthFuture();

  try {
    runApp(const Providers(child: MainApp()));
    Future.delayed(const Duration(seconds: 3), () {
      FlutterNativeSplash.remove();
    });
    FlutterNativeSplash.remove();
  } catch (e, s) {
    log(s.toString());
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
    );
  }
}
