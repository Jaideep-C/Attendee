class Api {
  static String api = 'https://085ffbe6037a.ngrok.io' + '/api';

  static String userSignIn = api + '/user/SignIn';
  static String userSignUp = api + '/user/SignUp';
  static String getUser = api + '/user/get';

  static String hostSignIn = api + '/host/SignIn';
  //
  static String getHost = api + '/host/get';
  static var header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
