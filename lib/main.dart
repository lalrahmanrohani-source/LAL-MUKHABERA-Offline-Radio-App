
import 'package:flutter/material.dart';

void main() {
  runApp(const LalMukhaberaApp());
}

class LalMukhaberaApp extends StatelessWidget {
  const LalMukhaberaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LAL MUKHABERA',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      home: const RadioPage(),
    );
  }
}

class RadioPage extends StatefulWidget {
  const RadioPage({super.key});

  @override
  State<RadioPage> createState() => _RadioPageState();
}

class _RadioPageState extends State<RadioPage> {
  bool connected = false;
  bool talking = false;
  String channel = 'CH 01';

  final name = TextEditingController(text: 'Lal Rahman');

  @override
  void dispose() {
    name.dispose();
    super.dispose();
  }

  void showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF07131D),
      appBar: AppBar(
        title: const Text(
          'LAL MUKHABERA',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const SizedBox(height: 15),

            const Icon(
              Icons.cell_tower,
              size: 95,
              color: Colors.cyanAccent,
            ),

            const SizedBox(height: 15),

            const Text(
              'OFFLINE RADIO',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'LOCAL COMMUNICATION SYSTEM',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60),
            ),

            const SizedBox(height: 30),

            Card(
              color: const Color(0xFF102B3A),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 13,
                          color: connected
                              ? Colors.greenAccent
                              : Colors.orange,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          connected ? 'CONNECTED' : 'DISCONNECTED',
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    TextField(
                      controller: name,
                      decoration: const InputDecoration(
                        labelText: 'Your Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),

                    const SizedBox(height: 18),

                    DropdownButtonFormField<String>(
                      value: channel,
                      decoration: const InputDecoration(
                        labelText: 'Radio Channel',
                        border: OutlineInputBorder(),
                      ),
                      items: List.generate(8, (i) {
                        final value =
                            'CH ${(i + 1).toString().padLeft(2, '0')}';
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        );
                      }),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => channel = value);
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: FilledButton.icon(
                        onPressed: () {
                          setState(() {
                            connected = !connected;
                            talking = false;
                          });
                          showMessage(
                            connected
                                ? 'Ready interface activated'
                                : 'Disconnected',
                          );
                        },
                        icon: const Icon(Icons.power_settings_new),
                        label: Text(
                          connected ? 'DISCONNECT' : 'CONNECT',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            Center(
              child: GestureDetector(
                onLongPressStart: (_) {
                  if (!connected) {
                    showMessage('Connect first');
                    return;
                  }
                  setState(() => talking = true);
                },
                onLongPressEnd: (_) {
                  setState(() => talking = false);
                },
                child: Container(
                  width: 175,
                  height: 175,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: talking ? Colors.red : Colors.teal,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.4),
                        blurRadius: 25,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mic,
                        size: 55,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        talking ? 'TALKING' : 'HOLD TO TALK',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'This is the radio interface prototype. '
                  'Real voice communication is not implemented yet. '
                  'It needs microphone permissions, local device '
                  'discovery and an audio connection service.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Created by Lal Rahman',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white54),
            ),
          ],
        ),
      ),
    );
  }
}
