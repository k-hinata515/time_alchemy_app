import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:time_alchemy_app/test/choice_button.dart';

class Go_router extends StatelessWidget{
  final router = GoRouter(
    //パス（アプリが起動した時）
    initialLocation: '/main',
    //パスと画面の組み合わせ
    routes: [
      
      GoRoute(
        path: '/first',
        builder: (context, state) =>First(),
        ),
    ]
  );
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}