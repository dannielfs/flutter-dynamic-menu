import 'package:flutter/material.dart';
import 'package:menu/models/MenuItemCustom.dart';

import 'main.dart';

class MenuItemPage extends StatefulWidget {
  const MenuItemPage({Key? key, this.id}) : super(key: key);
  final int? id;

  @override
  State<MenuItemPage> createState() => _MenuItemPageState();
}

class _MenuItemPageState extends State<MenuItemPage> {

  @override
  void initState() {
    super.initState();
  }

  Future<MenuItemCustom> loadItemDataForPage() async {
    MenuItemCustom localMenuItem = new MenuItemCustom(title: '', id: 0);
    await MyHomePage.futureMenuItems?.then((value) =>
    {localMenuItem = value.firstWhere((v) => v.id == widget.id)});
    return localMenuItem;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadItemDataForPage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // Future hasn't finished yet, return a placeholder
            return Text('Loading');
          }
          return Scaffold(
              appBar: AppBar(
                title: Text("Another Page"),
              ),
              body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('This is ID ${snapshot.data?.id}'),
                      Text(snapshot.data!.title),
                    ],
                  )));
        });
  }
}