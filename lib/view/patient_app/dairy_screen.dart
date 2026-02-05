import 'package:flutter/material.dart';
import 'package:mhc/modal/diary_modal/diary_modal.dart';
import 'package:mhc/modal/diary_modal/diary_notes.dart';
import 'package:intl/intl.dart';


class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  // Toggle this to switch between the two screenshots
  bool isLocked = true;

  List<DiaryModal> BTM_list =[];

  TextEditingController titleContoller = TextEditingController();
  TextEditingController dateContoller = TextEditingController();
  TextEditingController descriptionContoller = TextEditingController();

  final List<Map<String, dynamic>> entries = [
    {
      "date": "Oct 24, 2023",
      "text": "Today I practiced the breathing exercises...",
      "icon": Icons.air,
      "color": Colors.blue,
    },
    {
      "date": "Oct 23, 2023",
      "text": "The virtual pet reward really cheered me up...",
      "icon": Icons.sentiment_satisfied_alt,
      "color": Colors.green,
    },
    {
      "date": "Oct 22, 2023",
      "text": "Felt a bit overwhelmed by the project deadline...",
      "icon": Icons.error_outline,
      "color": Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "YOUR DIARY",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isLocked ? Icons.lock_outline : Icons.lock_open_rounded,
              color: Colors.blueAccent,
            ),
            onPressed: () => setState(() => isLocked = !isLocked),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Main Banner
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF8E86FF), Color(0xFF7B32FF)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isLocked ? Icons.lock_outline : Icons.lock_open,
                          size: 40,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          isLocked ? "PRIVACY PROTECTED" : "JOURNAL OPEN",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Diary Entries
                  ...BTM_list.map((entry) => GestureDetector(
                      onLongPress: () {
                        // Set controllers to current values for editing
                        titleContoller.text = entry.title;
                        descriptionContoller.text = entry.description;
                        dateContoller.text = entry.date;
                        showBottomSheet(edit: true, obj: entry);
                      },
                      child: diaryCard({
                        "date": entry.date,
                        "text": entry.description,
                        "icon": Icons.notes,
                        "color": Colors.purpleAccent,
                      }),
                    )).toList(),
                  // Share Section
                  const SizedBox(height: 10),
                  shareConsultantCard(),
                  const SizedBox(height: 100), // Space for the bottom nav
                ],
              ),
            ),
          ),

          // Floating Emergency Button
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: Colors.blue,
              onPressed: () {
                //Add note into diary
                showBottomSheet(edit: false, obj: DiaryModal(title: "", date: "", description: ""));
              },
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget diaryCard(Map<String, dynamic> entry) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(entry['icon'], color: entry['color']),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "ENTRY DATE",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    entry['date'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Spacer(),
              if (isLocked)
                const Icon(Icons.lock_outline, size: 16, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 15),
          isLocked
              ? Center(
                  child: TextButton(
                    onPressed: () => setState(() => isLocked = !isLocked),
                    child: const Text("Tap to Unlock"),
                  ),
                )
              : Text(
                  entry['text'],
                  style: TextStyle(color: Colors.grey.shade700),
                ),
        ],
      ),
    );
  }

  Widget shareConsultantCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2C),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.vpn_key_outlined, color: Colors.grey),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Share with Consultant",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "SECURE ACCESS LINK",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "A 7 - X 9 2 - K 0",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    letterSpacing: 2,
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(radius: 4, backgroundColor: Colors.green),
                    SizedBox(width: 5),
                    Text(
                      "ACTIVE",
                      style: TextStyle(color: Colors.green, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showBottomSheet({required bool edit, required DiaryModal obj}) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  Text(
                    "Create Task",
                    style: TextStyle(fontSize: 20 ,fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Text(" Title" , style: TextStyle(color: Color.fromRGBO(0, 139, 148, 1)),),
             
              TextField(
                controller: titleContoller,
                decoration: InputDecoration(
                  hint: Text("Title"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue)
                  ) 
                ),
              ),

              SizedBox(height: 10,),
              Text(" Description" , style: TextStyle(color: Color.fromRGBO(0, 139, 148, 1)),),
              TextField(
                controller: descriptionContoller,
                decoration: InputDecoration(
                  hint: Text("Description"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Color.fromRGBO(0, 139, 148, 1))
                  ) 
                ),
              ),

              SizedBox(height: 10,),
              Text(" Date" , style: TextStyle(color: Color.fromRGBO(0, 139, 148, 1)),),
              TextField(
                controller: dateContoller,
                readOnly: true,
                decoration: InputDecoration(
                  hint: Text("Date"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: Icon(Icons.calendar_month_outlined)
                ),
                onTap: () async{
                  DateTime? date_pic = await showDatePicker(
                    context: context, 
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950), 
                    lastDate: DateTime(2100),
                  );
                  if(date_pic!=null){
                    String formatted_date = DateFormat('dd MMMM yyyy').format(date_pic);
                    dateContoller.text = formatted_date;
                  }
                },
              ),

              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  SizedBox(
                    width: 380,
                    height: 50,
                    child: ElevatedButton(
                      style:ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        backgroundColor: Color.fromRGBO(0, 139, 148, 1),
                      ) ,
                      onPressed: (){
                        if(edit){
                          submit(true , obj);
                        }else{
                          submit(false);
                        }
                      },
                      child: const Text("Submit",style: TextStyle(fontSize: 20,color: Colors.white, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void clearController(){
    titleContoller.clear();
    descriptionContoller.clear();
    dateContoller.clear();
  }

  void submit( bool editTheCard , [DiaryModal? obj]){
    if (titleContoller.text.isNotEmpty && descriptionContoller.text.isNotEmpty && dateContoller.text.isNotEmpty){
      if(editTheCard){
        obj!.title = titleContoller.text;
        obj.description = descriptionContoller.text;
        obj.date = dateContoller.text;

        Map<String, dynamic> mapObj =  {
                      "title": titleContoller.text,
                      "description": descriptionContoller.text,
                      "date":  dateContoller.text

        };
        DiaryNotes().updateToDoItem(mapObj);
      }else{
        BTM_list.add(
          DiaryModal(title: titleContoller.text, date: dateContoller.text, description: descriptionContoller.text)
        );
        Map<String, dynamic> mapObj =  {
          "title": titleContoller.text,
          "description": dateContoller.text,
          "date": descriptionContoller.text
        };
        DiaryNotes().insertToDoItem(mapObj);
      }
      clearController();
      Navigator.of(context).pop();
      setState(() {});

    }
  }

}
