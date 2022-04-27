class Character {
  int id;
  String name;
  String description;
  String resourceURI;
  List urls;
  Map thumbnail;
  // List comics;
  // List stories;
  // List events;
  // List series;

  Character(
    // this.comics,
    // this.stories,
    // this.events,
    // this.series,
    this.id,
    this.name,
    this.description,
    this.resourceURI,
    this.urls,
    this.thumbnail,
  );

  Character.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        resourceURI = json['resourceURI'],
        urls = json['urls'],
        thumbnail = json['thumbnail'];
  // comics = json['comics'].map((dynamic e) => print(e)),
  // stories = json['stories'].map<String>((e) {
  //   return e.toString();
  // }).toList(),
  // events = json['events'].map<String>((e) {
  //   return e.toString();
  // }).toList(),
  // series = json['series'].map<String>((e) {
  //   return e.toString();
  // }).toList();
}
