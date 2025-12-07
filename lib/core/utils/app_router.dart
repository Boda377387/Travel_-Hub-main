import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:travel_hub/features/ai_camera/ai_camera.dart';
import 'package:travel_hub/features/auth/forget_password/forget.dart';
import 'package:travel_hub/features/auth/forget_password/success.dart';
import 'package:travel_hub/features/auth/login/presentation/views/login_screen.dart';
import 'package:travel_hub/features/auth/register/view/register_screen.dart';
import 'package:travel_hub/features/auth/reset/reset_password.dart';
import 'package:travel_hub/features/welcome/welcome_screen.dart';
import 'package:travel_hub/navigation/land_mark/data/carousel_slider_cubit/carousel_slider_cubit.dart';
import 'package:travel_hub/navigation/land_mark/data/cubit/land_mark_cubit.dart';
import 'package:travel_hub/navigation/land_mark/land_mark_details_screen.dart';
import 'package:travel_hub/navigation/land_mark/land_mark_screen.dart';
import 'package:travel_hub/navigation/land_mark/models/land_mark_model.dart';
import 'package:travel_hub/navigation/home/home_screen.dart';
import 'package:travel_hub/navigation/hotels/booking/book_screen.dart';
import 'package:travel_hub/navigation/hotels/data/cubit/hotels_cubit.dart';
import 'package:travel_hub/navigation/hotels/hotels_screen.dart';
import 'package:travel_hub/features/splash/splash_screen.dart';
import 'package:travel_hub/navigation/hotels/hotels_screen_details.dart';
import 'package:travel_hub/navigation/hotels/models/hotels_model.dart';
import 'package:travel_hub/navigation/main_screen.dart';
import 'package:travel_hub/navigation/maps/presentation/views/full_map_screen.dart';

abstract class AppRouter {
  static const kWelcomeView = '/welcomeView';
  static const kLoginView = '/loginView';
  static const kRegisterView = '/registerView';
  static const kforgetView = '/forgetView';
  static const kreset = '/restView';
  static const ksuccess = '/success';
  static const kNavigationView = '/navigation';
  static const kMapView = '/mapView';
  static const kHomeView = '/home';
  static const kCameraView = '/cameraView';
  static const kHotelsView = '/hotels';
  static const kBookView = '/book';
  static const kHotelsDetailsView = '/details';
  static const kLandMarkView = '/landMark';
  static const kLandMarkDetailsView = '/marksDetails';

  static final routers = GoRouter(
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final loc = state.matchedLocation;
      final isAuthRoute = loc == kLoginView || loc == kRegisterView || loc == kforgetView || loc == kWelcomeView;
      final isResetRoute = loc == kreset || loc.startsWith('/__/auth/action');

      if (loc == '/') return null;

      if (user == null) {
        if (isAuthRoute || isResetRoute) return null;
        return kLoginView;
      } else {
        if (isAuthRoute) return kNavigationView;
        return null;
      }
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: kWelcomeView,
        builder: (context, state) => const TravelWelcomeScreen(),
      ),
      GoRoute(
        path: kLoginView,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: kforgetView,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: kreset,
        builder: (context, state) {
          final oobCode = state.extra as String? ?? '';
          return ResetScreen(oobCode: oobCode);
        },
      ),
      GoRoute(
        path: ksuccess,
        builder: (context, state) => const successScreen(),
      ),

      GoRoute(
        path: '/__/auth/action',
        builder: (context, state) {
          final uri = state.uri;
          final mode = uri.queryParameters['mode'];
          final oobCode = uri.queryParameters['oobCode'];

          if (mode == 'resetPassword' && oobCode != null) {
            return ResetScreen(oobCode: oobCode);
          }

          return const Scaffold(
            body: Center(
              child: Text('Invalid or unsupported link'),
            ),
          );
        },
      ),

      GoRoute(
        path: kHomeView,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: kCameraView,
        builder: (context, state) {
          final imageFile = state.extra as File;
          return AiCamera(selectedImage: imageFile);
        },
      ),
      GoRoute(
        path: kNavigationView,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: kMapView,
        builder: (context, state) => const FullMapScreen(),
      ),
      GoRoute(
        path: kHotelsView,
        builder: (context, state) => BlocProvider(
          create: (context) => HotelsCubit()..loadHotels(),
          child: const HotelsScreen(),
        ),
      ),
      GoRoute(
        path: kHotelsDetailsView,
        pageBuilder: (context, state) {
          final hotels = state.extra as Hotels;
          return CustomTransitionPage(
            key: state.pageKey,
            child: HotelsScreenDetails(hotels),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
                CurveTween(curve: Curves.easeInOut),
              );
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: kLandMarkView,
        builder: (context, state) => BlocProvider(
          create: (context) => LandMarkCubit()..loadLandMark(),
          child: const LandMarkScreen(),
        ),
      ),
      GoRoute(
        path: kLandMarkDetailsView,
        pageBuilder: (context, state) {
          final landMark = state.extra as LandMark;
          return CustomTransitionPage(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => CarouselSliderCubit(),
              child: LandMarkDetailsScreen(landMark),
            ),
            transitionDuration: const Duration(milliseconds: 600),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              final tween = Tween(begin: const Offset(0.0, 1.0), end: Offset.zero).chain(
                CurveTween(curve: Curves.easeInOut),
              );
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        },
      ),
      GoRoute(
        path: kBookView,
        builder: (context, state) => const BookScreen(),
      ),
    ],
  );
}
