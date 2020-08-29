import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_app_demo/blocs/rss_reader/rss_reader_bloc.dart';
import 'package:flutter_app_demo/views/rss_reader/rss_articles.dart';

class RssReaderView extends StatelessWidget {
  final RssReaderBloc bloc = new RssReaderBloc();

  RssReaderView() {
    bloc.initView();
  }

  dispose() {
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: _buildAppbar(context),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: bloc.feedItems,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                print(snapshot);
                if (!snapshot.hasData) return Container();
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArticleListWidget(
                                  bloc: bloc, url: snapshot.data[index]["url"])),
                        );
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(snapshot.data[index]["label"],
                        style: TextStyle(fontSize: 26.0)),
                        ),
                      )
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