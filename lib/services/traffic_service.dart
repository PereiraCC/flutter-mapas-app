

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {

  // Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _ido = new Dio();

  Future getCoordsInicioYDestino(LatLng inicio, LatLng destino) async {

    print('Inicio: $inicio');
    print('Destino: $destino');

  }

}