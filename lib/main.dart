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
      centerTitle: true,
      title: Text('MEDICINE REMINDER'),
      leading: IconButton(
        onPressed: () {},
        icon: Icon(Icons.home),
      ),
      actions: [
        
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings),
        ),
      ],
      ),
      body: Column(  
        children: <Widget>[  
          
          TableCalendar(
          focusedDay: DateTime.now(), 
          firstDay: DateTime.utc(2010, 10, 16), 
          lastDay: DateTime.utc(2030, 3, 14),
          calendarFormat: CalendarFormat.week,),
                 
          Container(
            margin: EdgeInsets.all(20),
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
          margin: EdgeInsets.all(10),
          height: 300,
          width:300,
          color: Colors.grey[300],
          padding: EdgeInsets.all(10),
          child: Column(
          children: [
          SizedBox(
          height: 280.0,
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

        Container(    
            margin: EdgeInsets.all(10),   
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
        ],        
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
  String radioItem = 'Item 1';
  int value = 0;
  bool check = false;

Map<String, bool> List = {
    'SUN' : false,
    'MON' : false,
    'TUE' : false,
    'WED' : false,
    'THU' : false,
    'FRI' : false,
    'SAT' : false,
  };

  var holder_1 = [];  

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
  
  String getkeys(int a){
    return List.keys.elementAt(a);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add reminder"),
      ),
      body:SingleChildScrollView(
      child:
       Column(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                const Text('Who\'s this for ?',style: TextStyle(
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
                      CustomRadioButton("Injection", 1),
                      CustomRadioButton("Drops", 2),
                      CustomRadioButton("Tablet", 3),
                      CustomRadioButton("Capsules", 4),
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
            margin: EdgeInsets.all(10),
            
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const Text('How many times in a week ?',style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),),
              Container(
                
                margin: EdgeInsets.all(20),
                
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                
             for(int i=0;i<7;i++)     
             Container(
               margin: EdgeInsets.all(5),
               padding: EdgeInsets.all(0),
               
                  width: 32,
                  child:
                  Column(
                    children: [                  
                      Text(List.keys.elementAt(i),style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),),
                      CheckboxListTile(
                      activeColor: Colors.red,
                      value: List.values.elementAt(i), onChanged: (value){
                      setState(() {
                        List[List.keys.elementAt(i)] = value!;
                      });
                     }),
                    ],
                  ) 
                  ),
               
             
              ],),
            ),

        
                
              ],
            ),
          ),


          Container(
           margin: EdgeInsets.all(10),   
            height: 50,
            width: 200,
            child: FloatingActionButton.extended(onPressed: () {
            Navigator.pop(context);
          }, 
            label: const Text('Save'),
            icon: const Icon(Icons.save_outlined),
            backgroundColor: Colors.pink,),
            ),
          
        ],
        
      ),),
    );
  }
}
