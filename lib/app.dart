import 'package:flutter/material.dart';
import 'package:trashi/constants/strings.dart';
import 'package:trashi/constants/theme.dart';
import 'package:trashi/pages/confirmation_otp_screen/confirmation_otp_screen.dart';
import 'package:trashi/pages/edit_profile_screen/edit_profile_screen.dart';
import 'package:trashi/pages/form_request_pengangkatan/form_request_pengangkatan.dart';
import 'package:trashi/pages/onboarding_redesign_screen/on_boarding_screen_view.dart';
import 'package:trashi/pages/payment/payment_web_view_screen.dart';
import 'package:trashi/pages/profile_screen_redesign/profile_screen_new.dart';
import 'package:trashi/pages/profile_screen_redesign/profile_screen_not_verified.dart';
import 'package:trashi/pages/profile_screen_redesign/registration_document_confirmation/registration_document_confirmation.dart';
import 'package:trashi/pages/request_screen/request_screen.dart';
import 'package:trashi/pages/retribution_masyarakat_screen/retribution_masyarakat.dart';
import 'package:trashi/pages/retribution_screen/retribution_screen.dart';
import 'package:trashi/pages/splash_screen/splash_screen.dart';
import 'package:trashi/pages/trash_collection_screen/accepter/accept_trash_collection_request_screen.dart';
import 'package:trashi/verification.dart';

class TrashiApplication extends StatelessWidget {
  const TrashiApplication({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: defaultTheme,
      title: APP_NAME,
      initialRoute: SplashScreen.PATH,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        SplashScreen.PATH: (_) => SplashScreen(),
        ProfileScreenVerified.PATH: (_) => ProfileScreenVerified(),
        OnboardingScreen.PATH: (_) => OnboardingScreen(),
        RetributionScreen.PATH: (_) => RetributionScreen(),
        ConfirmationOTPScreen.PATH: (_) => ConfirmationOTPScreen(
              account: "0896361219",
              verification: Verification.phone,
            ),
        ProfileScreenNotVerified.PATH: (_) => ProfileScreenNotVerified(),
        RegistrationDocumentConfirmation.PATH: (_) =>
            RegistrationDocumentConfirmation(),
        FormRequestPengangkatan.PATH: (_) => FormRequestPengangkatan(),
        AcceptTrashCollectionRequestScreen.PATH: (_) =>
            AcceptTrashCollectionRequestScreen(),
        RequestScreen.PATH: (_) => RequestScreen(),
        EditProfile.PATH: (_) => EditProfile(),
        PaymentWebViewScreen.PATH: (_) => PaymentWebViewScreen(),
        RetributionMasyarakat.PATH: (_) => RetributionMasyarakat()
        // HomeScreen.PATH: (_) => HomeScreen(),
      },
    );
  }
}
