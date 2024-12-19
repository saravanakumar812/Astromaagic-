class ApiUrl {
  static const bool isProductionUrl = false;
  static const String appVersion = "1.5";
  static const String baseUrl = isProductionUrl
      ? "https://mdqualityapps.in/API/astromaagic/production/" :
      "https://mdqualityapps.in/API/astromaagic/uat/";
  static String login = 'user_login';
  static String forgot = 'user_forgot_password';
  static String add_users = 'add_users';
  static String all_country = 'get_countries';
  // static String getAllServices = 'get_all_services';
   static String getAllServices = 'get_all_services_for_mobile';
  //static String getAllServices = 'get_all_services_for_mobile';
  static String getFcmTokenUpdate = 'add_user_fcm_token';
  static String getParticularServices = 'get_service';
  static String getRemedies = 'get_remedies';
  static String vastuPriceSlot = 'get_remedy_charges';
  static String addUserService = 'add_user_service';
  static String getUserService = 'get_user_service';
  static String getViewPdf = 'get_pdf';
  static String paymentProcess = 'process_payment';
  static String scheduleMeeting = 'schedule_meeting';
  static String getAllEventSlots = 'get_all_event_slots';
  static String getAllEventNames = 'get_all_event_names';
  static String scheduleEvent = 'schedule_event';
  static String getEditProfile = 'get_user';
  static String getUpdateProfile = 'update_users';
  static String acceptUserService = 'accept_user_service';
  static String mobileNumber = 'check_mobile_number';
  static String otpVerify = 'verify_otp';
  static String forgotMobileNumber = 'generate_forgot_password_otp';

}
