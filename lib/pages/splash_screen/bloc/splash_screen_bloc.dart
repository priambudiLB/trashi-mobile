import 'package:bloc/bloc.dart';
import 'package:logger/logger.dart';
import 'package:trashi/utils/cookies.dart';
import 'package:trashi/utils/network_exception.dart';
import 'package:trashi/pages/splash_screen/bloc/splash_screen_event.dart';
import 'package:trashi/pages/splash_screen/bloc/splash_screen_state.dart';
import 'package:trashi/utils/strings.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  static final Logger log = Logger();

  SplashScreenBloc() : super(SplashScreenState.initial());

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    if (event is CheckLoginStatus) {
      try {
        bool cookiesFileAvailability =
            await CookiesUtils.checkCookiesFileAvailability();
        if (cookiesFileAvailability) {
          List<dynamic> cookiesFileData = await CookiesUtils.getCookiesFile();
          log.i("Cookies File Found!\nData: ${cookiesFileData.toString()}");

          setCsrfToken(cookiesFileData[0]);
          setSessionID(cookiesFileData[1]);
          setAccessToken(cookiesFileData[2]);

          yield state.setStateProps(
            isUserAccessTokenExist: true,
            userAccessToken: cookiesFileData[2],
          );
        } else {
          yield SplashScreenState.initial();
        }
      } on NetworkException catch (e) {
        log.e(
            "Error Fetching User Cookies File!\nerror message: ${e.errorMessage}\nerror status code: ${e.errorStatusCode}");

        yield state.setStateProps(
          isUserAccessTokenExist: false,
          userAccessToken: "",
        );
      }
    }
  }
}
