import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:clientes_inadimplentes_2/api/sheet/user_sheet_api.dart';
import 'package:clientes_inadimplentes_2/pages/create_sheets_page.dart';
import 'package:clientes_inadimplentes_2/pages/home_list_sheet_page.dart';
import 'package:clientes_inadimplentes_2/pages/modify_sheets_page.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  UserSheetApi.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Clientes Inadimplentes';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splash: Image.asset('assets/jcnet.png'), 
        nextScreen: ModifySheetPage(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 260,
        ),
      routes: <String, WidgetBuilder>{
        '/newUser' : (BuildContext context) => CreateSheetPage(),
        '/modifyUser' : (BuildContext context) => ModifySheetPage(),
        '/ListAllUser' : (BuildContext context) => HomeListSheetPage(),
      },
    );
  }
}