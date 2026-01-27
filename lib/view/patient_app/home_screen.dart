import 'package:animated_custom_appbar/animated_custom_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMood = "";
  String hoveredMood = "";

  Widget buildMoodItem({required moodName, required iconName, required color}) {
    bool isSelected = selectedMood == moodName;
    bool isHovered = hoveredMood == moodName;

    return MouseRegion(
      onEnter: (_) => setState(() {
        hoveredMood = moodName;
      }),
      onExit: (_) => setState(() {
        hoveredMood = "";
      }),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          selectedMood = moodName;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withAlpha(50)
                : (isHovered ? Colors.grey.shade100 : Colors.transparent),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: isSelected ? color : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Icon(
                iconName,
                size: isHovered || isSelected ? 45 : 35, // Pop effect
                color: isSelected ? color : Colors.blueGrey,
              ),
              const SizedBox(height: 5),
              Text(
                moodName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? color : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMoodDetailWidget(String mood) {
    switch (mood) {
      case "HAPPY":
        return Column(
          children: [
            Text("SELECT TAGS THAT DESCRIBE YOUR HAPPY MOOD:"),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Joyful")),
                ElevatedButton(onPressed: () {}, child: Text("Excited")),
                ElevatedButton(onPressed: () {}, child: Text("Productive")),
                ElevatedButton(onPressed: () {}, child: Text("Social")),
              ],
            ),
          ],
        );
      case "SAD":
        return Column(
          children: [
            Text("SELECT TAGS THAT DESCRIBE YOUR SAD MOOD:"),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Lonely")),
                ElevatedButton(onPressed: () {}, child: Text("Tired")),
                ElevatedButton(onPressed: () {}, child: Text("Grief")),
                ElevatedButton(onPressed: () {}, child: Text("Low Energy")),
              ],
            ),
          ],
        );
      case "ANXIOUS":
        return Column(
          children: [
            Text("SELECT TAGS THAT DESCRIBE YOUR ANXIOUS MOOD:"),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 12,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Restless")),
                ElevatedButton(onPressed: () {}, child: Text("Panicked")),
                ElevatedButton(onPressed: () {}, child: Text("Streesed")),
                ElevatedButton(onPressed: () {}, child: Text("Worried")),
              ],
            ),
          ],
        );
      case "CALM":
        return Column(
          children: [
            Text("SELECT TAGS THAT DESCRIBE YOUR CALM MOOD:"),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Peaceful")),
                ElevatedButton(onPressed: () {}, child: Text("Mindful")),
                ElevatedButton(onPressed: () {}, child: Text("Content")),
                ElevatedButton(onPressed: () {}, child: Text("Rested")),
              ],
            ),
          ],
        );
      case "OKAY":
        return Column(
          children: [
            Text("SELECT TAGS THAT DESCRIBE YOUR OKAY MOOD:"),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: [
                ElevatedButton(onPressed: () {}, child: Text("Bored")),
                ElevatedButton(onPressed: () {}, child: Text("Uncertain")),
                ElevatedButton(onPressed: () {}, child: Text("Neutral")),
                ElevatedButton(onPressed: () {}, child: Text("Quiet")),
              ],
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedCustomAppBar(
        // rightWidget: null,
        profileIcon: Icon(Icons.person),
        minHeight: 50,
        maxHeight: 120,

        centerWidget: RichText(
          text: TextSpan(
            text: "Good Morning, User!!",
            style: TextStyle(color: Colors.black, fontSize: 25),
            children: [
              TextSpan(
                text: "\nWe're so glad you're here.",
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Card(
              elevation: 7,
              color: Colors.white,

              child: Column(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset("name"),
                  ),
                  SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(child: Icon(Icons.mic_none_outlined)),
                      SizedBox(width: 50),
                      CircleAvatar(child: Icon(Icons.card_giftcard)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Tap to tell me something",
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Card(
              elevation: 7,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  children: [
                    Text(
                      "How are you feeling today ?",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildMoodItem(
                            moodName: "HAPPY",
                            iconName: Icons.sentiment_satisfied_alt_outlined,
                            color: Colors.orange,
                          ),
                          buildMoodItem(
                            moodName: "SAD",
                            iconName: Icons.sentiment_dissatisfied,
                            color: Colors.blue,
                          ),
                          buildMoodItem(
                            moodName: "ANXIOUS",
                            iconName: Icons.warning_amber_outlined,
                            color: Colors.red,
                          ),
                          buildMoodItem(
                            moodName: "CALM",
                            iconName: Icons.air,
                            color: Colors.green,
                          ),
                          buildMoodItem(
                            moodName: "OKAY",
                            iconName: Icons.sentiment_neutral,
                            color: Colors.amber,
                          ),
                        ],
                      ),
                    ),
                    if (selectedMood.isNotEmpty) Divider(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: _buildMoodDetailWidget(selectedMood),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          
        },
        shape: const CircleBorder(),
        
        child: Icon(Icons.warning_amber, size: 30, color: Colors.white,),
      ),
    );
  }
}
