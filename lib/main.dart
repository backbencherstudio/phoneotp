import 'package:albertyg/model_view/otp_screen_provider.dart';
import 'package:albertyg/utils/route_name.dart';
import 'package:albertyg/view/loginScreen/login_screen.dart';
import 'package:albertyg/view/otpScreen/otpScreen.dart';
import 'package:albertyg/view/splashScreen/splashScreen.dart';
import 'package:albertyg/view/username/UserName_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'model_view/login_screen_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set device orientation to portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Ensure ScreenUtil is ready
  await ScreenUtil.ensureScreenSize();

  await Firebase.initializeApp();

  // Set the Firebase language code here
  // FirebaseAuth.instance.setLanguageCode('bn'); // or any other language code you need

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const deviceWidth = 375.0;
  static const deviceHeight = 812.0;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginScreenProvider>(
          create: (_) => LoginScreenProvider(),
        ),
        ChangeNotifierProvider<OTPScreenProvider>(
          create: (_) => OTPScreenProvider(),
        ),

      ],
      child: ScreenUtilInit(
        designSize: const Size(deviceWidth, deviceHeight),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              appBarTheme: AppBarTheme(backgroundColor: Colors.white),
              scaffoldBackgroundColor: Colors.white,
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xFFE11E1B),
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: false,
                showSelectedLabels: false,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              textTheme: TextTheme(
                headlineLarge: TextStyle(
                  fontFamily: 'Menseal',
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                headlineMedium: TextStyle(
                  fontFamily: 'Menseal',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                headlineSmall: TextStyle(
                  fontFamily: 'Menseal',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                titleLarge: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                bodyLarge: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                bodyMedium: GoogleFonts.inter(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
                bodySmall: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                labelLarge: TextStyle(
                  fontFamily: 'Menseal',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              RouteName.loginScreen: (context) => const LoginScreen(),
              RouteName.otpscreen: (context) =>  Otpscreen(),
               RouteName.usernamescreen: (context) => const UserNameScreen(),
            },
          );
        },
      ),
    );
  }
}
