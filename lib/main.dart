import 'package:flutter/material.dart';
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
        centerTitle: true,
        title: Text('MEDICINE REMINDER'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              calendarFormat: CalendarFormat.week,
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.green[900],
              ),
              child: Text(
                'Upcoming Reminders:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.all(10),
                height: 300,
                width: 300,
                color: Colors.grey[300],
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    SizedBox(
                      height: 280,
                      width: 280,
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
  TextEditingController person = new TextEditingController();
  String selectedPerson ='YOU';
  String radioItem = 'Item 1';
  int meditem = 0;
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

  //var holder_1 = [];

  Widget SelectMedType(String text, int index) {
    return Container(
      width: 80,
      child: OutlineButton(
        onPressed: () {
          setState(() {
            meditem = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (meditem == index) ? Colors.red : Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        borderSide: const BorderSide(color: Colors.black),
      ),
    );
  }

  String SelectedDays(){
    String temp='';
    for(int i=0;i<WEEK.length;i++)
    if(WEEK.values.elementAt(i)==true)temp+='1';
    else temp+='0';
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
      appBar: AppBar(
        title: const Text("Add reminder"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    'Who\'s this for ?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RadioListTile(
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
                    groupValue: radioItem,
                    title: Text('SOMEONE ELSE'),
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
                height: 60,
                width: 350,
                child: TextField(
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
                        SelectMedType("Injection", 1),
                        SelectMedType("Drop", 2),
                        SelectMedType("Tablet", 3),
                        SelectMedType("Capsule", 4),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
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
              width: 200,
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
