
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'IntershipInfo.dart';

class Intership extends StatelessWidget{
  const Intership({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor:  Colors.orange,
          title: const Center(child:  Text('Multitrabajos', textAlign: TextAlign.center)),
          elevation: 0,
        ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (BuildContext context, int index) {
              final item = _list[index];
              return InkWell(
                onTap: () {Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntershipInfo(id: index, empresa: item['empresa'], puesto: item['puesto'])));},
                child: Container(
                  height: 140,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['puesto'],
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    constraints: const BoxConstraints(maxWidth: 90),
                                    child: Text("${item['empresa']}",
                                      style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    constraints: const BoxConstraints(maxWidth: 150),
                                    child: Text(" - ${item['fecha']}",
                                      style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        const Icon(CupertinoIcons.building_2_fill, size: 16),
                                        Text(
                                            ' ${item['modalidad']}',
                                            style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.location_on, size: 16),
                                        Text(
                                            ' ${item['lugar']}',
                                            style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87)),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                      Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              border: Border.all(color: const Color(0xFF858383)),
                              borderRadius: BorderRadius.circular(50.0),
                              image: const DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage('https://play-lh.googleusercontent.com/rMUMXfTDJeDZciZ9sbLQcFWrGwyH85sl6caLc75jhEa3Msz1aGyzzrkclOsDC2zIRA'),
                              )
                          )
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

List<dynamic> _list = [];

class IntershipsData {
  static setIntershipsData(data) {
    _list = data;
    print('data loading');
  }
}



