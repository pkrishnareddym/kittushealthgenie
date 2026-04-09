import 'package:flutter/material.dart';
import 'patient_model.dart';

class PatientScreen extends StatefulWidget {
  const PatientScreen({super.key});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final List<Patient> patients = [];

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final problemController = TextEditingController();

  void addPatient() {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        problemController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all fields")));
      return;
    }

    int? age = int.tryParse(ageController.text);
    if (age == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Enter valid age")));
      return;
    }

    setState(() {
      patients.add(
        Patient(
          name: nameController.text,
          age: age,
          problem: problemController.text,
        ),
      );
    });

    nameController.clear();
    ageController.clear();
    problemController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    problemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patients")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 🔥 INPUT FIELDS
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Age",
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: problemController,
              decoration: InputDecoration(
                hintText: "Problem",
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // 🔥 BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: addPatient,
              child: const Text("Add Patient"),
            ),

            const SizedBox(height: 20),

            // 🔥 LIST
            Expanded(
              child: patients.isEmpty
                  ? const Center(child: Text("No Patients"))
                  : ListView.builder(
                      itemCount: patients.length,
                      itemBuilder: (context, index) {
                        final p = patients[index];
                        return ListTile(
                          title: Text(p.name),
                          subtitle: Text("${p.age} - ${p.problem}"),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
