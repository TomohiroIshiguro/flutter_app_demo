import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_app_demo/blocs/rss_reader/rss_reader_bloc.dart';
import 'package:flutter_app_demo/views/rss_reader/rss_articles.dart';

class RssReaderView extends StatelessWidget {
  final RssReaderBloc bloc = new RssReaderBloc();

  RssReaderView();

  dispose() {
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppbar(context),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: bloc.feedItems,
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return FeedItemTile(bloc, snapshot.data[index]);
            },
          );
        },
      ),
    );
  }

  // RSSリーダー ビューのAppBar(画面上部)
  Widget _buildAppbar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('images/logo.png', height: 42),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          tooltip: '設定',
          onPressed: () {/*処理*/},
          color: Theme.of(context).accentColor,
        ),
        IconButton(
          icon: Icon(Icons.settings),
          tooltip: '設定',
          onPressed: () {/*処理*/},
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}

class FeedItemTile extends StatelessWidget {
  static RssReaderBloc _bloc;
  static Map<String, dynamic> _item;

  FeedItemTile(RssReaderBloc bloc, Map<String, dynamic> item){
    _bloc = bloc;
    _item = item;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleListWidget(
                    bloc: _bloc, url: _item["url"])),
          );
        },
        child: Card(
          child: ListTile(
            title: Text(_item["label"],
                style: TextStyle(fontSize: 26.0)),
          ),
        )
    );
  }
}
