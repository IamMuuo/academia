import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class MembershipPage extends StatefulWidget {
  const MembershipPage({super.key});

  @override
  State<MembershipPage> createState() => _MembershipPageState();
}

class _MembershipPageState extends State<MembershipPage> {
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Memberships"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 8),
        child: Center(
          child: SchoolIDCard(
            user: userController.user.value!,
          ),
        ),
      ),
    );
  }
}
