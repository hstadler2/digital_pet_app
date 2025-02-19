import 'dart:async';  // Import dart:async to use Timer for scheduling repetitive tasks
import 'package:flutter/material.dart';  // Importing Flutter material package for UI components

void main() {
  runApp(MaterialApp(
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Your Pet";  // Variable to store the pet's name
  int happinessLevel = 50;  // Variable to store the pet's happiness level
  int hungerLevel = 50;  // Variable to store the pet's hunger level
  Timer? _timer;  // Timer to manage automatic hunger increase over time

  final myController = TextEditingController();  // Controller for the pet name text field

  @override
  void initState() {
    super.initState();
    // Setting up a timer to periodically increase the pet's hunger
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      setState(() {
        hungerLevel = (hungerLevel + 5).clamp(0, 100);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();  // Cancelling the timer when the widget is disposed
    super.dispose();
  }

  Color getPetColor() {
    // Determines the pet's color based on happiness level
    if (happinessLevel > 70) return Colors.green;  // Green when happy
    if (happinessLevel < 30) return Colors.red;    // Red when unhappy
    return Colors.yellow;                          // Yellow when neutral
  }

  String getMoodIcon() {
    // Returns an emoji representing the pet's mood based on happiness level
    if (happinessLevel > 70) return '😃';  // Happy
    if (happinessLevel < 30) return '😢';  // Unhappy
    return '😐';                          // Neutral
  }

  void _playWithPet() {
    // Method to increase happiness and adjust hunger when playing with the pet
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
    });
  }

  void _feedPet() {
    // Method to decrease hunger and adjust happiness when feeding the pet
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
    });
  }

  void _updateHappiness() {
    // Adjusts happiness based on the current hunger level
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
  }

  void _updateHunger() {
    // Method to incrementally increase hunger over time
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),  // Title in the app bar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4GA8fjB5zYPwpvr7CUTo1k-WK08iRoAu2mg&s',
              height: 200,
              width: 200,
              color: getPetColor(),  // Color overlay based on pet's mood
            ),
            SizedBox(height: 16.0),
            Text(
              'Name: $petName',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Happiness Level: $happinessLevel ${getMoodIcon()}',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _feedPet,
              child: Text('Feed Your Pet'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Pet Name',
                ),
                onSubmitted: (String value) {
                  setState(() {
                    petName = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      //Tried adding the win/loss condition julia made here, but coulnd't get her code to work without missing deadline
    );
  }
}
