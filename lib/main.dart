import 'package:chat_application/config/themes.dart';
import 'package:chat_application/screens/chat_screen.dart';
import 'package:chat_application/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App UI',
      theme: lightTheme,
      darkTheme: darkTheme,
      getPages: [
        GetPage(name: '/', page: () =>  HomeScreen()),
        GetPage(name: '/chat', page: () => const ChatScreen()),
      ],
      home: HomeScreen(),
    );
  }
}
