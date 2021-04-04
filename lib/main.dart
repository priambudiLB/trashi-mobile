// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/app.dart';
import 'package:trashi/providers.dart';

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => OnBoarding()),
      ],
      // child: const MyApp(),
      child: const TrashiApplication(),
    ),
  );
}
