import 'package:flutter/material.dart';

class SearchSalaryScreen extends StatefulWidget{
  const SearchSalaryScreen({super.key});
  @override
  State<SearchSalaryScreen> createState(){
    return _SearchSalaryScreenState();
  }
}
  class _SearchSalaryScreenState extends State<SearchSalaryScreen>{
    @override
    Widget build(context){
      return const Text('Search Salary');
    }
  }