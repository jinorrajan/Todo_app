import 'package:flutter/material.dart';
import 'package:todo/src/presentation/widgets/button_widget.dart';
import 'package:todo/src/utlis/constant/colors.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final tcontoller;
  final cContoller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.tcontoller,
    required this.cContoller,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ConstColors.mainColor,
      content: Container(
        height: 250,
        child: Column(
          children: [
          const  Center(child: Text("Add a New Task",style: TextStyle(fontSize: 17),)),
           const SizedBox(height: 10,),
            TextField(
              controller: tcontoller,
              decoration:  InputDecoration(
                filled: true,
                fillColor: ConstColors.secondaryColor,
                hintText: "Enter Title",
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ),
            const SizedBox(height: 13,),
            TextField(
              controller: cContoller,
              decoration: InputDecoration(
                filled: true,
                fillColor: ConstColors.secondaryColor,
                hintText: "Enter message",
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
              ),
            ),
             const SizedBox(height: 13,),
            //Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidget(
                  text: 'Cancel',
                  onPressed: onCancel,
                ),
                ButtonWidget(
                  text: 'Save',
                  onPressed: onSave,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
