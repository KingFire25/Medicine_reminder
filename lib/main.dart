import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';




void main() =>
  runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
      ),
      home: HomeP(),
    );
  }
}

class HomeP extends StatefulWidget {
const HomeP({ Key? key }) : super(key: key);

  @override
  State<HomeP> createState() => _HomePState();
}

class _HomePState extends State<HomeP> {
List<int> top = <int>[];
List<int> bottom = <int>[0];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Column(  
        children: <Widget>[  
          
          TableCalendar(
          focusedDay: DateTime.now(), 
          firstDay: DateTime.utc(2010, 10, 16), 
          lastDay: DateTime.utc(2030, 3, 14),
          calendarFormat: CalendarFormat.week,),
                 
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.green[900],
            ),
            child:
            Text('Upcoming Reminders:',style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),),
          ),
              
          Container(
          margin: EdgeInsets.all(40),
          height: 250,
          width:300,
          color: Colors.grey[300],
          padding: EdgeInsets.all(10),
          child: Column(
          children: [
          SizedBox(
          height: 230.0,
          child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
          
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
          Text("hi"),
        ],
      ),
    ),
  ],
)
        ),
        
             
        ], 
         
      ),
       bottomNavigationBar: Padding(
        padding: EdgeInsets.all(40.0),
        child: 
         Container(       
            height: 50,
            width: 200,
            child: FloatingActionButton.extended(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          }, 
            label: const Text('Add Schedule'),
            icon: const Icon(Icons.add_circle),
            backgroundColor: Colors.pink,),
            ),
          ),    
    );
  }
}

class SecondRoute extends StatefulWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  State<SecondRoute> createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  String radioItem = '';
  int value = 0;
  Widget CustomRadioButton(String text, int index) {
    return OutlineButton(
      onPressed: () {
        setState(() {
          value = index;
        });
      },
      
      child: Text(
        text,
        style: TextStyle(
          color: (value == index) ? Colors.red : Colors.black,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide: BorderSide(color: Colors.black),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add reminder"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                const Text('Who\s this for',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),),
               
                RadioListTile(
              groupValue: radioItem,
              title: Text('ME'),
              value: 'Item 1',
              onChanged: (val) {
                setState(() {
                  radioItem = val.toString();
                });
              },
            ),
 
           RadioListTile(
              groupValue: radioItem,
              title: Text('SOMEBODY ELSE'),
              value: 'Item 2',
              onChanged: (val) {
                setState(() {
                  radioItem = val.toString();
                });
              },
            ),

              ],
            ),
          ),

          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Type',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),),
                Container(
                  height: 10,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomRadioButton("TYPE 1", 1),
                      CustomRadioButton("TYPE 2", 2),
                      CustomRadioButton("TYPE 3", 3),
                      CustomRadioButton("TYPE 4", 4),
                    ],
                  ),
                )
                
            

              ],
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Time',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),),
                Container(child: Text('add time here'),),
              ],
            ),
          ),

          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                const Text('How many times in a week ?',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),),
                Container(child: Text('Multi-Radio Butttons'),),

                
                
              ],
            ),
          ),


          Container(     
          ),
          Container(
          alignment: Alignment.center,
          child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
          )
        ],
        
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

  

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       _counter++;
     
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(
        
//         title: Text(widget.title),
//       ),
//       body: Center(
        
//         child: Column(
          
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
            
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
