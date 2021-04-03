class SplashScreenState {
  bool isUserAccessTokenExist;
  String userAccessToken;

  SplashScreenState({this.isUserAccessTokenExist, this.userAccessToken});

  SplashScreenState.initial() {
    isUserAccessTokenExist = false;
    userAccessToken = "";
  }

  SplashScreenState setStateProps(
      {bool isUserAccessTokenExist, String userAccessToken}) {
    return SplashScreenState(
        isUserAccessTokenExist:
            isUserAccessTokenExist ?? this.isUserAccessTokenExist,
        userAccessToken: userAccessToken ?? this.userAccessToken);
  }
}
