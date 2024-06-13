import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:academia/exports/barrel.dart';
import 'package:flutter/cupertino.dart';

class BirthDayPage extends StatelessWidget {
  const BirthDayPage({super.key});

  int get years {
    final UserController userController = Get.find<UserController>();
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    var dob = inputFormat.parse(userController.user.value!.dateOfBirth!);
    return DateTime.now().year - dob.year;
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hi"),
      ),
    );
  }
}
