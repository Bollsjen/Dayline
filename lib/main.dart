import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Migraine Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MigrainePage(),
    );
  }
}

class MigrainePage extends StatefulWidget {
  @override
  _MigrainePageState createState() => _MigrainePageState();
}

class _MigrainePageState extends State<MigrainePage> {
  Timer? _timer;
  DateTime? _startTime;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;
  String _selectedType = 'Aura';
  double _intensity = 5.0;
  String _selectedTrigger = 'None';
  String _selectedLocation = 'Frontal';
  TextEditingController _notesController = TextEditingController();

  List<String> _types = ['Aura', 'Headache'];
  List<String> _triggers = ['None', 'Stress', 'Lack of Sleep', 'Bright Lights', 'Food', 'Weather', 'Hormones', 'Exercise'];
  List<String> _locations = ['Frontal', 'Temporal', 'Occipital', 'Top of Head', 'Behind Eyes', 'Neck/Base'];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _notesController.dispose();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      _startTime = DateTime.now();
      _isRunning = true;
      _elapsed = Duration.zero;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_startTime != null) {
        setState(() {
          _elapsed = DateTime.now().difference(_startTime!);
        });
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isRunning = false;
    });
    _timer?.cancel();
    _showSaveDialog();
  }

  void _showSaveDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Save Episode'),
          content: Text('Episode recorded: ${_formatDuration(_elapsed)}\nType: $_selectedType'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetTimer();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _resetTimer() {
    setState(() {
      _startTime = null;
      _elapsed = Duration.zero;
      _isRunning = false;
      _intensity = 5.0;
      _selectedTrigger = 'None';
      _notesController.clear();
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hours = twoDigits(duration.inHours);
    String minutes = twoDigits(duration.inMinutes.remainder(60));
    String seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Migraine Tracker'),
        backgroundColor: Colors.blue[600],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Circular Timer
            Container(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _formatDuration(_elapsed),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _isRunning ? Colors.red[600] : Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _isRunning ? 'Running' : 'Stopped',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),

            // Start/Stop Button
            ElevatedButton(
              onPressed: _isRunning ? _stopTimer : _startTimer,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  _isRunning ? 'Stop Episode' : 'Start Episode',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _isRunning ? Colors.red[600] : Colors.green[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),

            SizedBox(height: 30),

            // Type Dropdown
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Episode Type',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: _types.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Intensity Slider
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Intensity: ${_intensity.round()}/10',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      value: _intensity,
                      min: 1,
                      max: 10,
                      divisions: 9,
                      label: _intensity.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _intensity = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Location Dropdown
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pain Location',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedLocation,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: _locations.map((String location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedLocation = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Trigger Dropdown
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Possible Trigger',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedTrigger,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      items: _triggers.map((String trigger) {
                        return DropdownMenuItem<String>(
                          value: trigger,
                          child: Text(trigger),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTrigger = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),

            // Notes
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notes',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Additional details about this episode...',
                        contentPadding: EdgeInsets.all(12),
                      ),
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            // History Button
            ElevatedButton.icon(
              onPressed: () {
                // Navigate to history page
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('History feature would be implemented here')),
                );
              },
              icon: Icon(Icons.history),
              label: Text('View History'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}