import 'package:today_house/screen/home/home_screen.dart';
import 'package:today_house/screen/login/add_profile_screen.dart';
import 'package:today_house/screen/login/login_screen.dart';
import 'package:today_house/screen/sample/sample_screen.dart';
import 'package:today_house/screen/setting/setting_screen.dart';

final routes = {
  '/sample': (context) => const SampleScreen(),
  '/login': (context) => const LoginScreen(),
  '/add-profile': (context) => const AddProfileScreen(),
  '/home': (context) => const HomeScreen(),
  '/setting': (context) => const SettingScreen(),
};
