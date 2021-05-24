import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/bloc/mapa/mapa_bloc.dart';
import 'package:mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:mapas_app/widgets/widgets.dart';


class MapaPage extends StatefulWidget {

  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  @override
  void initState() {
    
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();

    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
        builder: ( _ , state) => _CrearMapa(state: state)
      ),

      floatingActionButton: Column( 
        mainAxisAlignment: MainAxisAlignment.end, 
        children: [

          BtnUbicacion(),

          BtnSeguirUbicacion(),

          BtnMiRuta(),

        ],
      ),
   );
  }


}

class _CrearMapa extends StatelessWidget {

  final MiUbicacionState state;

  const _CrearMapa({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    if(!state.existeUbicacion) return Center(child: Text('Ubicando...'));

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add(OnLocationUpdate(state.ubicacion));

    final cameraPosition = new CameraPosition(
      target: state.ubicacion,
      zoom: 15
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaBloc.initMapa,
      polylines: mapaBloc.state.polylines.values.toSet(),
      onCameraMove: ( cameraPosition ) {
        // cameraPosition.target = LatLng central del mapa
        mapaBloc.add( OnMovioMapa( cameraPosition.target ));
      },
    );


  }
}