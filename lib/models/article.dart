class Article {
  /**
   * Field
   */
  String title; // 記事タイトル
  String link; // 記事リンク
  String pubDate; // 記事公開情報
  String enclosure; // 記事公開情報
  String guid; // 記事公開情報

  /**
   * Constructor
   */
  Article({this.title, this.link, this.pubDate, this.enclosure, this.guid});

  /**
   * Method
   */
  Map<String, dynamic> toMap() => {
        "title": title,
        "link": link,
        "pubDate": pubDate,
        "enclosure": enclosure,
        "guid": guid,
      };

  factory Article.fromMap(Map<String, dynamic> map) => Article(
        title: map["title"],
        link: map["link"],
        pubDate: map["pubDate"],
        enclosure: map["enclosure"],
        guid: map["guid"],
      );

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json['title'],
        link: json['link'],
        pubDate: json['pubDate'],
        enclosure: json['enclosure'],
        guid: json['guid'],
      );

  String toString() {
    return "- title: " + title + ",\n"
            "- link: " + link + ",\n"
            "- pubDate: " + pubDate + ",\n"
            "- enclosure: " + enclosure + ",\n"
            "- guid: " + guid;
  }
}
