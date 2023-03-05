import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickField extends StatefulWidget {

  const DatePickField({required this.birthController, key}) : super(key: key);
  final TextEditingController birthController;

  @override
  State<DatePickField> createState() => _DatePickFieldState();
}

class _DatePickFieldState extends State<DatePickField> {
  TextEditingController? _birthController;

  @override
  void initState() {
    super.initState();
    _birthController = widget.birthController;
  }
  // final birthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _birthController,
      style: const TextStyle(fontSize: 40),
      decoration: const InputDecoration(
        hintText: 'date',
        hintStyle: TextStyle(fontSize: 30),
      ),
      onTap: () async {
        DateTime? newDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2030));
        if (newDate == null) {
          return;
        } else {
          setState(() {
            _birthController!.text = DateFormat.yMMMMd('en_US').format(newDate);
          });
        }
      },
    );
  }
}