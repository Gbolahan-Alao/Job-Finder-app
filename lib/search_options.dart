import 'package:flutter/material.dart';
import 'package:find_job/search_job.dart';
import 'package:find_job/search_salary.dart';


class SearchOptionPage extends StatefulWidget {
  const SearchOptionPage({super.key});
  @override
  State<SearchOptionPage> createState() {
    return _SearchOptionPageState();
  }
}

class _SearchOptionPageState extends State<SearchOptionPage> {
  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(249, 4, 88, 42),
          Color.fromARGB(255, 6, 65, 45)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextButton(
          style: TextButton.styleFrom(
              minimumSize: const Size(200, 70),
              backgroundColor:const Color.fromARGB(190, 0, 0, 0),
              textStyle: const TextStyle(fontSize: 25)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchJobScreen()),
            );
          },
          child: const Text(
            'Search Job',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        TextButton(
          style: TextButton.styleFrom(
              minimumSize: const Size(200, 70),
              backgroundColor: const Color.fromARGB(190, 0, 0, 0),
              textStyle: const TextStyle(fontSize: 25)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const SearchSalaryScreen()),
            );
          },
          child: const Text(
            'Search Salary',
            style: TextStyle(color: Colors.white),
          ),
        )
      ]),
    );
  }
}


