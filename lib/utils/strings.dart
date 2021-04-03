String ACCESS_TOKEN = "";
String CSRF_TOKEN = "";
String SESSION_ID = "";

String TEMP_ACCESS_TOKEN = "";
String TEMP_CSRF_TOKEN = "";
String TEMP_SESSION_ID = "";

void setAccessToken(String accessToken) {
  ACCESS_TOKEN = accessToken;
}

void setCsrfToken(String csrfToken) {
  CSRF_TOKEN = csrfToken;
}

void setSessionID(String sessionId) {
  TEMP_SESSION_ID = sessionId;
}

// Setting up temporary user credentials from API.
// Used in Sign-Up phase to alter user information.
void setTempAccessToken(String accessToken) {
  TEMP_ACCESS_TOKEN = accessToken;
}

void setTempCsrfToken(String csrfToken) {
  TEMP_CSRF_TOKEN = csrfToken;
}

void setTempSessionId(String sessionId) {
  TEMP_SESSION_ID = sessionId;
}
