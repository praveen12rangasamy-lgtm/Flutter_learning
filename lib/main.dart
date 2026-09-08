import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// =====================================================
// USER MODEL
// =====================================================

class User {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String website;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.website,
  });

  // JSON → Dart Object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      website: json['website'],
    );
  }
}

// =====================================================
// API SERVICE
// =====================================================

class ApiService {
  static const String url =
      'https://jsonplaceholder.typicode.com/users';

  Future<List<User>> fetchUsers() async {
    // Make GET request
    final response = await http.get(
      Uri.parse(url),
    );

    // Check response
    if (response.statusCode == 200) {
      // JSON string → Dart object
      final List<dynamic> data =
          jsonDecode(response.body);

      // Convert JSON objects → User objects
      return data
          .map(
            (json) => User.fromJson(json),
          )
          .toList();
    } else {
      throw Exception(
        'Failed to load users',
      );
    }
  }
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

      title: 'API Demo',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const UserScreen(),
    );
  }
}

// =====================================================
// USER SCREEN
// =====================================================

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() {
    return _UserScreenState();
  }
}

// =====================================================
// USER SCREEN STATE
// =====================================================

class _UserScreenState
    extends State<UserScreen> {

  // API service
  final ApiService apiService = ApiService();

  // User list
  List<User> users = [];

  // Loading status
  bool isLoading = true;

  // Error message
  String errorMessage = '';

  @override
  void initState() {
    super.initState();

    fetchUsers();
  }

  // ===================================================
  // FETCH USERS
  // ===================================================

  Future<void> fetchUsers() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final result =
          await apiService.fetchUsers();

      setState(() {
        users = result;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage =
            'Failed to load users';
      });
    }
  }

  // ===================================================
  // BUILD
  // ===================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users from API',
        ),

        actions: [
          IconButton(
            onPressed: fetchUsers,
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),

      body: buildBody(),
    );
  }

  // ===================================================
  // BODY
  // ===================================================

  Widget buildBody() {

    // -----------------------------------------------
    // LOADING
    // -----------------------------------------------

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // -----------------------------------------------
    // ERROR
    // -----------------------------------------------

    if (errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,

          children: [
            const Icon(
              Icons.error_outline,
              size: 70,
              color: Colors.red,
            ),

            const SizedBox(height: 20),

            Text(
              errorMessage,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: fetchUsers,
              child: const Text(
                'Try Again',
              ),
            ),
          ],
        ),
      );
    }

    // -----------------------------------------------
    // USERS
    // -----------------------------------------------

    return ListView.builder(
      padding: const EdgeInsets.all(12),

      itemCount: users.length,

      itemBuilder: (context, index) {
        final User user = users[index];

        return Card(
          margin: const EdgeInsets.only(
            bottom: 12,
          ),

          child: ListTile(
            contentPadding:
                const EdgeInsets.all(12),

            leading: CircleAvatar(
              child: Text(
                user.name[0],
              ),
            ),

            title: Text(
              user.name,
              style: const TextStyle(
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            subtitle: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 5),

                Text(user.email),

                const SizedBox(height: 3),

                Text(user.phone),
              ],
            ),

            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),

            onTap: () {
              showUserDetails(
                context,
                user,
              );
            },
          ),
        );
      },
    );
  }

  // ===================================================
  // USER DETAILS
  // ===================================================

  void showUserDetails(
    BuildContext context,
    User user,
  ) {
    showDialog(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: Text(
            user.name,
          ),

          content: Column(
            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                'Email: ${user.email}',
              ),

              const SizedBox(height: 10),

              Text(
                'Phone: ${user.phone}',
              ),

              const SizedBox(height: 10),

              Text(
                'Website: ${user.website}',
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}