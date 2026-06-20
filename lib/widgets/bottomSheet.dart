import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mhc/modal/diary_modal/diary_modal.dart';

class ModalBottomSheet {
  static void show({
    required BuildContext context,
    required bool isEdit,
    DiaryModal? existingEntry,
    required Function(DiaryModal) onSumbit,
  }) {
    // Initialize controllers with existing data if editing
    final titleController = TextEditingController(text: isEdit ? existingEntry?.title : "");
    final descriptionController = TextEditingController(text: isEdit ? existingEntry?.description : "");
    final dateController = TextEditingController(text: isEdit ? existingEntry?.date : "");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allows keyboard to push sheet up
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom, // Handles keyboard
            left: 20, right: 20, top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Wrap content height
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  isEdit ? "Express!!" : "Add Note",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              
              // Title Field
              _buildTextField("Title", titleController),
              const SizedBox(height: 10),
              
              // Description Field
              _buildTextField("Description", descriptionController),
              const SizedBox(height: 10),
              
              // Date Field
              TextField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Date",
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    dateController.text = DateFormat('dd MMMM yyyy').format(picked);
                  }
                },
              ),
              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 139, 148, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (titleController.text.isNotEmpty) {
                      final newEntry = DiaryModal(
                        title: titleController.text,
                        description: descriptionController.text,
                        date: dateController.text,
                      );
                      onSumbit(newEntry);
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("Submit", style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  static void callSheet({required String title, required BuildContext context}){

    DiaryModal entry = DiaryModal(title: title, date: DateFormat('dd MMMM yyyy').format(DateTime.now()), description: '');
    show(
      context: context, 
      isEdit: true, 
      onSumbit: (DiaryModal p1) {
        p1.date = DateTime.now() as String;
        p1.title = title;
        p1.description = "";
      },
      existingEntry: entry
    );

  }
  static Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
