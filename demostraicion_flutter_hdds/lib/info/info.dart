import 'package:demostraicion_flutter_hdds/models/information_card.dart';

class CardInfo {
  static final contentCard = <InformationCard>[
    InformationCard(title: 'Flutter', content: 'Flutter es un SDK de código fuente abierto de desarrollo de aplicaciones móviles creado por Google. Suele usarse para desarrollar interfaces de usuario para aplicaciones en Android, iOS y Web.'),
    InformationCard(title: 'Dato Curioso', content: 'La primera versión de Flutter fue conocida como "Sky" y corrió en el sistema operativo de Android.'),
    InformationCard(title: 'Dart', content: 'Dart es un lenguaje de programación de código abierto, desarrollado por Google. Fue revelado en la conferencia goto; en Aarhus, Dinamarca el 10 de octubre de 2011.'),
    InformationCard(title: 'Dato Curioso 2', content: 'Flutter engine, está escrito principalmente en C++, proporciona un soporte de bajo-nivel para renderización que utiliza Google Skia.')
  ];
}
