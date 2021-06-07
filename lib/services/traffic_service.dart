

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/models/trafiic-response.dart';

class TrafficService {

  // Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _ido = new Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _apiKey  = 'pk.eyJ1IjoicGVyZWlyYWNjIiwiYSI6ImNrcGtja3RodjM2cmMycGxhZnFic3NpcWQifQ.r0U6Cmw5kWGvOmgdZjC3Ng';

  Future<DrivingResponse> getCoordsInicioYDestino(LatLng inicio, LatLng destino) async {

    print('Inicio: $inicio');
    print('Destino: $destino');

    final coordString = '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this._baseUrl}/mapbox/driving/$coordString';

    final resp = await this._ido.get(url, queryParameters: {
      'alternatives' : 'true',
      'geometries'   : 'polyline6',
      'steps'        : 'false',
      'access_token' :  this._apiKey,
      'language'     : 'es',
    });

    final data = DrivingResponse.fromJson(resp.data);

    return data;

  }

}