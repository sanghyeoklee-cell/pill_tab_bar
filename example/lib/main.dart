import 'package:flutter/material.dart';
import 'package:pill_tab_bar/pill_tab_bar.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pill_tab_bar example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const _Demo(),
    );
  }
}

class _Demo extends StatefulWidget {
  const _Demo();

  @override
  State<_Demo> createState() => _DemoState();
}

class _DemoState extends State<_Demo> {
  int _two = 0;
  int _three = 1;
  int _custom = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('pill_tab_bar')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Two tabs (default theme)'),
                const SizedBox(height: 8),
                PillTabBar(
                  tabs: const [
                    PillTab(label: 'Body', icon: Icons.menu_book_outlined),
                    PillTab(label: 'Sketch', icon: Icons.edit_outlined),
                  ],
                  index: _two,
                  onChanged: (i) => setState(() => _two = i),
                ),
                const SizedBox(height: 32),
                const Text('Three tabs'),
                const SizedBox(height: 8),
                PillTabBar(
                  tabs: const [
                    PillTab(label: 'Day'),
                    PillTab(label: 'Week'),
                    PillTab(label: 'Month'),
                  ],
                  index: _three,
                  onChanged: (i) => setState(() => _three = i),
                ),
                const SizedBox(height: 32),
                const Text('Custom colors and height'),
                const SizedBox(height: 8),
                PillTabBar(
                  height: 40,
                  pillColor: Colors.indigo,
                  selectedForeground: Colors.white,
                  unselectedForeground: Colors.indigo.shade400,
                  backgroundColor: Colors.indigo.withValues(alpha: 0.08),
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: const [
                    PillTab(label: 'On', icon: Icons.toggle_on),
                    PillTab(label: 'Off', icon: Icons.toggle_off_outlined),
                  ],
                  index: _custom,
                  onChanged: (i) => setState(() => _custom = i),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
