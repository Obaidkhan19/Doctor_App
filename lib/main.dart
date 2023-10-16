import 'package:doctormobileapplication/data/controller/language_controller.dart';
import 'package:doctormobileapplication/data/localDB/local_db.dart';
import 'package:doctormobileapplication/helpers/theme_manager.dart';
import 'package:doctormobileapplication/models/language_model.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/History_eRX.dart';
import 'package:doctormobileapplication/screens/Consulting_Queue/new_consulting_queue/doctor_review.dart';
import 'package:doctormobileapplication/screens/ManageAppointments/DailyViewAppointment.dart';
import 'package:doctormobileapplication/screens/auth_screens/forget_password.dart';
import 'package:doctormobileapplication/screens/auth_screens/login.dart';
import 'package:doctormobileapplication/screens/auth_screens/main_registration_screen.dart';
import 'package:doctormobileapplication/screens/auth_screens/register_screen.dart';
import 'package:doctormobileapplication/screens/auth_screens/register_screens.dart';
import 'package:doctormobileapplication/screens/auth_screens/sucessfull_registration.dart';
import 'package:doctormobileapplication/screens/health_summary/health_summary.dart';
import 'package:doctormobileapplication/screens/health_summary/health_summary_Screen.dart';
import 'package:doctormobileapplication/screens/health_summary/patient_history.dart';
import 'package:doctormobileapplication/screens/consulted_vault/appointment_history.dart';
import 'package:doctormobileapplication/screens/appointment_configuration/configure_appointments.dart';
import 'package:doctormobileapplication/screens/profile/edit_profile.dart';
import 'package:doctormobileapplication/screens/profile/profile.dart';
import 'package:doctormobileapplication/screens/splash_screen/splash_screen.dart';
import 'package:doctormobileapplication/screens/wallet_screens/wallet.dart';
import 'package:doctormobileapplication/utils/constants.dart';
import 'package:doctormobileapplication/utils/init/init.dart';
import 'package:doctormobileapplication/utils/languages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'data/repositories/notification_repo/notifications_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await NotificationsRepo().initLocalNotifications();
  await NotificationsRepo().setupInteractMessage();
  await NotificationsRepo().initNotifications();
  await NotificationsRepo().firebaseInit();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getLocale();

    super.initState();
  }

  getLocale() async {
    LanguageModel? lang = await LocalDb().getLanguage();

    if (lang == null) {
      lang = LanguageModel(
          id: 1,
          name: 'English',
          image: null,
          locale: const Locale('en', 'US'));
      Get.updateLocale(lang.locale!);
      LanguageController.i.selected = AppConstants.languages[0];
    } else {
      Get.updateLocale(lang.locale!);
    }

    if (lang.id == 1) {
      LanguageController.i.selected = AppConstants.languages[0];
    } else {
      LanguageController.i.selected = AppConstants.languages[1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      textDirection: TextDirection.ltr,
      translations: Localization(),
      locale: const Locale('en', 'US'),
      theme: Styles.lightTheme,
      debugShowCheckedModeBanner: false,
      // home: const AppointmentHistoryscreen(),
      home: const SplashScreen(),
      //home: const Profile(),
      //home: const WalletScreen(),
      //home: const PatientHistory(),
      //home: const MainRegistrationScreen(),
      //  home: const ForgetPassword(),
      // home: const LoginScreen(),
      // home: const HistoryeRXConsultingQueue(),
      initialBinding: AppBindings(),
    );
  }
}
