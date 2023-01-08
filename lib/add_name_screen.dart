import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_name/selectName.dart';

class AddNameScreen extends StatefulWidget {
  AddNameScreen({super.key});

  @override
  State<AddNameScreen> createState() => _AddNameScreenState();
}

class _AddNameScreenState extends State<AddNameScreen> {
  final nameBox = Hive.box<String>('NameBox');

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff1b1b1b),
        title: const Text('Add Names'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
            child: TextFormField(
              controller: _nameController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.grey),
                hintText: 'Enter your name',
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Color(0xfff0c432), width: 2.0),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton.icon(
              onPressed: () {
                addName();
              },
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              label: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Add Student',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xfff0c432),
                shape: const StadiumBorder(),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: nameBox.listenable(),
              builder: (BuildContext context, Box<String> box, child) {
                return ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  itemBuilder: (context, index) {
                    final List keylist = box.keys.toList();
                    final key = keylist[index];
                    final List<String> nameList = box.values.toList();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          nameList[index],
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            nameBox.delete(key);
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemCount: box.length,
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xfff0c432)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SelectName();
              }));
            },
            child: const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                'Go To Selection Screen',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  addName() {
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      return;
    }
    nameBox.add(name);
    _nameController.clear();
  }
}
