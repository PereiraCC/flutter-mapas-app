import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/pages/acceso_gps_page.dart';

import 'package:mapas_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/bloc/busqueda/busqueda_bloc.dart';
import 'package:mapas_app/pages/test_marker_page.dart';
import 'bloc/mi_ubicacion/mi_ubicacion_bloc.dart';

import 'package:mapas_app/pages/loading_page.dart';
import 'package:mapas_app/pages/mapa_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: ( _ ) => MiUbicacionBloc()),
        BlocProvider(create: ( _ ) => MapaBloc()),
        BlocProvider(create: ( _ ) => BusquedaBloc()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        // home: LoadingPage(),
        home: TestMarkerPage(),
        routes: {
          'mapa'       : ( _ ) => MapaPage(),
          'loading'    : ( _ ) => LoadingPage(),
          'acceso_gps' : ( _ ) => AccesoGpsPage(),
        },
      ),
    );
  }
}