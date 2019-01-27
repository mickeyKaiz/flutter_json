import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String name, username, avatar, location, followers, following, respo;
  bool isData = false;

  fetchJSON() async {
    var response = await http.get(
      "https://api.github.com/users/mickeykaiz",
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      String responseBody = response.body;
      var responseJSON = json.decode(responseBody);
      username = responseJSON['login'];
      avatar = responseJSON['avatar_url'];
      name = responseJSON['name'];
      location = responseJSON['location'];
      followers = responseJSON['followers'].toString();
      following = responseJSON['following'].toString();
      respo = responseJSON['public_repos'].toString();
      isData = true;
      setState(() {
        print('UI Updated');
      });
    } else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }
  }

  @override
  void initState() {
    fetchJSON();
  }

  Widget MyUI() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.white,foregroundColor: Colors.white,
                child: Center(child: Image.network(avatar)),
                radius: 30,
              ),
            ),
            Text(
              name,
              style: TextStyle(fontSize: 25),
            ),
            Text(
              username,
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              followers,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "FOLLOWERS",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              following,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "FOLLOWINGS",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              respo,
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "RESPOS",
                              style: TextStyle(fontSize: 10),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListView(
              children: <Widget>[ListTile(

              )],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter JSON (Github API)'),
            centerTitle: true,
            leading: Icon(Icons.favorite),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(Icons.call), onPressed: () {}),
            ],
          ),
          body: isData
              ? MyUI()
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}