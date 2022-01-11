import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nekidaem/auth/repository/auth_repository.dart';
import 'package:nekidaem/tabbar/repository/tabbar_repository.dart';
import 'package:nekidaem/tabbar/view/tabbar_view.dart';

import 'auth/login/view/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.tealAccent[200]!), //button color
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black54), //text (and icon)
          ),
        ),
      ),
       initialRoute: '/login',
       onGenerateRoute: (RouteSettings settings){
        switch(settings.name) {
          case LoginView.routeName:
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return RepositoryProvider(
                      create: (context) => AuthRepository(),
                      child: LoginView(),
                    );
              }
            );
          case MyTabBarView.routeName:
            return MaterialPageRoute(
              builder: (BuildContext context) {
                return RepositoryProvider(
                  create: (context) => TabBarRepository(),
                  child: MyTabBarView(),
                );
              }
            );
        }
       },
       // home: RepositoryProvider(
       //   create: (context) => TabBarRepository(),
       //     child: MyTabBarView(),
       // ),
    );
  }
}

