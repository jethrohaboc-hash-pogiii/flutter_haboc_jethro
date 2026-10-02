import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: StudentForm()));

class StudentForm extends StatefulWidget {
  const StudentForm({super.key});
  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final labels = ['Full Name', 'Age', 'Address', 'Contact Number', 'Email'];
  late final Map<String, TextEditingController> c = {
    for (var l in labels) l: TextEditingController(),
  };
  String gender = 'Male';
  bool submitted = false;

  bool get isValid => c.values.every((x) => x.text.trim().isNotEmpty);

  void clear() => setState(() {
    for (var x in c.values) {
      x.clear();
    }
    gender = 'Male';
    submitted = false;
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          for (var l in labels)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: TextField(
                controller: c[l],
                keyboardType: l == 'Age' || l == 'Contact Number'
                    ? TextInputType.number
                    : TextInputType.text,
                decoration: InputDecoration(
                  labelText: l,
                  border: const OutlineInputBorder(),
                  errorText: submitted && c[l]!.text.trim().isEmpty
                      ? '$l is required'
                      : null,
                ),
              ),
            ),
          Wrap(
            spacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text('Gender:'),
              for (var g in ['Male', 'Female', 'Other'])
                ChoiceChip(
                  label: Text(g),
                  selected: gender == g,
                  onSelected: (_) => setState(() => gender = g),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => submitted = true),
                child: const Text('Submit'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(onPressed: clear, child: const Text('Clear')),
            ],
          ),
          const SizedBox(height: 20),
          if (submitted && isValid)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  [
                    for (var l in labels) '$l: ${c[l]!.text}',
                    'Gender: $gender',
                  ].join('\n'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
