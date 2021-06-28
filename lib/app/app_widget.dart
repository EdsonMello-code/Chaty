import 'package:flutter/material.dart';
import 'package:socket/app/features/chat/views/home_view.dart';
import 'package:socket/app/features/contact/views/contacts_view.dart';
import 'package:socket/app/features/login/views/login_view.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      initialRoute: '/login',
      routes: {
        "/login": (BuildContext context) => LoginView(),
        "/contacts": (BuildContext context) => ContactsView(),
        "/chat": (BuildContext context) => HomePage(title: 'Neco')
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: LoginView(),
    );
  }
}
