class Api {
  static String api = 'https://ebd6808020f0.ngrok.io' + '/api';

  static String userSignIn = api + '/user/SignIn';
  static String userSignUp = api + '/user/SignUp';
  static String getUser = api + '/user/getUser';
  static String getAllUsers = api + '/user/getAll';

  static String hostSignIn = api + '/host/SignIn';
  //
  static String getHost = api + '/host/getHost';
  static var header = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // Sessions
  static String getAllSessions = api + '/session/getAll';
  static String createSession = api + '/session/createSession';
  static String completeSession = api + '/session/markComplete';
}
