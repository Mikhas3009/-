import 'package:eco_city/loadingPage.dart';
import 'package:eco_city/presentation/screens/administrator/moderationNews.dart';
import 'package:eco_city/presentation/screens/administrator/registrationOrganizationsScreen.dart';
import 'package:eco_city/presentation/screens/authorization/authorizationScreen.dart';
import 'package:eco_city/presentation/screens/authorization/restorePasswordScreen.dart';
import 'package:eco_city/presentation/screens/general/generalScreen.dart';
import 'package:eco_city/presentation/screens/notFound/notFoundScreen.dart';
import 'package:eco_city/presentation/screens/profile/profileScreen.dart';
import 'package:eco_city/presentation/screens/registration/personalDataScreen.dart';
import 'package:eco_city/presentation/screens/registration/registrationScreen.dart';
import 'package:eco_city/presentation/screens/registration/verifyPhoneScreen.dart';
import 'package:eco_city/presentation/screens/startScreen/startScreen.dart';
import 'package:get/get.dart';

class AppRouter {
  static const initialRoute = '/loading';

  static final routes = [
    GetPage(name: '/loading', page: () => const LoadingPage()),
    GetPage(name: '/startScreen', page: () => const StartScreen()),
    GetPage(name: '/notFound', page: () => const NotFoundScreen()),
    GetPage(name: '/authorization', page: () => const AuthorizationScreen()),
    GetPage(
        name: '/restorePassword', page: () => const RestorePasswordScreen()),
    GetPage(name: '/registration', page: () => const RegistrationScreen()),
    GetPage(name: '/verifyPhone', page: () => const VerifyPhoneScreen()),
    GetPage(name: '/personalData', page: () => const PersonalDataScreen()),
    GetPage(name: '/profile', page: () => const ProfileScreen()),
    GetPage(
        name: '/registrationOrganizations',
        page: () => const RegistrationOrganizationsScreen()),
    GetPage(name: '/moderationNews', page: () => const ModerationNewsScreen()),
    GetPage(name: '/', page: () => const GeneralScreen()),
  ];

  static final unknownRoute =
      GetPage(name: '/notFound', page: () => const NotFoundScreen());
}
