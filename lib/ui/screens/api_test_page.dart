import 'package:flutter/material.dart';
import 'package:plant_ecommerce/services/repository/news_model.dart';

import 'package:plant_ecommerce/services/repository/news_repository.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  bool isLoading = false;
  NewsModel? newsModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              NewsRepository news = NewsRepository();
              NewsModel? response = await news.getNews();

              setState(() {
                isLoading = false;
                newsModel = response;
              });
            },
            icon: const Icon(Icons.arrow_back),
          )
        ],
      ),
      body: Column(
        children: [
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (newsModel != null) ...[
            Text(newsModel!.status.toString()),
            Text(newsModel!.totalResults.toString()),
            Text(newsModel!.articles![0].source!.id.toString()),
            Text(newsModel!.articles![0].source!.name.toString()),
            Text(newsModel!.articles![0].author.toString()),
            Text(newsModel!.articles![0].title.toString()),
            Text(newsModel!.articles![0].description.toString()),
            Text(newsModel!.articles![0].url.toString()),
            Text(newsModel!.articles![0].urlToImage.toString()),
            Text(newsModel!.articles![0].publishedAt.toString()),
            Text(newsModel!.articles![0].content.toString()),
          ]
        ],
      ),
    );
  }
}
