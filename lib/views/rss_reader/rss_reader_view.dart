import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_app_demo/views/side_drawer.dart';
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
      appBar: _buildAppBar(context),
      endDrawer: SideDrawer(),
      body: _buildBody(context),
      backgroundColor: Theme.of(context).backgroundColor
    );
  }

  // RSSリーダー ビューのappBar(画面上部)
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('images/logo.png', height: 42),
      ),
    );
  }

  // RSSリーダー ビューのbody
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: bloc.feedItems,
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return FeedItemTile(bloc, snapshot.data[index]);
          },
        );
      },
    );
  }
}

class FeedItemTile extends StatelessWidget {
  RssReaderBloc _bloc;
  Map<String, dynamic> _item;

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
