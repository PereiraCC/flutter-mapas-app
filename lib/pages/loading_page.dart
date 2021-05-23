import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:mapas_app/helpers/helpers.dart';

import 'package:mapas_app/pages/acceso_gps_page.dart';
import 'package:mapas_app/pages/mapa_page.dart';


class LoadingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkGpsYLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          
          if(snapshot.hasData) {
            return Center(
              child: Text(snapshot.data)
            );
          } else {
            return Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            );
          }

        },
      ),
   );
  }

  Future checkGpsYLocation(BuildContext context) async{

    //PermisoGPS
    final permisoGPS = await Permission.location.isGranted;

    //GPS esta activo
    final gpsActivo = await Geolocator.isLocationServiceEnabled();

    if(permisoGPS && gpsActivo) {
       Navigator.pushReplacement(context, navegarMapaFadeIn(context, MapaPage()));
       return '';
    } else if( !permisoGPS ) {
      Navigator.pushReplacement(context, navegarMapaFadeIn(context, AccesoGpsPage()));
      return 'Es necesario el permiso de GPS';
    } else {
      return 'Active el GPS';
    }



  }
}