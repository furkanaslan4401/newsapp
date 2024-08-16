import 'package:flutter/material.dart';
import 'package:newsapppage/viewmodel/article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/category.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ArticleListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('News'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: 60,
            width: double.infinity,
            child: ListView(
              scrollDirection: Axis.horizontal,
            ),
          ),
          getWidgetByStatus(vm)
        ],
      ),
    );
  }


  Widget getWidgetByStatus(ArticleListViewModel vm) {
    switch (vm.status.index) {
      case 2:
        return Expanded(
            child: ListView.builder(
                itemCount: vm.viewModel.articles.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        Image.network(vm.viewModel.articles[index].urlToImage ??
                            'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132484366.jpg'),
                        ListTile(
                          title: Text(
                            vm.viewModel.articles[index].title ?? '',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              vm.viewModel.articles[index].description ?? ''),
                        ),
                        ButtonBar(
                          children: [
                            MaterialButton(
                              onPressed: () async {
                                await launchUrl(Uri.parse(
                                    vm.viewModel.articles[index].url ?? ''));
                              },
                              child: const Text(
                                'Habere Git',
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }));
      default:
        return const Center(child: CircularProgressIndicator());
    }
  }
}