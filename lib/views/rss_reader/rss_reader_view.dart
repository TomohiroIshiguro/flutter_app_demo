import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_app_demo/bloc/rss_reader/rss_reader_bloc.dart';
import 'package:flutter_app_demo/models/article.dart';

class RssReaderView extends StatelessWidget {
  final RssReaderBloc bloc;

  RssReaderView({@required this.bloc}) {
    bloc.initView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppbar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<List<String>>>(
              stream: bloc.feedItems,
              builder: (BuildContext context,
                  AsyncSnapshot<List<List<String>>> snapshot) {
                print(snapshot.toString());
                if (!snapshot.hasData) return Container();
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleListWidget(
                                  bloc: bloc, url: snapshot.data[index][1])),
                        );
                      },
                      child: Center(
                        child: Text(snapshot.data[index][0],
                            style: TextStyle(fontSize: 26.0)),
                      ),
                    );
                  },
                  itemCount: snapshot.data.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppbar(BuildContext context) {
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
          color: Theme.of(context).primaryColor,
        ),
        IconButton(
          icon: Icon(Icons.settings),
          tooltip: '設定',
          onPressed: () {/*処理*/},
          color: Theme.of(context).primaryColor,
        ),
      ],
    );
  }
}

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
