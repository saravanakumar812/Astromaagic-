enum AppRoutes {
  root,
  Login,
  mobileNumberScreen,
  register,
  otp,
  forgotPassword,
  homeScreen,
  choosePaymentScreen,
  successfullyPaidScreen,
  vastuConsulting,
  vastuConsultingPriceSlot,
  generalPredictionScreenOne,
  vastuConsultingPaymentScreen,
  generalPredictionVoiceMessage,
  countryScreen,
  serviceHistory, calendlyView, timeSelectionProcessSlot, adminServicesList, userServicesList,
  adminServicesViewScreen, editProfile, privacyPolicy, supportScreen, faqScreen
}

extension AppRouteExtension on AppRoutes {
  static const appRoutes = {
    AppRoutes.root: "/",
    AppRoutes.Login: "/Login",
    AppRoutes.mobileNumberScreen: "/mobileNumberScreen",
    AppRoutes.register: "/RegisterScreen",
    AppRoutes.otp: "/OTPScreen",
    AppRoutes.forgotPassword: "/ForgotPassword",
    AppRoutes.homeScreen: "/HomeScreen",
    AppRoutes.countryScreen: "/CountryScreen",
    AppRoutes.choosePaymentScreen: "/ChoosePaymentScreen",
    AppRoutes.successfullyPaidScreen: "/SuccessfullyPaidScreen",
    AppRoutes.vastuConsulting: "/VastuConsulting",
    AppRoutes.generalPredictionScreenOne: "/GeneralPredictionScreenOne",
    AppRoutes.vastuConsultingPriceSlot: "/vastuConsultingPriceSlot",
    AppRoutes.vastuConsultingPaymentScreen: "/VastuConsultingPaymentScreen",
    AppRoutes.generalPredictionVoiceMessage: "/GeneralPredictionVoiceMessage",
    AppRoutes.serviceHistory: "/ServiceHistory",
    AppRoutes.calendlyView: "/CalendlyView",
    AppRoutes.timeSelectionProcessSlot: "/TimeSelectionProcessSlot",
    AppRoutes.userServicesList: "/UserServicesList",
    AppRoutes.adminServicesList: "/AdminServicesList",
    AppRoutes.adminServicesViewScreen: "/AdminServicesViewScreen",
    AppRoutes.editProfile: "/EditProfileScreen",
    AppRoutes.privacyPolicy: "/PrivacyPolicy",
    AppRoutes.supportScreen: "/SupportScreen",
    AppRoutes.faqScreen: "/FAQScreen",
  };
  String get toName => appRoutes[this]!;
}

enum ApiRoutes {
  forgot,
}

extension ApiRouteExtension on ApiRoutes {
  static const apiRoutes = {
    ApiRoutes.forgot: "",
  };

  String get toName => apiRoutes[this]!;
}
