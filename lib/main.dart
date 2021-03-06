import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'SiparişVer',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];
  List _subItems = [];
  bool value = false;

  /* final GlobalKey<AppExpansionTileState> expansionTile = new GlobalKey();
  String foos = 'One';*/

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/menuler.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["menus"][0]["items"];
      _subItems = data["subMenus"];
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'SiparişVer',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextButton(
              child: const Text('Menüler'),
              onPressed: readJson,
            ),
            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Card(
                      margin: const EdgeInsets.all(10),
                      child: ExpansionTile(
                          leading: Image.asset(_items[index]["image"]),
                          title: Text(_items[index]["name"]),
                          children: <Widget>[
                            for (Map obj in _items[index]["items"])
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      obj["image"],
                                      height: 50,
                                      width: 50,
                                    ),
                                    Text(obj["name"]),
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        height: 20,
                                        child: Text(
                                          obj["price"].toString(),
                                        )),
                                    Checkbox(
                                      value: value,
                                      onChanged: (value) {
                                        setState(() {
                                          this.value = value!;
                                        });
                                      },
                                    ),

                                  ]),
                          ]));
                },
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }


}
