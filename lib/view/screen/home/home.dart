import 'package:flutter/material.dart';
import 'package:flutter_masonry_view/flutter_masonry_view.dart';
import 'package:go_router/go_router.dart';
import 'package:randpaper/utils/routes/routes.dart';
import '../../../view_model/home/categoryBar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    createCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(),
              padding: EdgeInsets.symmetric(vertical: 18),

              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.keys.length,

                itemBuilder: (context, index) {
                  final title = categories.keys.toList()[index];
                  final isActive = categories[title]![0]['isActive'];

                  return Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: _buttons(
                      label: title,
                      isSelected: bool.parse(isActive!),
                    ),
                  );
                },
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: MasonryView(
                  listOfItem: imagesData,
                  numberOfColumn: 2,
                  itemBuilder: (item) {
                    final data = item as Map<String, String>;

                    return GestureDetector(

                      onTap: () {
                        context.push(
                          Routes.setWallpaper,
                          extra: data['image']!,
                        );
                      },

                      child: Hero(
                        tag: data['image']!,
                        child: Image.asset(data['image']!, fit: BoxFit.cover)
                      )
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttons({bool isSelected = false, String label = 'Button'}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          makeTrue(label);
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 40,
        margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
        constraints: const BoxConstraints(minWidth: 50, maxWidth: 100),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo : Colors.black,
          border: Border.all(width: 1, color: Colors.indigo),
          borderRadius: BorderRadius.circular(isSelected ? 10 : 20),
        ),

        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              overflow: TextOverflow.ellipsis
            ),
          ),
        ),
      ),
    );
  }
}
