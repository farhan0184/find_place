import 'package:find_place/item_list.dart';
import 'package:find_place/nav_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget appBarTitle = Text("Taeaqub");
  Icon actionIcon = Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: appBer(),
      body: ItemList(),
    );
  }

  AppBar appBer() {
    
    return AppBar(
    backgroundColor: Color.fromARGB(255, 56, 96, 142),
    centerTitle: true,
    title: appBarTitle,
    actions: <Widget>[
      IconButton(
        icon: actionIcon,
        onPressed: () {
          setState(() {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = Icon(Icons.close);
              this.appBarTitle = TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    hintText: 'Search.....',
                    hintStyle: TextStyle(color: Colors.white)),
              );
            } else {
              this.actionIcon = Icon(Icons.search);
              this.appBarTitle = Text('Taeaqub');
            }
          });
        },
      )
    ],
  );
  }
}


