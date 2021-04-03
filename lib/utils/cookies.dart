import 'dart:convert';
import 'dart:io';

import 'package:trashi/utils/strings.dart';
import 'package:trashi/constants/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

// Utility class to interact with cookies file.
// @author Izzan
class CookiesUtils {
  static final log = Logger();

  // Checks cookies file availability in phone's local storage
  // Returns [isCookiesExist]
  static Future<bool> checkCookiesFileAvailability() async {
    Directory cookiesFileDirectory;
    await getApplicationDocumentsDirectory().then((Directory directory) {
      cookiesFileDirectory = directory;
    });
    File cookiesFile = File(cookiesFileDirectory.path + COOKIES_FILE_NAME);
    bool isCookiesExist = cookiesFile.existsSync();

    return isCookiesExist;
  }

  // Set up temporary cookies file
  // Used to store newly created user data temporarily (ex. on sign up phase)
  static void setTemporaryCookiesFile(
      Map<String, dynamic> responseHeaders) async {
    String setCookie = responseHeaders["set-cookie"];
    log.i("set-cookie: $setCookie");
    String CSRFToken = setCookie.split(";")[3].split(",")[1].split("=")[1];
    log.i("CSRF Token: $CSRFToken");
    String sessionID = setCookie.split(";")[7].split(",")[1].split("=")[1];
    log.i("Session ID: $sessionID");

    setTempCsrfToken(CSRFToken);
    setTempSessionId(sessionID);
  }

  // Create permanent cookies file to be saved to phone's local storage
  // The cookies file contains CSRF Token, Session ID, and user specific key from backend
  static Future<void> createCookiesFile(
      Map<String, dynamic> responseHeaders) async {
    try {
      String setCookie;
      String csrfToken;
      String sessionID;
      String userAccessToken;
      List<String> cookiesList;
      Directory cookiesFileDirectory;

      await getApplicationDocumentsDirectory().then((Directory directory) {
        cookiesFileDirectory = directory;
      });
      File cookiesFile =
          new File(cookiesFileDirectory.path + COOKIES_FILE_NAME);
      cookiesFile.createSync();

      setCookie = responseHeaders["set-cookie"];
      log.i("set-cookie: $setCookie");
      if (setCookie != null && setCookie.isNotEmpty) {
        if (setCookie.split(";").length == 10) {
          csrfToken = setCookie.split(";")[0].split("=")[1];
          sessionID = setCookie.split(";")[4].split(",")[1].split("=")[1];
        } else {
          csrfToken = setCookie.split(";")[3].split(",")[1].split("=")[1];
          sessionID = setCookie.split(";")[7].split(",")[1].split("=")[1];
        }
        userAccessToken = ACCESS_TOKEN;
      } else {
        csrfToken = TEMP_CSRF_TOKEN;
        sessionID = TEMP_SESSION_ID;
        userAccessToken = TEMP_ACCESS_TOKEN;
      }

      cookiesList = <String>[csrfToken, sessionID, userAccessToken];

      log.i(
          "Cookies File Created! Contents:\nCSRF Token: $csrfToken\nSession ID: $sessionID\nUser Access Token: $userAccessToken");
      cookiesFile.writeAsStringSync(json.encode(cookiesList));
    } on Exception catch (e) {
      log.e("Failed to create cookies file, error message: ${e.toString()}");
      rethrow;
    }
  }

  // Fetch cookies file from local storage.
  static Future<List<dynamic>> getCookiesFile() async {
    Directory cookiesFileDirectory;
    await getApplicationDocumentsDirectory().then((Directory directory) {
      cookiesFileDirectory = directory;
    });
    File cookiesFile = new File(cookiesFileDirectory.path + COOKIES_FILE_NAME);

    dynamic cookiesFileContent = cookiesFile.readAsStringSync();
    return json.decode(cookiesFileContent);
  }

  // Deletes existing cookies file stored in phone's local storage.
  // Used when user logged out their account from the app.
  static Future<void> deleteCookiesFile() async {
    bool isCookiesFileExist = await checkCookiesFileAvailability();

    if (isCookiesFileExist) {
      Directory cookiesFileDirectory;
      await getApplicationDocumentsDirectory().then((Directory directory) {
        cookiesFileDirectory = directory;
      });

      File cookiesFile =
          new File(cookiesFileDirectory.path + COOKIES_FILE_NAME);
      cookiesFile.delete();

      setTempAccessToken("");
      setTempCsrfToken("");
      setTempSessionId("");
      setAccessToken("");
      setCsrfToken("");
      setSessionID("");

      log.i("Cookies file successfully deleted.");
    }
  }
}
