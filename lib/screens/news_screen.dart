import 'package:flutter/material.dart';
import 'package:flutter_todo/models/news.dart';
import 'package:flutter_todo/providers/news_api.dart';

class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsApi newsApi = NewsApi();
  List<News> news = [];
  bool isLoading = true;

  Future initNews() async {
    news = await newsApi.getNews();
  }

  @override
  void initState() {
    super.initState();
    initNews().then(
      (value) {
        setState(() {
          isLoading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('뉴스 화면'),
        ),
        body: isLoading
            ? Center(child: const CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 4 / 3,
                  crossAxisSpacing: 20.0,
                ),
                itemCount: news.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(
                          news[index].title,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          news[index].description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16),
                        )
                      ],
                    ),
                  );
                },
              ));
  }
}
