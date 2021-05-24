import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapas_app/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';


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
   );
  }


}

class _CrearMapa extends StatelessWidget {

  final MiUbicacionState state;

  const _CrearMapa({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    if(!state.existeUbicacion) return Center(child: Text('Ubicando...'));

    return Text('${state.ubicacion.latitude} , ${state.ubicacion.longitude}');


  }
}