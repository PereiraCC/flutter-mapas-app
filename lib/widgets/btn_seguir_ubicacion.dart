part of 'widgets.dart';

class BtnSeguirUbicacion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
        return _Boton(state: state);
      },
    );
  }
}

class _Boton extends StatelessWidget {

  final MapaState state;

  const _Boton({Key key, @required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(  
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(  
          icon: Icon(
            state.seguirUbicacion
              ? Icons.directions_run
              : Icons.accessibility_new, 
            color: Colors.black87
          ),
          onPressed: () {
            mapaBloc.add(OnSeguirUbicacion());
          },
        ),
      ),
    );
  }
}