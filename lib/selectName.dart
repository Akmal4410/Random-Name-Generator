import 'dart:developer' as hi;
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:math';

class SelectName extends StatefulWidget {
  SelectName({super.key});

  @override
  State<SelectName> createState() => _SelectNameState();
}

class _SelectNameState extends State<SelectName> {
  List<String>? nameList;
  ValueNotifier<List<String>>? nameListNotifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameListNotifier =
        ValueNotifier(Hive.box<String>('NameBox').values.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1b1b1b),
        title: const Text('Random Name Selector'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: nameListNotifier!,
              builder: (BuildContext context, value, Widget? _) {
                return (value.isEmpty)
                    ? const Center(
                        child: Text(
                        'The List is empty',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ))
                    : ListView.separated(
                        padding: EdgeInsets.all(10),
                        itemBuilder: (context, index) {
                          return Text(
                            value[index],
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 8),
                        itemCount: value.length,
                      );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xfff0c432)),
            onPressed: () {
              chooseRandomName(
                context: context,
                num: nameListNotifier!.value.length,
                nameListNotifier: nameListNotifier!,
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Choose',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  showRandomNameAlert({
    required BuildContext context,
    required ValueNotifier<List> nameListNotifier,
    required int index,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text('The Random Name'),
          content: Text(
            nameListNotifier.value[index],
            style: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                nameListNotifier.value.removeAt(index);
                nameListNotifier.notifyListeners();
                Navigator.pop(ctx);
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  chooseRandomName(
      {required BuildContext context,
      required int num,
      required ValueNotifier<List> nameListNotifier}) {
    Random random = new Random();
    int randomNumber = random.nextInt(num);
    showRandomNameAlert(
      context: context,
      index: randomNumber,
      nameListNotifier: nameListNotifier,
    );
    hi.log(randomNumber.toString());
  }
}
