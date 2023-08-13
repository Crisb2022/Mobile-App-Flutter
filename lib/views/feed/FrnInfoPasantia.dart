import 'package:flutter/material.dart';

class FrmInfoPasantia extends StatefulWidget {
  final Map<String, dynamic> pasantia;

  FrmInfoPasantia({required this.pasantia});

  @override
  _FrmInfoPasantiaState createState() => _FrmInfoPasantiaState();
}

class _FrmInfoPasantiaState extends State<FrmInfoPasantia> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/images/${widget.pasantia['imagen']}.webp',
            ),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 300),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            alignment: Alignment.center,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                'assets/images/startApp.jpg',
                              ), // Cambia la imagen de perfil
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            widget.pasantia['empresa'] ?? '',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.pasantia['detalle'] ?? '',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Perfil necesario: ${widget.pasantia['imagen'] ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Detalles:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ubicación: ${widget.pasantia['direccion'] ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Horas Requeridas: ${widget.pasantia['horas_requeridas'] ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Remunerado: ${widget.pasantia['remunerado'] ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Modalidad: ${widget.pasantia['modalidad'] ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Telefono: ${widget.pasantia['telefono'] ?? ''}',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Acción para subir hoja de vida
                            },
                            child: Text('Subir Hoja de Vida'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
