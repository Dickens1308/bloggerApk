import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'features/presentation/injection_container.dart';
import 'features/presentation/injection_container.dart' as ic;
import 'features/presentation/providers/article_provider.dart';
import 'features/presentation/providers/auth_provider.dart';
import 'features/presentation/screens/home_screen.dart';

void main() async {
  Paint.enableDithering = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.dark,
    statusBarIconBrightness: Brightness.dark,
  ));

  await ic.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ArticleProvider>(
          create: (_) => ArticleProvider(
            fetchDataUseCase: sl(),
            fetchMoreDataUseCase: sl(),
            updateArticleBookmarkUsecase: sl(),
            fetchBookmarkUseCase: sl(),
          ),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(
            forgotPasswordUseCase: sl(),
            loginUserUseCase: sl(),
            registerUserUseCase: sl(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xff1f1f23),
      )),
      home: const HomeScreen(),
    );
  }
}
