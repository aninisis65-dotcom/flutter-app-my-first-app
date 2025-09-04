import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KDP Sizes App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, String>> sizes = [
    {
      "title": "5x8 in",
      "desc": "📘 مقاس صغير مناسب للكتب الخفيفة والروايات.",
      "image": "https://i.imgur.com/7M1j0pN.png"
    },
    {
      "title": "6x9 in",
      "desc": "📗 الأكثر شيوعًا في KDP للكتب التعليمية والروايات.",
      "image": "https://i.imgur.com/pqDjOaN.png"
    },
    {
      "title": "8.5x11 in",
      "desc": "📕 مناسب للكتب الدراسية والمجلات الكبيرة.",
      "image": "https://i.imgur.com/NMdHMSF.png"
    },
    {
      "title": "7x10 in",
      "desc": "📙 خيار وسط بين الحجم المتوسط والكبير.",
      "image": "https://i.imgur.com/z3D0kOz.png"
    },
  ];

  String query = "";

  @override
  Widget build(BuildContext context) {
    // تصفية القائمة حسب البحث
    final filteredSizes = sizes.where((size) {
      final title = size["title"]!.toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("📐 KDP Sizes App"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SizeSearchDelegate(sizes),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredSizes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: Icon(Icons.book, color: Colors.blue, size: 30),
              title: Text(
                filteredSizes[index]["title"]!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text("اضغط لعرض التفاصيل"),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      title: filteredSizes[index]["title"]!,
                      desc: filteredSizes[index]["desc"]!,
                      image: filteredSizes[index]["image"]!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

// 🔎 كلاس البحث
class SizeSearchDelegate extends SearchDelegate {
  final List<Map<String, String>> sizes;

  SizeSearchDelegate(this.sizes);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = sizes.where((size) =>
        size["title"]!.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView(
      children: results.map((size) {
        return ListTile(
          title: Text(size["title"]!),
          subtitle: Text(size["desc"]!),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  title: size["title"]!,
                  desc: size["desc"]!,
                  image: size["image"]!,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = sizes.where((size) =>
        size["title"]!.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView(
      children: suggestions.map((size) {
        return ListTile(
          title: Text(size["title"]!),
          onTap: () {
            query = size["title"]!;
            showResults(context);
          },
        );
      }).toList(),
    );
  }
}

// 📄 صفحة التفاصيل
class DetailPage extends StatelessWidget {
  final String title;
  final String desc;
  final String image;

  DetailPage({required this.title, required this.desc, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Image.network(image, height: 200, fit: BoxFit.contain),
            SizedBox(height: 20),
            Text(
              desc,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
