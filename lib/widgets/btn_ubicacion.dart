part of 'widgets.dart';

class BtnUbicacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final miubicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(  
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(  
          icon: Icon(Icons.my_location, color: Colors.black87),
          onPressed: () {
            final destino = miubicacionBloc.state.ubicacion;
            mapaBloc.moverCamara(destino);

          },
        ),
      ),
    );
  }
}