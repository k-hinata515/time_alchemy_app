import 'package:flutter/material.dart';
import 'package:time_alchemy_app/component/ButtonCompornent.dart';

final GoRouter  goRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path:'/Button',
      builder:(BuildContext context, GoRouterState state){
          return const ChoiceButton();
      },
    ),
    Goroute()
  ],
);