import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PanelController pc = PanelController();

    return Scaffold(
      body: SlidingUpPanel(
        controller: pc,
        defaultPanelState: PanelState.CLOSED,
        maxHeight: 300,
        minHeight: 0,
        panel: const Center(
          child: Text('data'),
        ),
        body: Column(
          children: [
            //images go on top of the title, so means here
            Container(),
          ],
        ),
      ),
      bottomNavigationBar: NewWidget(pc: pc),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({Key? key, required this.pc}) : super(key: key);

  final PanelController pc;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.transparent,
      child: Row(
        children: [
          IconButton(
              icon: const Icon(Icons.add_box_outlined),
              onPressed: () {
                pc.open();
              }),
        ],
      ),
    );
  }
}

class CustomStickyBottomAppBar extends StatelessWidget {
  const CustomStickyBottomAppBar({Key? key, required this.child})
      : super(key: key);
  final BottomAppBar child;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(0.0, -1 * MediaQuery.of(context).viewInsets.bottom),
      child: child,
    );
  }
}
