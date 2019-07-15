import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_app_demo/bloc/rss_reader/rss_reader_bloc.dart';
import 'package:flutter_app_demo/models/article.dart';

class RssReaderView extends StatelessWidget {
  final RssReaderBloc bloc = RssReaderBloc();

  final List<List<String>> siteItems = [
    [
      '主なニュース',
      'https://news.yahoo.co.jp/pickup/rss.xml',
    ],
    [
      '国際ニュース',
      'https://news.yahoo.co.jp/pickup/world/rss.xml',
    ],
    [
      '国内ニュース',
      'https://news.yahoo.co.jp/pickup/domestic/rss.xml',
    ],
    [
      '経済関係',
      'https://news.yahoo.co.jp/pickup/economy/rss.xml',
    ],
    [
      'スポーツ',
      'https://news.yahoo.co.jp/pickup/sports/rss.xml',
    ],
    [
      'IT関連',
      'https://news.yahoo.co.jp/pickup/computer/rss.xml',
    ],
    [
      '科学技術',
      'https://news.yahoo.co.jp/pickup/science/rss.xml',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF58AB34),
        accentColor: Color(0xFFF4F4F4),
      ),
      home: Scaffold(
        backgroundColor: Color(0xFFF4F4F4),
        appBar: _buildAppbar(),
        body: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticleListWidget(
                                bloc: bloc, url: siteItems[index][1])),
                      );
                    },
                    child: Center(
                      child: Text(siteItems[index][0],
                          style: TextStyle(fontSize: 26.0)),
                    ),
                  );
                },
                itemCount: siteItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('images/logo.png'),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          tooltip: '設定',
          onPressed: () {/*処理*/},
          color: Colors.green,
        ),
        IconButton(
          icon: Icon(Icons.settings),
          tooltip: '設定',
          onPressed: () {/*処理*/},
          color: Colors.green,
        ),
      ],
    );
  }
}

class ArticleListWidget extends StatefulWidget {
  final RssReaderBloc bloc;
  final String url;

  ArticleListWidget({@required this.bloc, this.url});

  @override
  _ArticleListWidgetState createState() => new _ArticleListWidgetState();
}

class _ArticleListWidgetState extends State<ArticleListWidget> {
  List<Article> _articles = List<Article>();

  @override
  void initState() {
    super.initState();

    widget.bloc.launch(widget.url);
    widget.bloc.articles.listen((item) {
      if (item == null || item.length == 0) return;

      _articles.clear();

      setState(() {
        _articles.addAll(item);
        print("_articles: " + _articles.toString()); // LOG
      });
    });
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
      ),
      body: Center(
        child: (_articles == null || _articles.length == 0)
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: ListTile.divideTiles(
                  context: context,
                  tiles: _articles.map(
                    (article) {
                      return Card(
                        child: ListTile(
                          title: Text(article.title),
                          subtitle: GestureDetector(
                            onTap: () {
                              showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) {
                                  return WebView(initialUrl: article.link);
                                },
                              );
                            },
                            child: Text(article.pubDate,
                                style: TextStyle(fontSize: 13.0)),
                          ),
                        ),
                      );
                    },
                  ),
                ).toList(),
              ),
      ),
    );
  }
}
