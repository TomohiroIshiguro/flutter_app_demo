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
            return ListView(
              children: ListTile.divideTiles(
                context: context,
                tiles: snapshot.data.map(
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
            );
          },
        ),
      ),
    );
  }
}
