import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select an option from the dropdown menu:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              items: [
                DropdownMenuItem(
                  value: 'option1',
                  child: Text('Option 1'),
                ),
                DropdownMenuItem(
                  value: 'option2',
                  child: Text('Option 2'),
                ),
              ],
              onChanged: (value) {
                // Handle dropdown item selection
                print('Selected: $value');
              },
              hint: Text('Select an option'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomText(),
    );
  }
}

class BottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: Colors.grey[300],
      child: Text(
        'Bottom Text',
        style: TextStyle(color: Colors.grey[600]),
      ),
    );
  }
}
