part of 'widgets.dart';

class SearchBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        
        if(state.seleccionManual) {
          return Container();
        } else {
          return FadeInDown(
            duration: Duration(milliseconds: 300),
            child: buildSearchnar(context)
          );
        }

      },
    );
  }

  
  Widget buildSearchnar(BuildContext context) {

    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: width,
        child: GestureDetector(
          onTap: () async {

            final proximidad =  BlocProvider.of<MiUbicacionBloc>(context).state.ubicacion;
            final historial = BlocProvider.of<BusquedaBloc>(context).state.historial;

            final resultado = await showSearch(
              context: context, 
              delegate: SearchDestination(proximidad, historial)
            );
            this.retornoBusqueda(context, resultado);
          },
          child: Container(  
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            width: double.infinity,
            child: Text('¿Donde quieres ir?', style: TextStyle(color: Colors.black87)),
            decoration: BoxDecoration(  
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(  
                  color: Colors.black12, 
                  blurRadius: 5, 
                  offset: Offset(0, 5)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }

  Future retornoBusqueda(BuildContext context, SearchResult result) async{

    final busquedaBloc = BlocProvider.of<BusquedaBloc>(context);
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);

    if(result.cancelo) return;

    if(result.manual ) {
      busquedaBloc.add(OnActivarMarcadorManual());
      return;
    }

    //Calcular la ruta en base al valor: Result
    final trafficService = new TrafficService();
    
    final inicio = miUbicacionBloc.state.ubicacion;
    final destino = result.position;

    final drivingResponse = await trafficService.getCoordsInicioYDestino(inicio, destino);

    final geometry = drivingResponse.routes[0].geometry;
    final duracion = drivingResponse.routes[0].duration;
    final distancia = drivingResponse.routes[0].distance;
    final nombreDestino = result.nombreDestino;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> rutaCoordenadas = points.decodedCoords.map(
      (point) => LatLng(point[0], point[1])
    ).toList();

    mapaBloc.add( OnCrearRutaInicioDestino(rutaCoordenadas, distancia, duracion, nombreDestino));

    Navigator.of(context).pop();

    //Agregar al historial
    busquedaBloc.add(OnAgregarHistorial(result));

  }

  
}

