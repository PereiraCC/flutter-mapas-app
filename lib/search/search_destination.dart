

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:mapas_app/models/search_result.dart';
import 'package:mapas_app/services/traffic_service.dart';

class SearchDestination extends SearchDelegate<SearchResult> {

  @override
  final String searchFieldLabel;
  final TrafficService _trafficService;
  final LatLng proximidad;

  SearchDestination(this.proximidad) 
  : this.searchFieldLabel = 'Buscar...',
    this._trafficService = new TrafficService();

    @override
    List<Widget> buildActions(BuildContext context) {

      return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => this.query = ''
        )
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {

      return IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => this.close(context, SearchResult(cancelo: true)),
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      
      this._trafficService.getResultadosPorQuery(this.query.trim(),  proximidad);

      return Text('Build Results');
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
      return ListView(
        children: [

          ListTile(  
            leading: Icon(Icons.location_on),
            title: Text('Color ubicacion manualmente'),
            onTap: () {
              this.close(context, SearchResult(cancelo: false, manual: true));
            },
          )

        ],
      );
    }

}