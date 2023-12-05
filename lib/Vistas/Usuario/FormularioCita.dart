import 'package:flutter/material.dart';
import 'package:gps_baby_care/Controladores/citaController.dart';
import 'package:gps_baby_care/Modelos/citaModel.dart';

class FormularioCita extends StatefulWidget {
  final String idProfesional;
  final String idUsuario;

  const FormularioCita({
    Key? key,
    required this.idProfesional,
    required this.idUsuario,
  }) : super(key: key);

  @override
  _FormularioCitaState createState() => _FormularioCitaState();
}

class _FormularioCitaState extends State<FormularioCita> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _fecha;
  late String _motivo;

  @override
  void initState() {
    super.initState();
    _fecha = DateTime.now();
    _motivo = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Cita'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Fecha de la cita:'),
              SizedBox(height: 8.0),
              ListTile(
                title: Text(
                  '${_fecha.day}/${_fecha.month}/${_fecha.year}',
                ),
                trailing: Icon(Icons.calendar_today),
                onTap: _mostrarDatePicker,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Motivo de la cita',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el motivo de la cita';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _motivo = value;
                  });
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: _guardarCita,
                child: Text('Guardar Cita'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _mostrarDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (pickedDate != null && pickedDate != _fecha) {
      setState(() {
        _fecha = pickedDate;
      });
    }
  }

  Future<void> _guardarCita() async {
    if (_formKey.currentState!.validate()) {
      // Crear una nueva instancia de la cita
      Cita nuevaCita = Cita(
        idCita: '',
        idProfesional: widget.idProfesional,
        idUsuario: widget.idUsuario,
        fecha: _fecha,
        motivo: _motivo,
      );

      // Guardar la cita en la base de datos
      await CitaController.insertCita(nuevaCita);

      // Mostrar un mensaje de éxito y regresar a la pantalla anterior
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cita guardada con éxito'),
          key: UniqueKey(),
        ),
      );

      // Regresar a la pantalla anterior
      Navigator.pop(context);
    }
  }
}
