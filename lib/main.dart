import 'package:flutter/material.dart';
import 'package:mapas_app/pages/acceso_gps_page.dart';
import 'package:mapas_app/pages/loading_page.dart';
import 'package:mapas_app/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var materialApp = MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      // home: LoadingPage(),
      home: AccesoGpsPage(),
      routes: {
        'mapa'       : ( _ ) => MapaPage(),
        'loading'    : ( _ ) => LoadingPage(),
        'acceso_gps' : ( _ ) => AccesoGpsPage(),
      },
    );
    return materialApp;
  }
}