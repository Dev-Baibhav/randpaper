import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:randpaper/view/screen/home/home.dart';
import 'package:randpaper/view/screen/setting/setting.dart';

final bottomTabIndexProvider = StateProvider<int>((ref) => 0);


class BottomTabBar extends ConsumerWidget {
	const BottomTabBar({super.key});

	static final List<Widget> _pages = <Widget>[
		Home(),
		Setting(),
	];

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final selectedIndex = ref.watch(bottomTabIndexProvider);
		return Scaffold(
			body: _pages[selectedIndex],
			bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        showUnselectedLabels: false,
        selectedIconTheme: const IconThemeData(size: 30, shadows: [
          Shadow(
            color: Color.fromARGB(66, 255, 255, 255),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ]),
				items: const <BottomNavigationBarItem>[
					BottomNavigationBarItem(
						icon: Icon(Icons.imagesearch_roller_outlined),
						label: 'Collection',
					),
					BottomNavigationBarItem(
						icon: Icon(Icons.settings),
						label: 'Setting',
					),
				],
				currentIndex: selectedIndex,
				onTap: (index) => ref.read(bottomTabIndexProvider.notifier).state = index,
			),
		);
	}
}