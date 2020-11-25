class Api {
  static String api = 'https://f67e3cbdb052.ngrok.io' + '/api';

  static String userSignIn = api + '/user/SignIn';
  static String userSignUp = api + '/user/SignUp';
  static String getUser = api + '/user/getUser';

  static String hostSignIn = api + '/host/SignIn';
  //
  static String getHost = api + '/host/getHost';
  static var header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };
}
