
class FEEDS {
  // Tips: Json形式は、Map<String, dynamic> で表す
  static final feedItemList = [
    {
      "label": _newsLabel,
      "url": _baseUrl + _news,
    },
    {
      "label": _worldLabel,
      "url": _baseUrl + _world,
    },
    {
      "label": _domesticLabel,
      "url": _baseUrl + _domestic,
    },
    {
      "label": _economyLabel,
      "url": _baseUrl + _economy,
    },
    {
      "label": _sportsLabel,
      "url": _baseUrl + _sports,
    },
    {
      "label": _computerLabel,
      "url": _baseUrl + _computer,
    },
    {
      "label": _scienceLabel,
      "url": _baseUrl + _science,
    },
  ];

  static final _newsLabel = "主なニュース";
  static final _worldLabel = "国際ニュース";
  static final _domesticLabel = "国内ニュース";
  static final _economyLabel = "経済関係";
  static final _sportsLabel = "スポーツ";
  static final _computerLabel = "IT関連";
  static final _scienceLabel = "科学技術";

  static final _baseUrl = "https://news.yahoo.co.jp/rss/";
  static final _news = "topics/top-picks.xml";
  static final _world = "topics/world.xml";
  static final _domestic = "topics/domestic.xml";
  static final _economy = "topics/business.xml";
  static final _sports = "topics/sports.xml";
  static final _computer = "topics/it.xml";
  static final _science = "topics/science.xml";
}