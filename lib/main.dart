import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController;

  List<String> imagens = [
    'https://media.fstatic.com/s1LyixSnl1ZP4kLn4NYpZojT97g=/fit-in/290x478/smart/media/movies/covers/2018/05/IMG_20180531_123911.jpg',
    'https://2.bp.blogspot.com/-tbfOzJt0VOM/WxWWY69aozI/AAAAAAAAnes/FzkE7KPIx5EDsa4TaT8-vR7EIKlt3ZvbACLcBGAs/s1600/17_WIR2_DomTeaser2_1Sht_Brazil%2B%2528002%2529.jpg',
    'https://www.central42.com.br/novo/wp-content/uploads/2016/12/moana-cartaz.jpg'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: 1, viewportFraction: 0.6);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PageView.builder(
            controller: pageController,
            itemCount: imagens.length,
            itemBuilder: (context, position) {
              return imageSlider(position);
            }));
  }

  imageSlider(int position) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        double value = 1;

        if (pageController.position.haveDimensions) {
          value = pageController.page - position;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
        }

        return Center(
            child: SizedBox(
          height: Curves.easeOut.transform(value) * 200,
          width: Curves.easeOut.transform(value) * 300,
          child: widget,
        ));
      },
      child: Container(
        margin: EdgeInsets.all(10),
        child: Image.network(
          imagens[position],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
