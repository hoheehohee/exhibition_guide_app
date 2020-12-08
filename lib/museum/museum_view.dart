import 'package:flutter/material.dart';

class MuseumView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("코쟁이 박물관")
        ),
        body: Container(
          color: Colors.green
        ),
        drawer:  Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                  color: Colors.black12,
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Item 1'),
                        onTap: () {},
                      ),
                      ListTile(
                        title: Text('Item 2'),
                        onTap: () {},
                      ),
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}
