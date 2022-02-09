import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasim_sir_project/model.dart';

main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
    theme: ThemeData.dark(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Model> list = <Model>[];
  final url =
      'https://api.edamam.com/search?q=chicken&app_id=4719113b&app_key=098f9b18cf3e480f5fd6ff3290df7fc7';

  getApiData() async {
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e){
      Model model = Model(
          url: e['recipe']['uri'],
          image: e['recipe']['image'],
          source: e['recipe']['source'],
          label: e['recipe']['label']
      );
      setState(() {
        list.add(model);
      });
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe'),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.green.withOpacity(0.04),
                    filled: true),
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5
                  ),
                  itemCount: list.length,
                  itemBuilder: (context,i){
                    final x = list[i];
                    return Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(x.image.toString()),
                          )
                      ),

                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            height:40,
                            color: Colors.grey.withOpacity(0.3),
                            child: Text(x.label.toString(),style: TextStyle(fontSize: 20,color: Colors.lightBlue),),
                          )
                        ],
                      ),
                    );


                  })
            ],
          ),
        ),
      ),
    );
  }
}
