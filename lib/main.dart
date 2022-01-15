import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
      debugShowCheckedModeBanner: false,
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
  Decoration decoration = const BoxDecoration();
  DateTime selectedDay=DateTime.now();
  DateTime focusedDay=DateTime.now();
  TextEditingController _evCont = TextEditingController();
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
              firstDay: DateTime(2000),
              lastDay: DateTime(2040),
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
                isTodayHighlighted: true,
                todayDecoration: BoxDecoration(
                  color: Colors.orange[600],
                  shape: BoxShape.rectangle,
                  borderRadius: const BorderRadius.all(Radius.circular(9)),
                ),

                selectedDecoration: const BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(9)),
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
      width: 90,
      child: FlatButton(
        onPressed: () {
          setState(() {
            meditem = index;
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: (meditem == index) ? Colors.teal : Colors.black,
            fontWeight: (meditem == index) ? FontWeight.w600 :FontWeight.w400,
            fontSize: 15,
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
    String inkwell='';
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blueGrey
        ),
        toolbarOpacity: 1,

        toolbarTextStyle: TextStyle(
          color: Colors.black,
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        title: Text("Add reminder",style: TextStyle(
          color: Colors.grey[700]
        ),),
      ),
      body: SingleChildScrollView(
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
                width: 300,
                child: TextFormField(
                  controller: person,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Name',
                  ),
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Select Type',
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
                      mainAxisAlignment: MainAxisAlignment.center,
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
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Set Time',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.resolveWith((states) => 0),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),
                    ),
                    onPressed: () {
                      _selectTime(context);
                    },
                    child: Text(
                      time,
                      textScaleFactor: 2,
                      style: TextStyle(
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
                      fontFamily: 'Monteserat',
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
                              width: 35,
                              child: Column(
                                children: [
                                  Text(
                                    WEEK.keys.elementAt(i),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[800],
                                      fontSize: 15
                                    ),
                                  ),
                                  CheckboxListTile(
                                      activeColor: Colors.blueGrey,
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
                  if(selectedPerson=='') selectedPerson=person.text;
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
                backgroundColor: Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
