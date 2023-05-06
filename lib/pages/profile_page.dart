import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.blue[300],
                child: Image.asset(
                  "assets/images/holding_back.png",
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Jessica Jane',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Major:',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Bsc Medicine',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),

            // List items
            /*ListTile(
              title: Text(
                '00-0000',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              leading: const Text(
                'Adm No',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              style: ListTileStyle.drawer,
              tileColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 18),
              trailing: Icon(CupertinoIcons.mail_solid),
            ),

            ListTile(
              title: Text(
                'Jessica@example.com',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
              leading: const Text(
                'Email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              style: ListTileStyle.drawer,
              tileColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 18),
              trailing: Icon(CupertinoIcons.mail_solid),
            )*/
          ],
        ),
      ),
    );
  }
}
