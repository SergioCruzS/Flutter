import 'package:demostraicion_flutter_hdds/models/menu_option.dart';

import '/screens/alert_screen.dart';
import '/screens/animated_screen.dart';
import '/screens/avatar_screen.dart';
import '/screens/card_screen.dart';
import '/screens/home_screen.dart';
import '/screens/inputs_screen.dart';
import '../screens/listview1_screen.dart';
import '/screens/listview2_screen.dart';
import '../screens/infinite_scroll.dart';
import '/screens/slider_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const initialRoute = 'home';

  static final menuOptions = <MenuOption>[
    MenuOption(
        route: 'listview1',
        name: 'Listview tipo 1',
        screen: const Listview1Screen(),
        icon: Icons.list_alt),
    MenuOption(
        route: 'listview2',
        name: 'Listview tipo 2',
        screen: const Listview2Screen(),
        icon: Icons.list),
    MenuOption(
        route: 'alert',
        name: 'Alertas',
        screen: const AlertScreen(),
        icon: Icons.add_alert_outlined),
    MenuOption(
        route: 'card',
        name: 'Tarjetas',
        screen: const CardScreen(),
        icon: Icons.credit_card),
    MenuOption(
        route: 'avatar',
        name: 'Avatar',
        screen: const AvatarScreen(),
        icon: Icons.supervised_user_circle_outlined),
    MenuOption(
        route: 'animated',
        name: 'Contenedor Animado',
        screen: const AnimatedScreen(),
        icon: Icons.play_circle_outline_rounded),
    MenuOption(
        route: 'inputs',
        name: 'Formulario',
        screen: const InputsScreen(),
        icon: Icons.input_rounded),
    MenuOption(
        route: 'slider',
        name: 'Slider && Checks',
        screen: const SliderScreen(),
        icon: Icons.slow_motion_video_rounded),
    MenuOption(
        route: 'listviewbuilder',
        name: 'InfiniteScrol & Pull to refresh',
        screen: const ListViewBuilderScreen(),
        icon: Icons.build_circle_outlined),
  ];

  //Generación de lista de rutas
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    //Crea la lista que va a contener un String y el widget a donde va a apuntar la ruta
    Map<String, Widget Function(BuildContext)> appRoutes = {};
    //Agregando ruta Home
    appRoutes.addAll({'home': (BuildContext context) => const HomeScreen()});

    //Ciclo for para agregar las demás rutas declaradas en el menuOptions
    for (final option in menuOptions) {
      appRoutes.addAll({option.route: (BuildContext context) => option.screen});
    }

    return appRoutes;
  }

  //Ruta por defecto en caso de que no se encuentre la pantalla
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const AlertScreen(),
    );
  }
}
