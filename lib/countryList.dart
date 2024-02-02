import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  String selectedCountry = 'Select a country';
  late List<Map<String, dynamic>> countryList = [];
  late Map<String, dynamic> selectedCountryDetails = {};

  @override
  void initState() {
    super.initState();
    getCountryList().then((list) {
      setState(() {
        countryList = list;
      });
    });
  }

  Future<List<Map<String, dynamic>>> getCountryList() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('Failed to load country list');
    }
  }

  void updateSelectedCountryDetails(String countryName) {
    setState(() {
      selectedCountryDetails = countryList.firstWhere(
        (country) => country['name']['common'] == countryName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('E-commerce'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          if (countryList.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: DropdownButton<String>(
                isExpanded: true,
                items: countryList
                    .map((country) => DropdownMenuItem<String>(
                          value: country['name']['common'],
                          child: Row(
                            children: [
                              Image.network(
                                country['flags']['png'],
                                width: 30,
                                height: 20,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 8),
                              Text(country['name']['common']),
                              SizedBox(width: 8),
                              Text(
                                '(${country['cca2']})',
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedCountry = value ?? 'Select a country';
                    updateSelectedCountryDetails(selectedCountry);
                  });
                },
                hint: Text(selectedCountry),
              ),
            ),
          if (countryList.isEmpty)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      bottomNavigationBar: Text("hai"),
    );
  }
}
