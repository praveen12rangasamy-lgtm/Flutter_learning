import 'package:flutter/material.dart';

void main() {
  // Starting point of the Flutter application.
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

      title: 'Personal Dashboard',

      // First screen of the application.
      home: const DashboardScreen(),
    );
  }
}

// ============================================================
// DASHBOARD SCREEN
// ============================================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        title: const Text(
          'My Dashboard',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: false,

        // Notification button on the right side.
        actions: [
          IconButton(
            onPressed: () {
              // Notification action.
            },
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
        ],
      ),

      // ========================================================
      // DRAWER
      // ========================================================

      // Because Scaffold has a Drawer, Flutter automatically
      // creates the hamburger menu button in the AppBar.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,

          children: [

            // --------------------------------------------------
            // DRAWER HEADER
            // --------------------------------------------------

            const DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Icon(
                    Icons.account_circle,
                    size: 60,
                  ),

                  SizedBox(height: 10),

                  Text(
                    'My Dashboard',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 5),

                  Text(
                    'Welcome!',
                  ),
                ],
              ),
            ),

            // --------------------------------------------------
            // HOME
            // --------------------------------------------------

            ListTile(
              leading: const Icon(
                Icons.home,
              ),

              title: const Text(
                'Home',
              ),

              onTap: () {
                // Closes the drawer.
                Navigator.pop(context);
              },
            ),

            // --------------------------------------------------
            // PROFILE
            // --------------------------------------------------

            ListTile(
              leading: const Icon(
                Icons.person,
              ),

              title: const Text(
                'Profile',
              ),

              onTap: () {
                Navigator.pop(context);
              },
            ),

            // --------------------------------------------------
            // SETTINGS
            // --------------------------------------------------

            ListTile(
              leading: const Icon(
                Icons.settings,
              ),

              title: const Text(
                'Settings',
              ),

              onTap: () {
                Navigator.pop(context);
              },
            ),

            // --------------------------------------------------
            // LOGOUT
            // --------------------------------------------------

            ListTile(
              leading: const Icon(
                Icons.logout,
              ),

              title: const Text(
                'Logout',
              ),

              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // ==================================================
              // WELCOME SECTION
              // ==================================================

              const Center(
                child: Column(
                  children: [

                    // Profile icon.
                    Icon(
                      Icons.account_circle,
                      size: 90,
                    ),

                    SizedBox(height: 12),

                    // Greeting.
                    Text(
                      'Good Morning! 👋',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    // User name.
                    Text(
                      'Praveen',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // OVERVIEW
              // ==================================================

              const Text(
                'Overview',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              // ==================================================
              // STATISTICS CARDS
              // ==================================================

              Row(
                children: [

                  // ------------------------------------------------
                  // TASK CARD
                  // ------------------------------------------------

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),

                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Column(
                        children: [

                          Icon(
                            Icons.task_alt,
                            size: 40,
                          ),

                          SizedBox(height: 10),

                          Text(
                            '12',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'Tasks',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  // ------------------------------------------------
                  // COMPLETED CARD
                  // ------------------------------------------------

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),

                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                        ),

                        borderRadius: BorderRadius.circular(15),
                      ),

                      child: const Column(
                        children: [

                          Icon(
                            Icons.check_circle_outline,
                            size: 40,
                          ),

                          SizedBox(height: 10),

                          Text(
                            '8',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 5),

                          Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ==================================================
              // TODAY'S GOAL
              // ==================================================

              const Text(
                "Today's Goal",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),

                  borderRadius: BorderRadius.circular(15),
                ),

                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(
                      'Learn Flutter',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 5),

                    Text(
                      'Understand Flutter widgets and layout.',
                    ),

                    SizedBox(height: 20),

                    Text(
                      'Progress: 70%',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 10),

                    LinearProgressIndicator(
                      value: 0.7,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ==================================================
              // QUICK ACTIONS
              // ==================================================

              const Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                  ),

                  borderRadius: BorderRadius.circular(15),
                ),

                child: Row(
                  children: [

                    // Add task icon.
                    const Icon(
                      Icons.add_task,
                      size: 32,
                    ),

                    const SizedBox(width: 15),

                    // Text takes the available space.
                    const Expanded(
                      child: Text(
                        'Add a new task',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Add button.
                    ElevatedButton(
                      onPressed: () {
                        // Add task action.
                      },

                      child: const Text(
                        'Add',
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),

      // ========================================================
      // FLOATING ACTION BUTTON
      // ========================================================

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Floating action.
        },

        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}