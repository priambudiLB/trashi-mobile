// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashi/app.dart';
import 'package:trashi/pages/edit_profile_screen/provider.dart';
import 'package:trashi/pages/form_request_pengangkatan/provider.dart';
import 'package:trashi/pages/profile_screen_redesign/provider.dart';
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
        ChangeNotifierProvider(create: (_) => Authentication()),
        ChangeNotifierProvider(create: (_) => RetributionPayment()),
        ChangeNotifierProvider(create: (_) => UPST()),
        ChangeNotifierProvider(create: (_) => OTP()),
        ChangeNotifierProvider(create: (_) => SubmitDocumentVerification()),
        ChangeNotifierProvider(
            create: (_) => FormRequestPengangkatanProvider()),
        ChangeNotifierProvider(create: (_) => ProfileScreenProvider()),
        ChangeNotifierProvider(create: (_) => EditProfileScreenProvider())
      ],
      // child: const MyApp(),
      child: const TrashiApplication(),
    ),
  );
}
