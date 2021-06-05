part of 'mapa_bloc.dart';

@immutable
class MapaState {

  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;
  final LatLng ubicacionCentral;

  //Polylines
  final Map<String, Polyline> polylines;

  MapaState({
    this.mapaListo = false,
    this.dibujarRecorrido = false,
    this.seguirUbicacion = false,
    Map<String, Polyline> polylines,
    this.ubicacionCentral
  }) : this.polylines = polylines ?? new Map();

  MapaState copyWith({
    bool mapaListo,
    bool dibujarRecorrido,
    bool seguirUbicacion,
    LatLng ubicacionCentral,
    Map<String, Polyline> polylines
  }) => new MapaState(
    mapaListo : mapaListo ?? this.mapaListo,
    polylines: polylines ?? this.polylines,
    seguirUbicacion  : seguirUbicacion ?? this.seguirUbicacion,
    dibujarRecorrido : dibujarRecorrido ?? this.dibujarRecorrido,
    ubicacionCentral : ubicacionCentral ?? this.ubicacionCentral

  );

}