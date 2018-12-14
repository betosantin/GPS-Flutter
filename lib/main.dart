import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'GPS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var location = new Location();
  String rua = "", numero = "", bairro = "", cep = "", estado = "";

  Future locationGps() async {
    location
        .onLocationChanged()
        .listen((Map<String, double> currentLocation) async {
      final coordinates = new Coordinates(
          currentLocation["latitude"], currentLocation["longitude"]);
      List<Address> addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);

      setState(() {
        rua = addresses.first.thoroughfare;
        numero = addresses.first.subThoroughfare;
        bairro = addresses.first.subLocality;
        cep = addresses.first.postalCode;
        estado = addresses.first.adminArea;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(
                'Obter localização',
              ),
              onPressed: () {
                locationGps();
              },
            ),
            Column(children: <Widget>[
              Text("Rua: $rua"),
              Text("Número: $numero"),
              Text("Bairro: $bairro"),
              Text("CEP: $cep"),
              Text("Estado: $estado"),
//              Text("Número: " + numero),
//              Text("Bairro: " + bairro),
//              Text("CEP: " + cep),
//              Text("Estado: " + estado)
            ])
          ],
        ),
      ),
    );
  }
}
