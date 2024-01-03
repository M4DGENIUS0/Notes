import 'package:bottom_picker/bottom_picker.dart';
import 'package:flutter/material.dart';

// Date time picker Utils
Future Date_Time_Picker(
    BuildContext context, Function(DateTime) onDateTimeSelected) async {
  BottomPicker.dateTime(
    title: "Date & Time",
    titleStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black),
    // Voidcall back
    onSubmit: (date) {
      onDateTimeSelected(date);
      print(date);
    },
    // On Close
    onClose: () {
      Navigator.of(context).canPop();
      //
    },
    buttonText: 'Confirm',
    buttonTextStyle: const TextStyle(color: Colors.white),
    buttonSingleColor: Color.fromRGBO(131, 83, 105, 1),
    minDateTime: DateTime.now(),
    maxDateTime: DateTime(2024, 12, 12),
  ).show(context);
}
