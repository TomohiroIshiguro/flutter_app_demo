import 'package:rxdart/rxdart.dart';

import 'package:flutter_app_demo/constants.dart';
import 'package:flutter_app_demo/data_access/web_launch.dart';
import 'package:flutter_app_demo/models/article.dart';

class RssReaderBloc {
  /* ------------------------------------------------------------ *
   * Field
   * ------------------------------------------------------------ */

  // 記事を取得する
  final _feedItemsController = PublishSubject<List<List<String>>>();
  Sink<List<List<String>>> get feedItemsSink => _feedItemsController.sink;
  Observable<List<List<String>>> get feedItems => _feedItemsController.stream;

  final _articlesController = PublishSubject<List<Article>>();
  Sink<List<Article>> get articlesSink => _articlesController.sink;
  Observable<List<Article>> get articles => _articlesController.stream;

  final List<List<String>> _feedItemList = [
    [
      FEED_LABEL.NEWS,
      FEED_URL.BASE_URL + FEED_URL.NEWS + FEED_URL.FILE_NAME,
    ],
    [
      FEED_LABEL.WORLD,
      FEED_URL.BASE_URL + FEED_URL.WORLD + FEED_URL.FILE_NAME,
    ],
    [
      FEED_LABEL.DOMESTIC,
      FEED_URL.BASE_URL + FEED_URL.DOMESTIC + FEED_URL.FILE_NAME,
    ],
    [
      FEED_LABEL.ECONOMY,
      FEED_URL.BASE_URL + FEED_URL.ECONOMY + FEED_URL.FILE_NAME,
    ],
    [
      FEED_LABEL.SPORTS,
      FEED_URL.BASE_URL + FEED_URL.SPORTS + FEED_URL.FILE_NAME,
    ],
    [
      FEED_LABEL.COMPUTER,
      FEED_URL.BASE_URL + FEED_URL.COMPUTER + FEED_URL.FILE_NAME,
    ],
    [
      FEED_LABEL.SCIENCE,
      FEED_URL.BASE_URL + FEED_URL.SCIENCE + FEED_URL.FILE_NAME,
    ],
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

  dispose() {
    _articlesController.close();
  }
}
