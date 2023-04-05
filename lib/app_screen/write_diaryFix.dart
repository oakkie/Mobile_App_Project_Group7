import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class SecondScreen extends StatelessWidget {
  final controller;
  final controller1;
  final controller2 = TextEditingController();
  final controller3;

  VoidCallback onSave;
  VoidCallback onBack;

  SecondScreen({
    Key? key,
    required this.controller,
    required this.onSave,
    required this.onBack,
    required this.controller1,
    required this.controller3,
    required TextEditingController controller2,
  }) : super(key: key) {
    controller2.text = DateFormat.yMd().format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(243, 222, 186, 1),
        centerTitle: true,
        title: Text(
          DateFormat.yMd().format(DateTime.now()),
          style: const TextStyle(
            color: Color.fromRGBO(71, 60, 51, 1),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color.fromRGBO(71, 60, 51, 1),
        ),
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: SizedBox(
          child: Container(
            height: 900,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Topic..",
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: controller1,
                          keyboardType: TextInputType.multiline,
                          maxLines: 30,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Write your diary here..",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 11),
                        child: Text(
                          "Choose your mood",
                          style: TextStyle(
                            color: Color.fromRGBO(71, 60, 51, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 31,
                        child: TextFormField(
                          controller: controller3,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: MoodSelector(
                                controller3: controller3,
                              )),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // save button
                            Container(
                              //Button
                              width: 100,
                              height: 50,
                              child: Expanded(
                                child: MaterialButton(
                                  onPressed: () {
                                    if (controller.text.isEmpty) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text('Required Topic'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                    } else {
                                      onSave();
                                    }
                                  },
                                  color: Color.fromRGBO(71, 60, 51, 1),
                                  child: Text(
                                    "SAVE",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            // cancel button
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MoodSelector extends StatefulWidget {
  final controller3;
  const MoodSelector({Key? key, required this.controller3}) : super(key: key);

  @override
  _MoodSelectorState createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  String? _selectedMood;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: _selectedMood == null
          ? const Icon(Icons.emoji_emotions_outlined)
          : Text(
              _selectedMood!,
              style: const TextStyle(fontSize: 20),
            ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return EmojiSelector(
              onEmojiSelected: (emoji) {
                setState(() {
                  _selectedMood = emoji;
                });
                widget.controller3.text += emoji;
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }
}

class EmojiSelector extends StatelessWidget {
  final Function(String) onEmojiSelected;

  const EmojiSelector({Key? key, required this.onEmojiSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Select mood'),
      content: SingleChildScrollView(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildEmojiButton('😄', context),
            _buildEmojiButton('😢', context),
            _buildEmojiButton('😭', context),
            _buildEmojiButton('😍', context),
            _buildEmojiButton('😡', context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmojiButton(String emoji, BuildContext context) {
    return TextButton(
      onPressed: () => onEmojiSelected(emoji),
      child: Text(
        emoji,
        style: TextStyle(fontSize: 28),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        padding: EdgeInsets.zero,
        minimumSize: Size(48, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 2,
        ),
      ),
    );
  }
}

/////////////////////////////////////graph
