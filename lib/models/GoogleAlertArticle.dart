class GoogleAlertArticle {
  /* ------------------------------------------------------------ *
   * Field
   * ------------------------------------------------------------ */
  String title; // 記事タイトル
  String link; // 記事リンク
  String published; // 記事公開日
  String content; // 記事

  /* ------------------------------------------------------------ *
   * Constructor
   * ------------------------------------------------------------ */
  GoogleAlertArticle({this.title, this.link, this.published, this.content});

  /* ------------------------------------------------------------ *
   * Method
   * ------------------------------------------------------------ */
  Map<String, dynamic> toMap() => {
        "title": title,
        "link": link,
        "published": published,
        "enclosure": content,
      };

  factory GoogleAlertArticle.fromMap(Map<String, dynamic> map) =>
      GoogleAlertArticle(
        title: map["title"],
        link: map["link"],
        published: map["published"],
        content: map["content"],
      );
}
