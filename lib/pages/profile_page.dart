import 'package:academia/constants/common.dart';
import 'package:academia/widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academia/controllers/profile_page_controller.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController profilePageController =
        Get.put(ProfilePageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.settings),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // profile pic
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.blue[300],
                ),
                if (user.gpa! > 3.0)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2.0),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        CupertinoIcons.checkmark_seal_fill,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // name
          Container(
            padding: const EdgeInsets.only(top: 12, bottom: 3),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                user.name!,
                style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),

          // Course
          Container(
            padding: const EdgeInsets.only(bottom: 12),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                user.programme!,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),

          // school info
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.gpa.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            "GPA",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.completedUnits.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            "Completed Units",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*Container(
                    padding: const EdgeInsets.all(12),
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user.balance.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          const Text(
                            "Fee Balance",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Poppins",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Your Details",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),

                      // info cards
                      Expanded(
                        child: ListView(
                          children: [
                            // admno
                            InfoCard(
                              title: "Admission No",
                              content: user.admno!,
                              icon: CupertinoIcons.person_fill,
                            ),

                            // gender
                            InfoCard(
                              title: "Gender",
                              content: user.gender!,
                              icon: CupertinoIcons.person_2_fill,
                            ),

                            // dob
                            InfoCard(
                              title: "Date Of Birth",
                              content: user.dateOfBirth!,
                              icon: CupertinoIcons.calendar,
                            ),
                            // address
                            InfoCard(
                              title: "Address",
                              content: user.address!,
                              icon: CupertinoIcons.envelope_fill,
                            ),
                            // email
                            InfoCard(
                              title: "Email",
                              content: user.email!,
                              icon: CupertinoIcons.envelope_fill,
                            ),
                            InfoCard(
                              title: "Academic Status",
                              content: user.status!,
                              icon: CupertinoIcons.circle,
                            ),

                            // campus
                            InfoCard(
                              title: "Campus",
                              content: user.campus!,
                              icon: CupertinoIcons.flag_fill,
                            ),

                            // fee Info
                            InfoCard(
                              title: "Amount Billed",
                              content: user.amountBilled!,
                              icon: CupertinoIcons.money_rubl_circle_fill,
                            ),
                            InfoCard(
                              title: "Fee Paid",
                              content: user.amountPaid!,
                              icon: CupertinoIcons.money_euro_circle,
                            ),
                            InfoCard(
                              title: "Fee Balance",
                              content: user.amountPaid!,
                              icon: CupertinoIcons.money_euro_circle_fill,
                            ),

                            // button to refresh all content
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                minimumSize: const Size(300, 60),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Refresh Details',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
