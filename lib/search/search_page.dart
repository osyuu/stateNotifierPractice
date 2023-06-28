
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:state_notifier_practice/search/search_result_list.dart';
import 'package:state_notifier_practice/search/search_text_field.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TestSampleApp"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SearchTextField(),
            SizedBox(height: 20),
            Expanded(
              child: SearchResultList(),
            ),
          ],
        ),
      ),
    );
  }
}
