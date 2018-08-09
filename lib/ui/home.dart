import 'package:all_the_feels_flutter/model/list_items.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// Need to consolidate, a lot done in this class
class _HomePageState extends State<HomePage> {
  List<ListItem> items;
  Widget tweetContainer;

  _HomePageState() {
    // Generate the list of items for testing
    items = List<ListItem>.generate(3, (i) {
      if (i == 0) {
        return AppTitle("All The Feels");
      } else if (i == 1) {
        return SearchBar("$i with nature");
      } else {
        return TweetCard("user$i", "Tweet from user $i", 0.5);
      }
    });
    tweetContainer = generateTweetCard();
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
                    // Otherwise return tweet container
                  } else {
                    return tweetContainer;
                  }
                })));
  }

  // Make the title inside a padding widget
  Padding generateTitle(AppTitle item) {
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
            boxShadow: [new BoxShadow(color: Colors.white, blurRadius: 20.0)]),
        child: TextField(
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: item.searchHelp,
              icon: const Icon(Icons.search)),
        ));
  }

  // Uses future builder to grab tweets (json data for testing)
  Widget generateTweetCard() {
    return new FutureBuilder(
      future: getTweets("test"),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          // Depending on how json data is returned could be map or list
          List tweets = snapshot.data;
          return new Container(
            child: ListView.builder(
              itemCount: tweets.length,
              // Need this in order to nest lists
              shrinkWrap: true,
              // Thanks youtube guy My Hexaville!
              physics: ClampingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: ListTile(
                        leading: const Icon(Icons.face),
                        title: Text(tweets[index]['title']),
                        subtitle: Text(tweets[index]['body']),
                      )),
                );
              },
            ),
          );
        } else {
          return new Container(
            constraints: BoxConstraints.expand(
                width: MediaQuery.of(context).size.width, height: 50.0),
            alignment: Alignment.center,
            child: Text(
              "I'm just temporary",
              style: TextStyle(
                  fontFamily: 'BarlowSemiCondensed',
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white),
            ),
          );
        }
      },
    );
  }

  // Future method to get the response query from backend
  Future<List> getTweets(String query) async {
    String url = "https://jsonplaceholder.typicode.com/posts";
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }
}
