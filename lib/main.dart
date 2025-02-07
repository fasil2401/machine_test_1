import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_machine_test_1/controller.dart';
/// Entrypoint of the application.
void main() {
  runApp(const MyApp());
}
/// Application itself.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salman\'s Machine test', 
      debugShowCheckedModeBanner: false,
      home: const HomePage());
  }
}


/// [Widget] displaying the home page consisting of an image the the buttons.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    /// Injecting Dependancy of Controller. 
    /// Refer controller file for buisiness logic
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: const Text('Salman\'s Machine Test')),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.urlController,
                        decoration: const InputDecoration(hintText: 'Image URL'),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: controller.setImage,
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 64),
              ],
            ),
          ),
          Obx(() => controller.menuVisible.value
              ? GestureDetector(
                  onTap: controller.toggleMenu,
                  child: Container(
                    color: Colors.black54,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 80,
                          right: 16,
                          child: SizedBox(
                            width: 200,
                            child: Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              elevation: 4,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      controller.enterFullscreen();
                                      controller.toggleMenu();
                                    },
                                    title: const Text('Enter Fullscreen'),
                                  ),
                                  ListTile(
                                    onTap: () {
                                      controller.exitFullscreen();
                                      controller.toggleMenu();
                                    },
                                    title: const Text('Exit Fullscreen'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.toggleMenu,
        child: const Icon(Icons.add),
      ),
    );
  }
}
