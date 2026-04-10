
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nasim_sir_project/web_view.dart';
import 'model.dart';

class SearchPage extends StatefulWidget {
  String? search;
  SearchPage({this.search});
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Model> list = <Model>[];
  String? text;

  getApiData(search) async {
    final url =
        'https://api.edamam.com/search?q=$search&app_id=4719113b&app_key=098f9b18cf3e480f5fd6ff3290df7fc7';

    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
          url: e['recipe']['url'],
          image: e['recipe']['image'],
          source: e['recipe']['source'],
          label: e['recipe']['label']);
      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApiData(widget.search);
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
              GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final x = list[i];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebPage(
                                  url: x.url,
                                )));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(x.image.toString()),
                            )),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              height: 40,
                              color: Colors.black.withOpacity(0.5),
                              child: Center(child: Text(x.label.toString())),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              height: 40,
                              color: Colors.black.withOpacity(0.5),
                              child: Center(
                                  child:
                                  Text("Source : " + x.source.toString())),
                            ),
                          ],
                        ),
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
