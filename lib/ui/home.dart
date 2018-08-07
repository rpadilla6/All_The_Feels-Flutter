import 'package:all_the_feels_flutter/model/list_items.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListItem> items;

  _HomePageState() {
    // Generate the list of items for testing
    items = List<ListItem>.generate(16, (i) {
      if (i == 0) {
        return AppTitle("All The Feels");
      } else if (i == 1) {
        return SearchBar("$i with nature");
      } else {
        return TweetCard("user$i", "Tweet from user $i", 0.5);
      }
    });
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
                    return generateTitle(item);
                    // make the search bar
                  } else if (item is SearchBar) {
                    return generateSearchBar(item);
                    //Make the Cards
                  } else if (item is TweetCard) {
                    return generateTweetCard(item);
                  }
                })));
  }
  // Make the title inside a padding widget
  Padding generateTitle(AppTitle item){
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Center(
          child: Text(
            item.heading,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
                fontSize: 50.0,
                fontFamily: 'BarlowSemiCondensed'),
          ),
        ));
  }

  // Create the search bar as a text field with decoration (may animate)
  Container generateSearchBar(SearchBar item) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20.0),
        margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: new BorderRadius.circular(50.0),
            boxShadow: [
              new BoxShadow(
                  color: Colors.white, blurRadius: 20.0)
            ]),
        child: TextField(
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: item.searchHelp,
              icon: const Icon(Icons.search)),
        ));
  }

  // Create the tweet cards (will have to make async later)
  Card generateTweetCard(TweetCard item){
    return new Card(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child:
              ListTile(
                leading: const Icon(Icons.face),
                title: Text(item.handle),
                subtitle: Text(item.body),
              )
      ),
    );
  }
}
