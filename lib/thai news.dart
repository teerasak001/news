// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations, sort_child_properties_last, file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:thainews2/darwer.dart';
import 'package:thainews2/news.dart';

class ThaiNews extends StatefulWidget {
  const ThaiNews({Key? key}) : super(key: key);

  @override
  State<ThaiNews> createState() => _HomePageState();
}

class _HomePageState extends State<ThaiNews> {
  List<NewsThailand> newsList = [];

  // Fetch news data from the API
  Future<List<NewsThailand>> fetchNews() async {
    var response = await http.get(
      Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=th&category=business&apiKey=6ff8189dff8a4008b821ef746ba6ef74',
      ),
    );
    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);
      List<dynamic> articles = responseJson['articles'];
      newsList = articles.map((m) => NewsThailand.fromJson(m)).toList();
      return newsList;
    } else {
      throw Exception('Failed to load news');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        centerTitle: true,
        title: Text('Thailand News'),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading news'));
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  return _buildNewsCard(index);
                },
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildNewsCard(int index) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsList[index].title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'ผู้เขียน ${newsList[index].author}',
              style: TextStyle(
                fontSize: 18,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 36),
            Container(
              alignment: Alignment.center,
              child: Text(
                '${newsList[index].url}',
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(255, 176, 5, 5),
                ),
              ),
              width: double.infinity,
              height: 100,
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 243, 238, 238)),
            ),
          ],
        ),
      ),
    );
  }
}
