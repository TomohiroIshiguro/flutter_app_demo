import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import 'package:flutter_app_demo/models/article.dart';

class WebLaunch {
  Future<List<Article>> getArticles(String url) async {
    print("----- WebAPIをコールする"); // LOG
    print("url: " + url);
    final response = await http.get(url);
    switch (response.statusCode) {
      case 200:
        print("-- 成功"); // LOG
//        print("status: " + response.statusCode.toString()); // LOG

        xml.XmlDocument document = xml.parse(response.body);
//        print("document: " + document.toString()); // LOG

        List<Article> articles = [];
        Iterable<xml.XmlElement> items = document.findAllElements('item');
        items.map((xml.XmlElement item) {
          String title = getValue(item.findElements("title"));
          String link = getValue(item.findElements("link"));
          String pubDate = getValue(item.findElements("pubDate"));
          String enclosure = getValue(item.findElements("enclosure"));
          String guid = getValue(item.findElements("guid"));
          articles.add(Article(
              title: title,
              link: link,
              pubDate: pubDate,
              enclosure: enclosure,
              guid: guid));
        }).toList();
        return articles;

      default:
        throw Exception('Fail to get data with WebAPI');
    }
  }

  getValue(Iterable<xml.XmlElement> items) {
    var textValue;
    items.map((xml.XmlElement node) {
      textValue = node.text;
    }).toList();
    return textValue;
  }
}
