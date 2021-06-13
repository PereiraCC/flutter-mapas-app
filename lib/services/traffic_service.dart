

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/models/search_response.dart';
import 'package:mapas_app/models/trafiic-response.dart';

class TrafficService {

  // Singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();
  factory TrafficService() {
    return _instance;
  }

  final _ido = new Dio();
  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey  = 'pk.eyJ1IjoicGVyZWlyYWNjIiwiYSI6ImNrcGtja3RodjM2cmMycGxhZnFic3NpcWQifQ.r0U6Cmw5kWGvOmgdZjC3Ng';

  Future<DrivingResponse> getCoordsInicioYDestino(LatLng inicio, LatLng destino) async {

    print('Inicio: $inicio');
    print('Destino: $destino');

    final coordString = '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this._baseUrlDir}/mapbox/driving/$coordString';

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

  Future<SearchResponse> getResultadosPorQuery(String busqueda, LatLng proximidad) async{

    final url = '${ this._baseUrlGeo }/mapbox.places/$busqueda.json';
    final resp = await this._ido.get(url, queryParameters: {
      'access_token' :  this._apiKey,
      'autocomplete' : 'true',
      'proximity'    : '${ proximidad.longitude },${ proximidad.latitude }',
      'language'     : 'es',
    });

    final searchResponse = searchResponseFromJson(resp.data);

    return searchResponse;

  }
}