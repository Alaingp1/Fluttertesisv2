import 'package:flutter/material.dart';
import 'package:flutter_tesisv2/src/cultivos/sensores/models/sensor_model.dart';
import 'package:flutter_tesisv2/src/cultivos/sensores/providers/sensor_provider.dart';
import 'package:flutter_tesisv2/src/empresa/bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sensores extends StatefulWidget {
  static const String ROUTE = "/Sensores";

  Sensores({Key key}) : super(key: key);

  @override
  _SensoresState createState() => _SensoresState();
}

class _SensoresState extends State<Sensores> {
  SensorModel sensor = SensorModel();
  final sensorProvider = SensorProvider();
  final _formKey = GlobalKey<FormState>();
  TextEditingController minima = TextEditingController();
  TextEditingController maxima = TextEditingController();
  TextEditingController humedad = TextEditingController();
  TextEditingController macAddress = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 131, 163, 1),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
            child: Column(
              children: [
                listaSensores(),
                FlatButton(
                  color: Color.fromRGBO(0, 131, 163, 1),
                  onPressed: _submit,
                  child: Text(
                    "asignar parametros",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ClienteBottomBar('cultivos'),
    );
  }

  Widget listaSensores() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text("Ingrese la temperatura minima de su cultivo:"),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 60),
          child: TextField(
            controller: minima,
            maxLength: 2,
            decoration: InputDecoration(
              labelText: 'Temperatura minima',
              suffixText: 'c°',
            ),
            enabled: true,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Ingrese la temperatura maxima de su cultivo:"),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 60),
          child: TextField(
            controller: maxima,
            maxLength: 2,
            decoration: InputDecoration(
              labelText: 'Sensores maxima',
              suffixText: 'c°',
            ),
            enabled: true,
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text("Ingrese la humedad minima se su cultivo:"),
        SizedBox(
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(right: 60),
          child: TextField(
            controller: humedad,
            maxLength: 2,
            decoration: InputDecoration(
              labelText: 'Humedad del cultivo',
              suffixText: '%',
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void _submit() {
    var placa = ModalRoute.of(context).settings.arguments as String;

    sensor.temp_minima = int.parse(minima.text);
    sensor.temp_maxima = int.parse(maxima.text);
    sensor.humedad_minima = int.parse(humedad.text);

    sensorProvider.actualizarDatos(placa, sensor);
  }
}
