abstract class ListItem {}

class AppTitle implements ListItem {
  final String heading;

  AppTitle(this.heading);
}

class TweetCard implements ListItem {
  final String handle;
  final String body;
  final double rating;

  TweetCard(this.handle, this.body, this.rating);
}

class SearchBar implements ListItem {
  final String searchHelp;

  SearchBar(this.searchHelp);
}
