import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testt/second_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => HomeProvider(), child: const _HomePage());
  }
}

class HomeProvider extends ChangeNotifier {
  double height = 200;
  void changeHeight() {
    if (height == 200) {
      height = 400;
    } else {
      height = 200;
    }
    notifyListeners();
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedContainer(
            curve: Curves.easeInOut,
            height: context.watch<HomeProvider>().height,
            color: Colors.red,
            duration: const Duration(seconds: 1),
          ),
          ElevatedButton(
            onPressed: context.read<HomeProvider>().changeHeight,
            child: const Text('change container height'),
          ),
          //
          //
          //
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(_createRoute());
            },
            child: const Text('1. Set up a PageRouteBuilder'),
          ),

          //
          //
          //
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const SecondPage()),
                ),
              );
            },
            child: const Text('2. Create a Tween'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const SecondPage()),
                ),
              );
            },
            child: const Text('3. Use an AnimatedWidget'),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('home'),
      ),
    );
  }

  Route _createRoute() {
    return PageRouteBuilder(
      // transitionDuration: const Duration(milliseconds: 800),
      //to build the content of the route (pageBuilder)
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) =>
          const SecondPage(),
      //to build the route’s transition (transitionsBuilder).
      transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
      ) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInExpo;
        final tween = Tween(
          begin: begin,
          end: end,
        ).chain(
          CurveTween(curve: curve),
        );
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }
}
