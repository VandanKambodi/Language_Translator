import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';


class LanguageTrans extends StatefulWidget {
  const LanguageTrans({super.key});

  @override
  State<LanguageTrans> createState() => _LanguageTransState();
}

class _LanguageTransState extends State<LanguageTrans> {

  var language = ["English", "Gujarati", "Hindi"];
  var orignalLan = "From";
  var destinationLan = "To";
  var output = "";
  TextEditingController lcontroller = TextEditingController();

  void translate(String src, String dest, String input) async{

    GoogleTranslator translator  = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if(src== "--"||dest=="--"){
        setState(() {
          output = "Fail to Translate";
      });
    }
  }

  String getLan(String language)
  {
    if(language=="English"){
      return "en";
    }
    if(language=="Hindi")
      {
        return "hi";
      }
    if(language=="Gujarati"){
      return "gu";
    }
    return "--";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,

      appBar: AppBar(
        title: Text("Language Translator", style: TextStyle(color: Colors.black),),
        backgroundColor: Color(0xffa8edea),
        elevation: 0,
        centerTitle: true,
      ),

      body:
      Container(
        decoration:BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xffa8edea),Color(0xfffed6e3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight)
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      dropdownColor: Colors.black,
                      icon: Icon(Icons.keyboard_arrow_down),
                      focusColor: Colors.white,iconEnabledColor: Colors.grey, iconDisabledColor: Colors.grey,
                      hint: Text(orignalLan, style: TextStyle(color: Colors.black),),
                      items: language.map((String dropDownString){
                        return DropdownMenuItem(child: Text(dropDownString,style: TextStyle(color: Colors.white)),value: dropDownString,);
                      }).toList(),
                      onChanged: (String? value){
                        setState(() {
                          orignalLan = value!;
                        });
                      },
                    ),
                    SizedBox(width: 40,),
                    Icon(Icons.arrow_right_alt_outlined, color: Colors.black,size: 40,),
                    SizedBox(width: 40,),
                    DropdownButton(
                      dropdownColor: Colors.black,
                      icon: Icon(Icons.keyboard_arrow_down),
                      focusColor: Colors.white,iconEnabledColor: Colors.grey, iconDisabledColor: Colors.grey,
                      hint: Text(destinationLan, style: TextStyle(color: Colors.black),),
                      items: language.map((String dropDownString){
                        return DropdownMenuItem(child: Text(dropDownString,style: TextStyle(color: Colors.white),),value: dropDownString,);
                      }).toList(),
                      onChanged: (String? value){
                        setState(() {
                          destinationLan = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 25,),
                SizedBox(
                  width: 360,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      cursorColor: Colors.black,
                      autofocus: false,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Enter Text..',
                        labelStyle: TextStyle(fontSize: 15,  color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey
                          )
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1
                          )
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.black,
                              width: 1
                          ),
                        ),
                        errorStyle: TextStyle(color: Colors.red,fontSize: 15),
                      ),
                      controller: lcontroller,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      onPressed: (){
                        translate(getLan(orignalLan), getLan(destinationLan), lcontroller.text.toString());
                      }, child: Text("Translate", style: TextStyle(color: Colors.white),)),
                ),
                SizedBox(height: 10,),
                Text("$output", style: TextStyle(color: Colors.black),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
