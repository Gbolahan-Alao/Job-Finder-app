import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchJobScreen extends StatefulWidget {
  const SearchJobScreen({super.key});
  @override
  State<SearchJobScreen> createState() {
    return _SearchJobScreenState();
  }
} 

class _SearchJobScreenState extends State<SearchJobScreen> {
  String searchQuery = '';
  String? selectedCategory = 'All Categories';
  String selectedLocation = 'All Locations';
  List<String> categories = [];
  List<dynamic> categoryList = [];

  filterJobs(String filterValue) {
    categoryList.where((element) =>
        element['label'].toString().toLowerCase() == filterValue.toLowerCase());
  }

  Future<void> fetchCategories(BuildContext context) async {
    const apiUrl =
        'http://api.adzuna.com/v1/api/jobs/gb/categories?app_id=db7a7949&app_key=c3831b1104d9aca46b5ed3af522f3170&&content-type=application/json';
    try {
      final response = await http.get(Uri.parse(apiUrl)); 
      print(response);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);   

        categoryList = jsonData['results'] as List;
        // print('categoryList: $categoryList');
        // var nameList = [];

        // for (var cate in categoryList) {
        //   var name = cate["label"];
        //   nameList.add(name);
        // }

        final categoryNames = categoryList
            .map((category) => category['label'] as String)   
            .toList();
        print('categoryNames: $categoryNames');
        setState(() {
          categories = ['All Categories', ...categoryNames];
        });
      } else {
        print('Error fetching categories: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred while fetching categories.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> _fetchJobs() async {
    const apiUrl =
        'https://api.adzuna.com/v1/api/jobs/gb/search/100?app_id=db7a7949&app_key=c3831b1104d9aca46b5ed3af522f3170';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final results = jsonData['results'] as List ;

        for (var result in results) {
          final category = result["category"];
          if (category != null) {
            final categoryLabel = category['label'];
            print('Category label: $categoryLabel');
          } 
        }
      } else {
        print('Api error');
      }
    } catch (e) {
      print(e);
    }
  }
  //   void fetchJobs() async {
  //   final url = Uri.parse('https://findwork.dev/api/jobs/');
  //   final headers = {
  //     'Authorization': '21c36ab994bce435ffe2e79f0cb641ebbbc39f0c'
  //   };

  //   final response = await http.get(url, headers: headers);

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //   } else {
  //     print('Request failed with status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    fetchCategories(context);
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Job Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedCategory,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: categories
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  filterJobs(searchQuery);
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search for jobs...',
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
              onPressed: _fetchJobs,
              child: const Text('Search Jobs'),
            ),
          ],
        ),
      ),
    );
  }
}
