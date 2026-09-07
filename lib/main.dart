import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================
// ROOT APPLICATION
// ============================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Card',

      home: const ProfileScreen(),
    );
  }
}

// ============================================================
// PROFILE SCREEN
// ============================================================

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [

              // ----------------------------------------------
              // PROFILE HEADER
              // ----------------------------------------------

              const ProfileHeader(),

              const SizedBox(height: 30),

              // ----------------------------------------------
              // CONTACT INFORMATION
              // ----------------------------------------------

              const ContactCard(
                icon: Icons.email_outlined,
                title: 'Email',
                value: 'praveen@gmail.com',
              ),

              const SizedBox(height: 15),

              const ContactCard(
                icon: Icons.phone_outlined,
                title: 'Phone',
                value: '+91 9876543210',
              ),

              const SizedBox(height: 15),

              const ContactCard(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: 'India',
              ),

              const SizedBox(height: 30),

              // ----------------------------------------------
              // EDIT PROFILE BUTTON
              // ----------------------------------------------

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {},

                  child: const Text(
                    'Edit Profile',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE HEADER WIDGET
// ============================================================

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        // Profile icon
        Container(
          width: 110,
          height: 110,

          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
            ),
          ),

          child: const Icon(
            Icons.person,
            size: 70,
          ),
        ),

        const SizedBox(height: 15),

        // Name
        const Text(
          'Praveen',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        // Job title
        const Text(
          'Flutter Developer',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

// ============================================================
// REUSABLE CONTACT CARD
// ============================================================

class ContactCard extends StatelessWidget {

  // These values are provided when we create the widget.
  final IconData icon;
  final String title;
  final String value;

  const ContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      // Padding inside the container.
      padding: const EdgeInsets.all(18),

      // Container decoration.
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
        ),

        borderRadius: BorderRadius.circular(15),
      ),

      child: Row(
        children: [

          // ----------------------------------------------
          // ICON
          // ----------------------------------------------

          Container(
            width: 50,
            height: 50,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),

            child: Icon(
              icon,
              size: 28,
            ),
          ),

          const SizedBox(width: 15),

          // ----------------------------------------------
          // TEXT
          // ----------------------------------------------

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}