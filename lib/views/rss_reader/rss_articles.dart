import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_app_demo/blocs/rss_reader/rss_reader_bloc.dart';
import 'package:flutter_app_demo/models/article.dart';

class ArticleListWidget extends StatelessWidget {
  final RssReaderBloc bloc;
  final String url;

  ArticleListWidget({@required this.bloc, this.url}) {
    bloc.launch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
      ),
      body: Center(
        child: StreamBuilder<List<Article>>(
          stream: bloc.articles,
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ArticleTile(snapshot.data[index]);
              }
            );
          },
        ),
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  static Article _article;

  ArticleTile(Article article) {
    _article = article;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(_article.title),
        subtitle: GestureDetector(
          onTap: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Web"),
                  ),
                  body: WebView(initialUrl: _article.link)
                );
              },
            );
          },
          child: Text(_article.pubDate,
              style: TextStyle(fontSize: 13.0)),
        ),
      ),
    );
  }
}
