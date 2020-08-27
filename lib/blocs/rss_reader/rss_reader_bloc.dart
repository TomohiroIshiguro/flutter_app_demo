import 'package:rxdart/rxdart.dart';

import 'package:flutter_app_demo/common/constants.dart';
import 'package:flutter_app_demo/blocs/rss_reader/web_launch.dart';
import 'package:flutter_app_demo/models/article.dart';

class RssReaderBloc {
  /* ------------------------------------------------------------ *
   * Field
   * ------------------------------------------------------------ */

  // 記事を取得する
  final _feedItemsController = PublishSubject<List<Map<String, dynamic>>>();
  Sink<List<Map<String, dynamic>>> get feedItemsSink => _feedItemsController.sink;
  Stream<List<Map<String, dynamic>>> get feedItems => _feedItemsController.stream;

  final _articlesController = PublishSubject<List<Article>>();
  Sink<List<Article>> get articlesSink => _articlesController.sink;
  Stream<List<Article>> get articles => _articlesController.stream;

  @override
  dispose() {
    _articlesController.close();
    _feedItemsController.close();
  }

  final List<Map<String, dynamic>> _feedItemList = [
    {
      "label": FEED_LABEL.NEWS,
      "url": FEED_URL.BASE_URL + FEED_URL.NEWS,
    },
    {
      "label": FEED_LABEL.WORLD,
      "url": FEED_URL.BASE_URL + FEED_URL.WORLD,
    },
    {
      "label": FEED_LABEL.DOMESTIC,
      "url": FEED_URL.BASE_URL + FEED_URL.DOMESTIC,
    },
    {
      "label": FEED_LABEL.ECONOMY,
      "url": FEED_URL.BASE_URL + FEED_URL.ECONOMY,
    },
    {
      "label": FEED_LABEL.SPORTS,
      "url": FEED_URL.BASE_URL + FEED_URL.SPORTS,
    },
    {
      "label": FEED_LABEL.COMPUTER,
      "url": FEED_URL.BASE_URL + FEED_URL.COMPUTER,
    },
    {
      "label": FEED_LABEL.SCIENCE,
      "url": FEED_URL.BASE_URL + FEED_URL.SCIENCE,
    },
  ];

  /* ------------------------------------------------------------ *
   * Constructor
   * ------------------------------------------------------------ */
  RssReaderBloc();

  /* ------------------------------------------------------------ *
   * Method
   * ------------------------------------------------------------ */
  void initView() {
    feedItemsSink.add(_feedItemList);
  }

  void launch(String url) async {
    articlesSink.add(await WebLaunch().getArticles(url));
  }
}
