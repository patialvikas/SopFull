class AppUrl {
  static const String liveBaseURL = "http://akkdev.in/api";
  static const String localBaseURL = "http://10.0.2.2:8000/api";
  static const String webviewURL="http://akkdev.in/psp/storage/app/public/sop/";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/login";
  static const String logout = baseURL + "/logout";
  static const String register = baseURL + "/register";
  static const String forgotPassword = baseURL + "/forgotPassword";
  static const String getDept = baseURL + "/orgList";
  static const String deptList = baseURL + "/deptList";
  static const String sopslist = baseURL + "/userBasic";
  static const String sop = baseURL + "/sop";
}