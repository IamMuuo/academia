import 'package:academia/exports/barrel.dart';

class TimeLinePage extends StatelessWidget {
  const TimeLinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your semester timeline"),
      ),
      body: const Center(
        child: Text("Your semester timeline"),
      ),
    );
  }
}
