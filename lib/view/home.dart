import 'package:flutter/material.dart';
import 'package:news_app/controller/FetchNews.dart';
import 'package:news_app/model/newsArt.dart';
import 'package:news_app/view/widget/NewsContainer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  late NewsArt newsArt;

  getNews() async {
    newsArt = (await FetchNews.fetchnews()) as NewsArt;

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: PageController(initialPage: 0),
        scrollDirection: Axis.vertical,
        onPageChanged: (value) {
          setState(() {
            isLoading = true;
          });
          getNews();
        },
        itemBuilder: (context, index) {
          return isLoading
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : NewsContainer(
            imgUrl: newsArt.imgUrl,
            newsCnt: newsArt.newsCnt,
            newsHead: newsArt.newsHead,
            desc: newsArt.newsDes,
            url: newsArt.newsUrl,
          );
        },
      ),
    );
  }
}
