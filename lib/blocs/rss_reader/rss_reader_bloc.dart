import 'package:rxdart/rxdart.dart';

import 'package:flutter_app_demo/common/constants.dart';
import 'package:flutter_app_demo/data_access/web_launch.dart';
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
      "name": FEED_URL.BASE_URL + FEED_URL.NEWS + FEED_URL.FILE_NAME,
    },
    {
      "label": FEED_LABEL.WORLD,
      "name": FEED_URL.BASE_URL + FEED_URL.WORLD + FEED_URL.FILE_NAME,
    },
    {
      "label": FEED_LABEL.DOMESTIC,
      "name": FEED_URL.BASE_URL + FEED_URL.DOMESTIC + FEED_URL.FILE_NAME,
    },
    {
      "label": FEED_LABEL.ECONOMY,
      "name": FEED_URL.BASE_URL + FEED_URL.ECONOMY + FEED_URL.FILE_NAME,
    },
    {
      "label": FEED_LABEL.SPORTS,
      "name": FEED_URL.BASE_URL + FEED_URL.SPORTS + FEED_URL.FILE_NAME,
    },
    {
      "label": FEED_LABEL.COMPUTER,
      "name": FEED_URL.BASE_URL + FEED_URL.COMPUTER + FEED_URL.FILE_NAME,
    },
    {
      "label": FEED_LABEL.SCIENCE,
      "name": FEED_URL.BASE_URL + FEED_URL.SCIENCE + FEED_URL.FILE_NAME,
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
