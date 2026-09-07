import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// APP
// =====================================================

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social Profile',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SocialProfileScreen(),
    );
  }
}

// =====================================================
// PROFILE SCREEN
// =====================================================

class SocialProfileScreen extends StatefulWidget {
  const SocialProfileScreen({super.key});

  @override
  State<SocialProfileScreen> createState() {
    return _SocialProfileScreenState();
  }
}

// =====================================================
// STATE
// =====================================================

class _SocialProfileScreenState
    extends State<SocialProfileScreen> {

  bool isFollowing = false;

  int followers = 850;

  void toggleFollow() {
    setState(() {
      if (isFollowing) {
        isFollowing = false;
        followers--;
      } else {
        isFollowing = true;
        followers++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // =================================================
            // PROFILE HEADER
            // =================================================

            Stack(
              clipBehavior: Clip.none,
              children: [

                // -----------------------------
                // COVER IMAGE / BACKGROUND
                // -----------------------------

                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.blue.shade400,
                        Colors.blue.shade800,
                      ],
                    ),
                  ),
                ),

                // -----------------------------
                // PROFILE IMAGE
                // -----------------------------

                Positioned(
                  bottom: -60,
                  left: 0,
                  right: 0,

                  child: Center(
                    child: Container(
                      width: 120,
                      height: 120,

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          width: 5,
                          color: Colors.white,
                        ),
                      ),

                      child: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.person,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Space for overlapping profile image
            const SizedBox(height: 75),

            // =================================================
            // NAME
            // =================================================

            const Text(
              'Praveen',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Flutter Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            // =================================================
            // STATISTICS
            // =================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Row(
                children: [

                  Expanded(
                    child: _buildStat(
                      'Projects',
                      '12',
                    ),
                  ),

                  Expanded(
                    child: _buildStat(
                      'Followers',
                      followers.toString(),
                    ),
                  ),

                  Expanded(
                    child: _buildStat(
                      'Following',
                      '320',
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // FOLLOW BUTTON
            // =================================================

            SizedBox(
              width: 180,
              height: 45,

              child: ElevatedButton(
                onPressed: toggleFollow,

                child: Text(
                  isFollowing
                      ? 'Following'
                      : 'Follow',
                ),
              ),
            ),

            const SizedBox(height: 30),

            // =================================================
            // ABOUT
            // =================================================

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Flutter developer passionate about '
                    'building mobile applications and '
                    'learning new technologies.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Skills',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,

                    children: const [
                      Chip(
                        label: Text('Flutter'),
                      ),
                      Chip(
                        label: Text('Dart'),
                      ),
                      Chip(
                        label: Text('Firebase'),
                      ),
                      Chip(
                        label: Text('UI Design'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // STAT WIDGET
  // =====================================================

  Widget _buildStat(
    String title,
    String value,
  ) {
    return Column(
      children: [

        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}