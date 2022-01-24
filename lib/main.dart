<<<<<<< HEAD


import 'package:flutter/material.dart'; 
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';
import 'package:reminder/database.dart';
import 'package:reminder/model/notes.dart';
import 'package:reminder/notification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/services.dart';



void main() => runApp(const MyApp());

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
      home: HomePage(),
    );
  }
}
 

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> colorCodes = <int>[200, 400];
  late List<Notes> items;
  bool isLoading = false;
  DateTime selectedDay=DateTime.now();
  DateTime focusedDay=DateTime.now();
  late String displaytime = '';
  var medicinetype =['Injection','  Drop   ',' Tablet  ',' Capsule '];

  String TimeFormat(TimeOfDay s) {
    if (s.hour > 12) {
      displaytime = (s.hour - 12).toString();
    } else {
      displaytime = s.hour.toString();
    }
    displaytime = displaytime + ':';
    if (s.minute < 10) displaytime += '0';
    displaytime += s.minute.toString() + ' ';
    if (s.hour > 11) {
      displaytime += 'PM';
    } else {
      displaytime += 'AM';
    }
    return displaytime;
  }

  @override
  void initState() {
    items = [];
    super.initState();
    NotificationApi.init();
    listenNotification();
    refreshitems();
  }

  void listenNotification() =>
  NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload)=>{};

  Future refreshitems() async {
    setState(() => isLoading = true);
    this.items = await ItemDatabase.instance.readallNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[500],
        title: Text('MEDICINE REMINDER'),
        actions: [
          IconButton(
            onPressed: () => {
              NotificationApi.showNotification(
                title: 'AAAAAAAAAAAAA',
                body: 'BBBBBBBBBB',
                payload: 'CCCCCCCCCC.abs',
              ) 
            },
            icon: Icon(Icons.favorite_sharp,color: Colors.red[400]),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            
            Container(
              
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
              decoration: BoxDecoration(
                color: Colors.cyan[200],
                borderRadius: BorderRadius.circular(15)),
              child: TableCalendar(
                focusedDay: selectedDay,
                firstDay: DateTime(2010),
                lastDay: DateTime(2030),
                headerVisible: false,
                calendarFormat: CalendarFormat.week,
                onDaySelected:(DateTime selectDay,DateTime focusDay){
                  setState(() {
                    selectedDay=selectDay;
                    focusedDay=focusDay;
                  });
                },
                calendarStyle: CalendarStyle(

                  
                  
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                  weekendDecoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(9)),
                  ),
                  defaultTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20
                  ),
                  weekendTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20
                  ),

                  todayDecoration: BoxDecoration(
                    color: Colors.blue[600],
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                  ),
                  

                  selectedDecoration: BoxDecoration(
                    color: Colors.orange[600],
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                  todayTextStyle: const TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  
                    weekdayStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    weekendStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )
                ),

                daysOfWeekHeight: 20,
                selectedDayPredicate:(DateTime date){
                  return isSameDay(selectedDay,date);
                },

              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(30, 0, 10, 10),
              
              
              child: Row(
                children: [
                  Text(
                    'Upcoming Reminders ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Icon(Icons.alarm,color: Colors.black,size: 30,
                  ),
                ],
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  height: 480,
                  width: 370,
                  
                  
                  
                  child: Column(
                    children: [
                      Container(
                        height: 475,
                        width: 350, 
                        
                                         
                        child: ListView.builder(
                          padding: const EdgeInsets.all(5),
                          itemCount: items.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = items[index];
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 3),
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber[colorCodes[index % colorCodes.length]],
                              ),
                              
                              
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                        Container(
                                          child: Icon(Icons.alarm,color: Colors.red,),
                                        ),
                                        Text('${TimeFormat(item.settime)}'),
                                      ],),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                        Text(
                                          '${item.medicinename}',style: TextStyle(fontWeight: FontWeight.w700),
                                        ),
                                        Text(medicinetype[item.medtype],style: TextStyle(color: Colors.grey[700]),),
                                      ],),
                                    ),
                                    
                                    Row(
                                      
                                      children: [
                                        
                                        Container(
                                          padding: EdgeInsets.all(13),
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                           color: Colors.grey[200],
                                           borderRadius: BorderRadius.circular(50),  
                                          ),
                                          child:
                                           
                                           Text('${item.medicineamount}',textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),
                                          
                                        ),

                                        Container(
                                          height: 40,
                                          margin: EdgeInsets.all(10),
                                          child: FloatingActionButton(
                                            heroTag: 'btn' + index.toString(),
                                            child: const Icon(
                                              Icons.close_sharp,
                                              color: Colors.red,
                                            ),
                                            backgroundColor: Colors.white,
                                            onPressed: () async {
                                              final id =
                                                  int.parse(item.id.toString());
                                              await ItemDatabase.instance.delete(id);
                                              setState(() {
                                                refreshitems();
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]),
                            );
                          },
                          
                        ),
                      ),
                    ],
                  )),
                  Container(
                    
                    alignment: Alignment.bottomCenter,
                    
              margin: EdgeInsets.all(10),
              height: 490,
              width: 400,
              child: FloatingActionButton.extended(
                heroTag: 'btn_add',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EnterDetails()),
                  );
                },
                label: const Text('Add Schedule'),
                icon: const Icon(Icons.add_circle),
                backgroundColor: Colors.pink,
              ),
            ),
              ],
               
            ),
                
            
          ],
        ),
      ),
    );
  }
}

class EnterDetails extends StatefulWidget {
  const EnterDetails({Key? key}) : super(key: key);

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  TextEditingController person = new TextEditingController();
  TextEditingController medicinename = new TextEditingController();
  TextEditingController medicineduration = new TextEditingController();
  String selectedPerson ='YOU';
  String radioItem = 'Item 1';
  int meditem = 0,ind=0;
  bool check = false;
  String time = '9:00 AM';
  bool isvisibile = false;
  final _formKey = GlobalKey<FormState>();

  Widget SelectMedType(String text, int index) {
    return Container(
      width: 80,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: (meditem == index) ? Colors.blue : Colors.grey[300],
        ), 
        
        onPressed: () {
          ind =index;
          setState(() {
            meditem = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (meditem == index) ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        
      ),
    );
  }

 

  TimeOfDay selectedTime = const TimeOfDay(hour: 09, minute: 00);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null) {
      setState(() {
        selectedTime = timeOfDay;
        if (selectedTime.hour > 12) {
          time = (selectedTime.hour - 12).toString();
        } else {
          time = selectedTime.hour.toString();
        }
        time = time + ':';
        if (selectedTime.minute < 10) time += '0';
        time += selectedTime.minute.toString() + ' ';
        if (selectedTime.hour > 11) {
          time += 'PM';
        } else {
          time += 'AM';
        }
      });
    }
  }
  
  var medicinecount =[1,1,1,1];
  var medicinetype =['injections','drops','tablets','capsules'];
  Widget viewType(int abc)
  {
        return Container(
          margin: EdgeInsets.only(top: 20),
          width: 300,
          height: 75,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('Amount of '+medicinetype[abc].toString(),
              style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    
                    height: 30,
                    width: 30,
                    child: FloatingActionButton.extended(
                      extendedPadding: EdgeInsets.only(bottom: 4),
                      heroTag: 'sub',
                      onPressed: () {
                        setState(() {
                          if(medicinecount[abc]>1) medicinecount[abc]--;
                          
                            
                        });
                      },
                      label: const Text('-',style: TextStyle(fontSize: 60,fontWeight: FontWeight.w300),),
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                  Container(
                    
                    padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
                    height: 40,
                    width: 100,
                    
                    child: Text(
                      medicinecount[abc].toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        
                        fontSize: 20,
                        fontWeight: FontWeight.w600,)
                    ),
                  ),
                  Container(
                      height: 30,
                      width: 30,
                      child:FloatingActionButton.extended(
                        heroTag: 'add',
                        onPressed: () {
                          setState(() {
                            if(medicinecount[abc]<9) medicinecount[abc]++;
                          });
                        },
                        label: const Text('+',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),
                        backgroundColor: Colors.deepOrange,
                      )
                  ),
                ],
              ),
            ],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Add reminder"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Column(
                      
                      children: [
                        Container(child: 
                        Text('Add Your',style: TextStyle(fontSize: 25),),),
                        Container(
                          
                          child: Text('Medicines!',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Text('We will remind',style: TextStyle(color: Colors.grey[600]),),
                        
                        ),
                        Container(
                          child: Text('you everytime.',style: TextStyle(color: Colors.grey[600]),),
                        
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    
                    child: Image(image: AssetImage('assets/images/1.1.jpg'),),
                  ),
                ],
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 30),
                      child: const Text(
                        'Adding reminder for',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    RadioListTile(
                      groupValue: radioItem,
                      title: Text('ME',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      value: 'Item 1',
                      onChanged: (val) {
                        setState(() {
                          radioItem = val.toString();
                          isvisibile = !isvisibile;
                          selectedPerson = 'YOU';
                        });
                      },
                    ),
                    RadioListTile(
                      groupValue: radioItem,
                      title: Text('SOMEONE ELSE',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      ),
                      value: 'Item 2',
                      onChanged: (val) {
                        setState(() {
                          radioItem = val.toString();
                          isvisibile = !isvisibile;
                          selectedPerson = '';
                        });
                      },
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: isvisibile,
                child: Container(
                  height: 80,
                  width: 350,
                  child: TextFormField(
                    validator: (value) {
                      if(radioItem == 'Item 2'&& value!.isEmpty)
                      return 'Invalid Text';
                      if(value!.length<3)
                      return 'Enter atleast 4 Characters';
                      else 
                      return null;
                    },
                    controller: person,
                    decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.blue.shade100,
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                ),
              ),
              Container(
              child: Column(
                children:<Widget> [
                  const Text(
                    'Medicine Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 350,
                    child: TextFormField(
                     validator: (value) {
                      if(value!.isEmpty)
                      return 'Enter atleast 1 character';
                      else 
                      return null;
                    }, 
                      
                    controller: medicinename,
                    decoration: const InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(),                  
                      labelText: 'Name',
                      hintText: "Enter Name",
                    ),
                ),
                  ),
                  const Text(
                    'Medicine Duration',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                Container(
                  width: 350,
                  child:
                  TextFormField(
                    validator: (value) {
                      if(value!.isEmpty)
                      return 'Enter atleast 1 digit';
                      if(int.parse(value)==0)
                      return 'Enter value greater than 0';
                      else 
                      return null;
                    }, 
                    controller: medicineduration,
                    decoration: const InputDecoration(
                      isDense: true,
                      
                      border: OutlineInputBorder(),
                      
                      labelText: 'Duration',
                      hintText: "Duration in days",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),),
                ],
              ),
            ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Type',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SelectMedType("Injection", 0),
                          SelectMedType("Drop", 1),
                          SelectMedType("Tablet", 2),
                          SelectMedType("Capsule", 3),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              Visibility(
              visible: ind>=0?true:false,
              child: viewType(ind),
            ),

              Container(
                
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Set Time',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _selectTime(context);
                      },
                      child: Text(
                        time,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Container(
                margin: EdgeInsets.all(10),
                height: 50,
                width: 200,
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    if(radioItem =='Item 1') selectedPerson='YOU';
                    else selectedPerson = person.text;
                    if (_formKey.currentState!.validate()) {
                        
  await ItemDatabase.instance
      .create(Notes(name: selectedPerson,medicinename: medicinename.text,medicineduration: medicineduration.hashCode, medtype: meditem ,medicineamount: medicinecount[meditem], settime: selectedTime));
  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const HomePage()))
      .then((_) => setState(() {}));
}
                  },
                  label: const Text('Save'),
                  icon: const Icon(Icons.save_outlined),
                  backgroundColor: Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
=======
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async';
import 'package:reminder/database.dart';
import 'package:reminder/model/notes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Decoration decoration = const BoxDecoration();
  DateTime selectedDay=DateTime.now();
  DateTime focusedDay=DateTime.now();
  List<int> colorCodes = <int>[200, 400];
  late List<Notes> items;
  bool isLoading = false;
  late String displaytime = '';

  String TimeFormat(TimeOfDay s) {
    if (s.hour > 12) {
      displaytime = (s.hour - 12).toString();
    } else {
      displaytime = s.hour.toString();
    }
    displaytime = displaytime + ':';
    if (s.minute < 10) displaytime += '0';
    displaytime += s.minute.toString() + ' ';
    if (s.hour > 11) {
      displaytime += 'PM';
    } else {
      displaytime += 'AM';
    }
    return displaytime;
  }

  @override
  void initState() {
    items = [];
    super.initState();
    refreshitems();
  }

  Future refreshitems() async {
    setState(() => isLoading = true);
    this.items = await ItemDatabase.instance.readallNotes();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 20,
        title : Text('Welcome',textAlign:TextAlign.start,
            style: TextStyle(color: Colors.grey.shade600,fontSize: 35,fontFamily: 'Monteserat')
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(2010),
              lastDay: DateTime(2030),
              headerVisible: false,
              calendarFormat: CalendarFormat.week,
              onDaySelected:(DateTime selectDay,DateTime focusDay){
                setState(() {
                  selectedDay=selectDay;
                  focusedDay=focusDay;
                });
                print(focusedDay);
              },
              calendarStyle: CalendarStyle(

                defaultDecoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                weekendDecoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                ),
                defaultTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20
                ),
                weekendTextStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20
                ),

                todayDecoration: BoxDecoration(
                  color: Colors.grey[600],
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                ),

                selectedDecoration: BoxDecoration(
                  color: Colors.orange[600],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                selectedTextStyle: const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
                todayTextStyle: const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
              daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  weekendStyle: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  )
              ),

              daysOfWeekHeight: 21,
              selectedDayPredicate:(DateTime date){
                return isSameDay(selectedDay,date);
              },

            ),
            Container(
              child:
              Text('Upcoming Reminders:',style: TextStyle(
                color: Colors.grey[800],
                fontSize: 30,
                fontFamily: 'VS',
                fontWeight: FontWeight.w600,
              ),),
            ),

            Container(
                margin: EdgeInsets.all(10),
                height: 300,
                width: 300,
                color: Colors.grey[300],
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(8),
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          final item = items[index];
                          return Container(
                            height: 50,
                            color: Colors
                                .amber[colorCodes[index % colorCodes.length]],
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                      '${item.name} ${item.medtype} ${TimeFormat(item.settime)} ${item.days}'),
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    child: FloatingActionButton(
                                      heroTag: 'btn' + index.toString(),
                                      child: const Icon(
                                        Icons.close_sharp,
                                        color: Colors.red,
                                      ),
                                      backgroundColor: Colors.white,
                                      onPressed: () async {
                                        final id =
                                            int.parse(item.id.toString());
                                        await ItemDatabase.instance.delete(id);
                                        setState(() {
                                          refreshitems();
                                        });
                                      },
                                    ),
                                  )
                                ]),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    ),
                  ],
                )),
            Container(
              margin: EdgeInsets.all(10),
              height: 50,
              width: 200,
              child: FloatingActionButton.extended(
                heroTag: 'btn_add',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EnterDetails()),
                  );
                },
                label: const Text('Add Schedule'),
                icon: const Icon(Icons.add_circle),
                backgroundColor: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnterDetails extends StatefulWidget {
  const EnterDetails({Key? key}) : super(key: key);

  @override
  State<EnterDetails> createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  TextEditingController person = new TextEditingController(),name = new TextEditingController(),dur=new TextEditingController();
  String selectedPerson ='YOU',radioItem = 'Item 1';
  int meditem = 0,ind=0;
  bool check = false;
  String time = '9:00 AM';
  bool isvisibile = false;
  Map<String, bool> WEEK = {
    'SUN': false,
    'MON': false,
    'TUE': false,
    'WED': false,
    'THU': false,
    'FRI': false,
    'SAT': false,
  };

  var holder_1 = [];

  Widget SelectMedType(String text, int index) {
    return Container(
      width: 90,
      child: FlatButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          ind =index;
          setState(() {
            meditem = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (meditem == index) ? Colors.teal.shade300 : Colors.black,
            fontWeight: (meditem == index) ? FontWeight.w600 :FontWeight.w400,
            fontSize: (index==1)?15:17,
          ),
        ),
      ),
    );
  }
  int cnt=0;
  Widget viewType(int abc)
  {
    switch (abc){
      case 1:

        break;
      case 2:
        break;
      case 3:
        return Container(
          width: 300,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Text('Amount of pills',style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Monteserat'
              )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(3),
                    height: 40,
                    width: 70,
                    child: FloatingActionButton.extended(
                      heroTag: 'sub',
                      onPressed: () {
                        setState(() {
                          if(cnt>0) cnt--;
                          else
                            cnt=0;
                        });
                      },
                      label: const Text('-',style: TextStyle(fontSize: 60,fontWeight: FontWeight.w300),),
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(4),
                    height: 40,
                    width: 100,
                    child: Text(
                      ' '+cnt.toString()+' Pills',style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Container(
                      height: 40,
                      width: 70,
                      child:FloatingActionButton.extended(
                        onPressed: () {
                          setState(() {
                            cnt++;
                          });
                        },
                        label: const Text('+',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400),),
                        backgroundColor: Colors.deepOrange,
                      )
                  ),
                ],
              ),
            ],
          ),
        );
        break;
      case 4:

    }
    return Container(
      width: 100,
      height: 300,
      child:Column(

      ),
    );
  }

  String SelectedDays(){
    String temp='';
    for(int i=0;i<WEEK.length;i++) {
      if(WEEK.values.elementAt(i)==true) {
      temp+='1';
    } else temp+='0';
    }
    return temp;
  }

  TimeOfDay selectedTime = const TimeOfDay(hour: 09, minute: 00);

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (timeOfDay != null) {
      setState(() {
        selectedTime = timeOfDay;
        if (selectedTime.hour > 12) {
          time = (selectedTime.hour - 12).toString();
        } else {
          time = selectedTime.hour.toString();
        }
        time = time + ':';
        if (selectedTime.minute < 10) time += '0';
        time += selectedTime.minute.toString() + ' ';
        if (selectedTime.hour > 11) {
          time += 'PM';
        } else {
          time += 'AM';
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            iconTheme: const IconThemeData(
                color: Colors.blueGrey
            ),
            toolbarOpacity: 1,

            toolbarTextStyle: const TextStyle(
              color: Colors.black,
            ),
            backgroundColor: Colors.grey[200],
            elevation: 0,
            title: Text("Add reminder",style: TextStyle(
                color: Colors.grey[700]
            ),),
          ),
      body:SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Who's this for ?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RadioListTile(
                    activeColor: Colors.blueGrey.shade700,
                    groupValue: radioItem,
                    title: Text('ME'),
                    value: 'Item 1',
                    onChanged: (val) {
                      setState(() {
                        radioItem = val.toString();
                        isvisibile = !isvisibile;
                        selectedPerson = 'YOU';
                      });
                    },
                  ),
                  RadioListTile(
                    activeColor: Colors.blueGrey.shade700,
                    groupValue: radioItem,
                    title: Text('SOMEONE ELSE'),
                    value: 'Item 2',
                    onChanged: (val) {
                      setState(() {
                        radioItem = val.toString();
                        isvisibile = true;
                        selectedPerson = '';
                      });
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isvisibile,
              child: Container(
                height: 60,
                width: 300,
                child: TextField(
                  controller: person,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 3),
                    ),
                    hintText: "Enter Name",
                    labelText: 'Name',
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                children:const [
                  Text(
                    'Medicine Name',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 3),
                    ),
                    isDense: true,
                    labelText: 'Name',
                    hintText: "Enter Name",
                  ),
                ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:const [
                        Text(
                          'Medicine Duration',
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextFormField(
                    controller: dur,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.blueGrey,
                            width: 3),
                      ),
                      isDense: true,
                      labelText: 'Duration',
                      hintText: "Duration in days",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Select Type',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 3,horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SelectMedType("Injection", 1),
                        SelectMedType("Drop", 2),
                        SelectMedType("Tablet", 3),
                        SelectMedType("Syrup", 4),
                      ],
                    ),
                  )
                ],
              ),
            ),

            Visibility(
              visible: ind>0?true:false,
              child: viewType(ind),
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'Set Time',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ElevatedButton(
                      style:ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith((states) => 0),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade400),
                      ),
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: Text(
                      time,
                      style: const TextStyle(
                        fontFamily: 'Monteserat',
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'How many times in a week ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < 7; i++)
                          Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(0),
                              width: 32,
                              child: Column(
                                children: [
                                  Text(
                                    WEEK.keys.elementAt(i),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                    ),
                                  ),
                                  CheckboxListTile(
                                      activeColor: Colors.red,
                                      value: WEEK.values.elementAt(i),
                                      onChanged: (value) {
                                        setState(() {
                                          WEEK[WEEK.keys.elementAt(i)] = value!;
                                        });
                                      }),
                                ],
                              )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 50,
              width: 120,
              child: FloatingActionButton.extended(
                onPressed: () async {
                  if(selectedPerson=='')selectedPerson=person.text;
                  await ItemDatabase.instance
                      .create(Notes(name: selectedPerson, medtype: meditem , settime: selectedTime, days: SelectedDays()));
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()))
                      .then((_) => setState(() {}));
                },
                label: const Text('Save'),
                icon: const Icon(Icons.save_outlined),
                backgroundColor: Colors.pink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
>>>>>>> cd34dfa4b5462ac855fdc3a8b5f5875d962bd051
