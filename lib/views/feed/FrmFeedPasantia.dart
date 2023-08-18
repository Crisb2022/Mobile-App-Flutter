import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pasantapp/views/feed/FrnInfoPasantia.dart';
import 'dart:convert';

class FeedHome extends StatefulWidget {
  static const routeName = '/feed-one-screen';

  @override
  _FeedHomeState createState() => _FeedHomeState();
}

class _FeedHomeState extends State<FeedHome> {
  List<Map<String, dynamic>> pasantias = [];
  String searchQuery = '';

  Future<void> getPasantias() async {
    var urlCasa = 'http://192.168.100.240:7001/estudiantes/feed';
    final response = await http.get(Uri.parse(urlCasa));
    if (response.statusCode == 200) {
      setState(() {
        pasantias = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  @override
  void initState() {
    super.initState();
    getPasantias(); // Llama al método automáticamente al abrir la ventana
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredPasantias = pasantias
        .where((pasantia) => pasantia['imagen']
            .toLowerCase()
            .contains(searchQuery.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2A3EB0), // Cambia el color de fondo
        elevation: 5,
        centerTitle: true, // Centra el título en la AppBar
        title: const Text(
          'PassApp',
          style: TextStyle(
            fontSize: 24, // Tamaño de fuente del título
            fontWeight: FontWeight.bold, // Peso de fuente del título
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 28, // Tamaño del ícono de búsqueda
            ),
            onPressed: () async {
              final String? selected = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(filteredPasantias),
              );

              if (selected != null && selected != searchQuery) {
                setState(() {
                  searchQuery = selected;
                });
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView.builder(
            itemCount: filteredPasantias.length,
            itemBuilder: (BuildContext context, int index) {
              final pasantia = filteredPasantias[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => FrmInfoPasantia(
                      pasantia: pasantia,
                    ),
                  ));
                },
                child: Container(
                  height: 150,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pasantia['empresa'] ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color:  Color(0xFF2A3EB0),
                                fontSize: 20,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.person),
                                const SizedBox(width: 8),
                                Text(
                                  "Cargo: ${pasantia['cargo']}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.schedule),
                                const SizedBox(width: 8),
                                Text(
                                  "Horario: ${pasantia['horas_requeridas']}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const Icon(Icons.category),
                                const SizedBox(width: 8),
                                Text(
                                  "Modalidad: ${pasantia['modalidad']}",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/${pasantia['imagen']}.webp"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> items;

  CustomSearchDelegate(this.items);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implementar si es necesario
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? []
        : items
            .where((pasantia) =>
                pasantia['imagen'].toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (BuildContext context, int index) {
        final pasantia = suggestionList[index];
        return ListTile(
          title: Text(pasantia['imagen']),
          onTap: () {
            close(context, pasantia['imagen']);
          },
        );
      },
    );
  }
}
