import 'package:flutter/material.dart';

class Saleinputfield extends StatelessWidget{

  final TextEditingController controller;
  final void Function(String) onSubmit;

  const Saleinputfield({super.key,required this.controller, required this.onSubmit});

  @override
  Widget build(BuildContext context){
    return  // shows textfield and send button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child:Row(
              children: [
                Expanded(
                   child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: TextField(
                        // control for the field
                        controller: controller,
                        decoration: InputDecoration(
                        hintText: 'Type sale details...',
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      ),
                      onSubmitted: onSubmit, 
                      ),
                   ),
                ),
                // space between inputfield and send button
                const SizedBox(width: 8.0),
                // the send button
                GestureDetector(
                  onTap: () => onSubmit(controller.text),
                  child:Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child:const Icon(
                      Icons.send, // Send icon
                      color: Colors.white,
                    ),
                  )
                )
              ],
            ),
          );

  }
}