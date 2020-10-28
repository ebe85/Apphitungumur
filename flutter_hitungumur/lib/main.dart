import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kalkulator Umur',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Kalkulator Umur'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;
  bool _validate = false;
  bool _validate2 = false;
  bool _validate3 = false;
  TextEditingController tgl = TextEditingController();
  TextEditingController bln = TextEditingController();
  TextEditingController thn = TextEditingController();
  String itgl;
  String ibln;
  String ithn;
  String tglLahir;

  @override
  void dispose() {
    tgl.dispose();
    bln.dispose();
    thn.dispose();
    super.dispose();
  }
  void _hitungUmur() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
     // _counter++;
      itgl=tgl.text;
      ibln=bln.text;
      ithn=thn.text;
      tgl.text.isEmpty ? _validate = true : _validate = false;
      bln.text.isEmpty ? _validate2 = true : _validate2 = false;
      thn.text.isEmpty ? _validate3 = true : _validate3 = false;
    });

    DateTime currentDate = DateTime.now();
    String datePattern = "dd-MM-yyyy";
    DateTime tglLhr = DateTime(
      int.parse(ithn),
      int.parse(ibln),
      int.parse(itgl),
    );
    int tahun = currentDate.year - tglLhr.year;
    int bulan = currentDate.month - tglLhr.month;
    int hari = currentDate.day - tglLhr.day;
    if (bulan < 0 || (bulan == 0 && hari < 0)) {
      tahun--;
      bulan += (hari < 0 ? 11 : 12);
    }

    if (hari < 0) {
      final monthAgo = new DateTime(currentDate.year, currentDate.month - 1, tglLhr.day);
      hari = currentDate.difference(monthAgo).inDays + 1;
    }
    /*if(bulan<0){
      bulan=0;
    }else{
      bulan;
    };
    if(hari<0){
      hari=0;
    }else{
      hari;
    }*/

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {Navigator.of(context).pop(); },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Hasil"),
      content: Text("Umur anda adalah \n"+tahun.toString()+" Tahun "+bulan.toString()+" Bulan "+hari.toString()+" Hari \natau jika dibulatkan "+tahun.toString()+" tahun"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(widget.title),
      ),
      body:Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Flexible(
                    child: new TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        controller: tgl,
                        decoration: InputDecoration(
                            labelText: 'Tanggal',
                            errorText: _validate ? 'Not Empty' : null,
                            contentPadding: EdgeInsets.all(10)
                        )
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  new Flexible(
                    child: new TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 2,
                        controller: bln,
                        decoration: InputDecoration(
                            labelText: '/Bulan',
                            errorText: _validate2 ? 'Not Empty' : null,
                            contentPadding: EdgeInsets.all(10)
                        )
                    ),
                  ),
                  SizedBox(width: 20.0,),
                  new Flexible(
                    child: new TextField(
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        controller: thn,
                        decoration: InputDecoration(
                            labelText: '/Tahun',
                            errorText: _validate3 ? 'Not Empty' : null,
                            contentPadding: EdgeInsets.all(10)
                        )
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: new Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: RaisedButton(onPressed: () => _hitungUmur(),child: Text("Hitung"),color: Colors.blue,textColor: Colors.white,)),
                ],
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// Alert with single button.
/*_onAlertButtonPressed(context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {Navigator.of(context).pop(); },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Hasil"),
    content: Text(_MyHomePageState),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}*/