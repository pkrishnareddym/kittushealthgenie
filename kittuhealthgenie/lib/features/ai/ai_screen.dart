import 'package:flutter/material.dart';
import 'services/diagnosis_service.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final TextEditingController controller = TextEditingController();

  String result = "";
  bool isLoading = false;

  void handleAnalyze() {
    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      final output = DiagnosisService.analyze(controller.text);

      if (!mounted) return;

      setState(() {
        result = output;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("AI Doctor 🤖"),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter symptoms...",
                hintStyle: const TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: handleAnalyze,
              child: const Text("Analyze"),
            ),

            const SizedBox(height: 20),

            if (isLoading) const CircularProgressIndicator(),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.blueAccent),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.4),
                    blurRadius: 30,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: result.isEmpty
                  ? const Text(
                      "Enter symptoms...",
                      style: TextStyle(color: Colors.white54),
                    )
                  : AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: Text(
                        result,
                        key: ValueKey(result),
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
