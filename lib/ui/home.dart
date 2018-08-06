import 'package:all_the_feels_flutter/model/list_items.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListItem> items;

  _HomePageState() {
    items = List<ListItem>.generate(
      16,
      (i) => i == 0
          ? AppTitle("All The Feels")
          : TweetCard("user$i", "Tweet from user $i", 0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Theme.of(context).backgroundColor,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            // Make Title
            if (item is AppTitle) {
              return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text(
                      item.heading,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 50.0),
                    ),
                  ));
              //Make the Cards
            } else if (item is TweetCard) {
              return new Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 17.0),
                    ),
                    ListTile(
                      leading: const Icon(Icons.face),
                      title: Text(item.handle),
                      subtitle: Text(item.body),
                    )
                  ],
                ),
              );
            }
          }),
    ));
  }
}
