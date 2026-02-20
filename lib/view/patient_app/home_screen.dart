import 'package:animated_custom_appbar/animated_custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:mhc/widgets/bottomSheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedMood = "";
  bool catClicked =false;
  String gifVal="assets/catGif/Okay.gif";

  String moodGif({required String moodName }){

    switch(moodName){
      case "HAPPY":
        return "assets/catGif/Happy.gif";
      case "SAD":
        return "assets/catGif/Sad.gif";
      case "ANXIOUS":
        return "assets/catGif/Anxious.gif";
      case "CALM":
        return "assets/catGif/Calm.gif";
      case "OKAY":
        return "assets/catGif/Okay.gif";
      case "Feed":
        return "assets/catGif/Feed.gif";
      case "Hungry":
        return "assets/catGif/Hungry.gif";
      case "Listen":
        return "assets/catGif/Listen.gif";
      case "Gift":
        return "assets/catGif/Gift.gif";
      default:
        return "";
    }
  }

  Widget buildMoodItem({required String moodName, required IconData iconName, required Color color}) {
    bool isSelected = selectedMood == moodName;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMood = moodName;
          gifVal = moodGif(moodName: moodName);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? color.withAlpha(50) : Colors.transparent,
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
              size: isSelected ? 45 : 35,
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
    );
  }

  Widget _buildMoodDetailWidget(String mood) {
    switch (mood) {
      case "HAPPY":
        return Column(
          children: [
            const Text("SELECT TAGS THAT DESCRIBE YOUR HAPPY MOOD:"),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(7),
              child: Row(
                spacing: 10,
                children: [
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Joyful", context: context);
                  }, child: const Text("Joyful")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Excited", context: context);
                  }, child: const Text("Excited")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Productive", context: context);
                  }, child: const Text("Productive")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Social", context: context);
                  }, child: const Text("Social")),
                ],
              ),
            ),
          ],
        );
      case "SAD":
        return Column(
          children: [
            const Text("SELECT TAGS THAT DESCRIBE YOUR SAD MOOD:"),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(7),
              child: Row(
                spacing: 10,
                children: [
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Lonely", context: context);
                  }, child: const Text("Lonely")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Tired", context: context);
                  }, child: const Text("Tired")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Grief", context: context);
                  }, child: const Text("Grief")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Low Energy", context: context);
                  }, child: const Text("Low Energy")),
                ],
              ),
            ),
          ],
        );
      case "ANXIOUS":
        return Column(
          children: [
            const Text("SELECT TAGS THAT DESCRIBE YOUR ANXIOUS MOOD:"),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(7),
              child: Row(
                spacing: 10,
                // runSpacing: 12,
                children: [
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Restless", context: context);
                  }, child: const Text("Restless")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Panicked", context: context);

                  }, child: const Text("Panicked")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Streesed", context: context);

                  }, child: const Text("Streesed")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Worried", context: context);

                  }, child: const Text("Worried")),
                ],
              ),
            ),
          ],
        );
      case "CALM":
        return Column(
          children: [
            const Text("SELECT TAGS THAT DESCRIBE YOUR CALM MOOD:"),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(7),
              child: Row(
                spacing: 10,
                children: [
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Peaceful", context: context);
                  }, child: const Text("Peaceful")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Mindful", context: context);
                  }, child: const Text("Mindful")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Content", context: context);
                  }, child: const Text("Content")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Rested", context: context);
                  }, child: const Text("Rested")),
                ],
              ),
            ),
          ],
        );
      case "OKAY":
        return Column(
          children: [
            const Text("SELECT TAGS THAT DESCRIBE YOUR OKAY MOOD:"),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(7),
              child: Row(
                spacing: 10,
                children: [
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Bored", context: context);
                  }, child: const Text("Bored")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Uncertain", context: context);
                  }, child: const Text("Uncertain")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Neutral", context: context);
                  }, child: const Text("Neutral")),
                  ElevatedButton(onPressed: () {
                     ModalBottomSheet.callSheet(title: "Quiet", context: context);
                  }, child: const Text("Quiet")),
                ],
              ),
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
        profileIcon: const Icon(Icons.person),
        minHeight: 50,
        maxHeight: 120,
        centerWidget: RichText(
          text: const TextSpan(
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
                  GestureDetector(
                    onTap: ()=>setState(() {
                      catClicked=!catClicked;
                    }),
                    child: Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(gifVal, fit: BoxFit.fill, ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(child: Icon(Icons.mic_none_outlined)),
                      SizedBox(width: 50),
                      CircleAvatar(child: Icon(Icons.card_giftcard)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
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
                    const Text(
                      "How are you feeling today ?",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
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
                    if (selectedMood.isNotEmpty) const Divider(height: 10),
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
        child: const Icon(Icons.warning_amber, size: 30, color: Colors.white),
      ),
    );
  }


  
}