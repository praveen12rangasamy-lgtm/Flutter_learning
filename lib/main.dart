import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

// =====================================================
// TASK MODEL
// =====================================================

class Task {
  final String title;
  final bool isCompleted;

  const Task({
    required this.title,
    this.isCompleted = false,
  });

  Task copyWith({
    String? title,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// =====================================================
// EVENTS
// =====================================================

// Base event
abstract class TaskEvent {}

// Add a task
class AddTask extends TaskEvent {
  final String title;

  AddTask(this.title);
}

// Toggle task
class ToggleTask extends TaskEvent {
  final int index;

  ToggleTask(this.index);
}

// Delete task
class DeleteTask extends TaskEvent {
  final int index;

  DeleteTask(this.index);
}

// =====================================================
// STATE
// =====================================================

class TaskState {
  final List<Task> tasks;

  const TaskState({
    this.tasks = const [],
  });

  TaskState copyWith({
    List<Task>? tasks,
  }) {
    return TaskState(
      tasks: tasks ?? this.tasks,
    );
  }
}

// =====================================================
// BLOC
// =====================================================

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(const TaskState()) {

    // -----------------------------------------------
    // ADD TASK
    // -----------------------------------------------

    on<AddTask>((event, emit) {
      final updatedTasks = [
        ...state.tasks,
        Task(title: event.title),
      ];

      emit(
        state.copyWith(
          tasks: updatedTasks,
        ),
      );
    });

    // -----------------------------------------------
    // TOGGLE TASK
    // -----------------------------------------------

    on<ToggleTask>((event, emit) {
      final updatedTasks =
          List<Task>.from(state.tasks);

      final task = updatedTasks[event.index];

      updatedTasks[event.index] =
          task.copyWith(
        isCompleted: !task.isCompleted,
      );

      emit(
        state.copyWith(
          tasks: updatedTasks,
        ),
      );
    });

    // -----------------------------------------------
    // DELETE TASK
    // -----------------------------------------------

    on<DeleteTask>((event, emit) {
      final updatedTasks =
          List<Task>.from(state.tasks);

      updatedTasks.removeAt(event.index);

      emit(
        state.copyWith(
          tasks: updatedTasks,
        ),
      );
    });
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

      title: 'BLoC Task Manager',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: BlocProvider(
        create: (context) => TaskBloc(),

        child: const TaskScreen(),
      ),
    );
  }
}

// =====================================================
// TASK SCREEN
// =====================================================

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // =================================================
      // APP BAR
      // =================================================

      appBar: AppBar(
        title: const Text('Task Manager'),

        actions: [
          IconButton(
            onPressed: () {
              showAddTaskDialog(context);
            },

            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),

      // =================================================
      // BODY
      // =================================================

      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {

          // Empty state
          if (state.tasks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [
                  Icon(
                    Icons.task_alt,
                    size: 80,
                    color: Colors.grey,
                  ),

                  SizedBox(height: 20),

                  Text(
                    'No tasks yet',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Tap + to add a task',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          // Task list
          return ListView.builder(
            padding: const EdgeInsets.all(12),

            itemCount: state.tasks.length,

            itemBuilder: (context, index) {

              final task = state.tasks[index];

              return Card(
                margin: const EdgeInsets.only(
                  bottom: 10,
                ),

                child: ListTile(

                  // Checkbox
                  leading: Checkbox(
                    value: task.isCompleted,

                    onChanged: (_) {
                      context.read<TaskBloc>().add(
                        ToggleTask(index),
                      );
                    },
                  ),

                  // Task title
                  title: Text(
                    task.title,

                    style: TextStyle(
                      fontSize: 16,

                      decoration:
                          task.isCompleted
                              ? TextDecoration
                                  .lineThrough
                              : TextDecoration.none,
                    ),
                  ),

                  // Delete
                  trailing: IconButton(
                    onPressed: () {

                      context
                          .read<TaskBloc>()
                          .add(
                            DeleteTask(index),
                          );
                    },

                    icon: const Icon(
                      Icons.delete,
                    ),
                  ),

                  onTap: () {
                    context
                        .read<TaskBloc>()
                        .add(
                          ToggleTask(index),
                        );
                  },
                ),
              );
            },
          );
        },
      ),

      // =================================================
      // BOTTOM TASK COUNT
      // =================================================

      bottomNavigationBar:
          BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {

          final completedTasks =
              state.tasks
                  .where(
                    (task) => task.isCompleted,
                  )
                  .length;

          return Container(
            padding: const EdgeInsets.all(16),

            child: Text(
              'Tasks: ${state.tasks.length}  |  '
              'Completed: $completedTasks',

              textAlign: TextAlign.center,

              style: const TextStyle(
                fontSize: 16,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  // ===================================================
  // ADD TASK DIALOG
  // ===================================================

  void showAddTaskDialog(BuildContext context) {

    final TextEditingController controller =
        TextEditingController();

    showDialog(
      context: context,

      builder: (dialogContext) {

        return AlertDialog(
          title: const Text(
            'Add Task',
          ),

          content: TextField(
            controller: controller,

            autofocus: true,

            decoration:
                const InputDecoration(
              labelText: 'Task',
              hintText:
                  'Enter task name',
            ),
          ),

          actions: [

            // Cancel
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                'Cancel',
              ),
            ),

            // Add
            ElevatedButton(
              onPressed: () {

                final title =
                    controller.text.trim();

                if (title.isEmpty) {
                  return;
                }

                context
                    .read<TaskBloc>()
                    .add(
                      AddTask(title),
                    );

                Navigator.pop(dialogContext);
              },

              child: const Text(
                'Add',
              ),
            ),
          ],
        );
      },
    );
  }
}