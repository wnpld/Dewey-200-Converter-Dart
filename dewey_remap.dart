/*
To compile this Dart script to Javascript here are the quick instructions:

1. Rename this file to "dewey.dart".
2. Install the Dart SDK on your system of choice (https://dart.dev/get-dart)
3. In the directory you are compiling this in create a pubspec.yaml file
  with the following contents:
-----
name: dewey_converter
description: Converts an old Dewey 200s number to a new one
version: 1.0.0

environment:
    sdk: ^3.4.3
    
dependencies:
    http: ^1.2.1
-----
4. Run "dart pub get" to download the dependencies
5. Run "dart compile js -o dewey.js dewey.dart"

The HTML page which uses it must load the script as a deferred script (it
runs after the page loads). It will need an input element with an id of
"callno", a button with the id of "convert" and a span with an id of "result".
For best results, use the Bootstrap framework and the the result span should have 
a class of "alert".
*/

import 'dart:html';

void main() {
  document
      .querySelector('#convert')
      ?.onClick
      .listen((MouseEvent e) => convertNumber());
}

void convertNumber() {
  InputElement callblank = document.querySelector('#callno') as InputElement;
  Element? result = document.querySelector('#result');
  String? formcallno = callblank.value;
  /* This creates a map variable where all of the regular expression rules
  	 are the ids and the outputs are the values.  If a number is carried over from the
  	 old scheme to the new, that goes where the "x" is in the value. */
  final rules = {
    RegExp(r'(.*\b)220(\b.*)'): "240",
    RegExp(r'(.*\b)220\.(\d+)(\b.*)'): "240.x",
    RegExp(r'(.*\b)221(\b.*)'): "241",
    RegExp(r'(.*\b)221\.(\d+)(\b.*)'): "241.x",
    RegExp(r'(.*\b)222(\b.*)'): "242",
    RegExp(r'(.*\b)222\.(\d+)(\b.*)'): "242.x",
    RegExp(r'(.*\b)223(\b.*)'): "243",
    RegExp(r'(.*\b)223\.(\d+)(\b.*)'): "243.x",
    RegExp(r'(.*\b)224(\b.*)'): "244",
    RegExp(r'(.*\b)224\.(\d+)(\b.*)'): "244.x",
    RegExp(r'(.*\b)225(\b.*)'): "245",
    RegExp(r'(.*\b)225\.(\d+)(\b.*)'): "245.x",
    RegExp(r'(.*\b)226(\b.*)'): "246",
    RegExp(r'(.*\b)226\.(\d+)(\b.*)'): "246.x",
    RegExp(r'(.*\b)227(\b.*)'): "247",
    RegExp(r'(.*\b)227\.(\d+)(\b.*)'): "247.x",
    RegExp(r'(.*\b)228(\b.*)'): "248",
    RegExp(r'(.*\b)228\.(\d+)(\b.*)'): "248.x",
    RegExp(r'(.*\b)229(\b.*)'): "249",
    RegExp(r'(.*\b)229\.(\d+)(\b.*)'): "249.x",
    RegExp(r'(.*\b)230(\b.*)'): "252",
    RegExp(r'(.*\b)230\.(\d+)(\b.*)'): "252.x",
    RegExp(r'(.*\b)231(\b.*)'): "253",
    RegExp(r'(.*\b)231\.(\d+)(\b.*)'): "253.x",
    RegExp(r'(.*\b)232(\b.*)'): "254",
    RegExp(r'(.*\b)232\.(\d+)(\b.*)'): "254.x",
    RegExp(r'(.*\b)233(\b.*)'): "255",
    RegExp(r'(.*\b)233\.(\d+)(\b.*)'): "255.x",
    RegExp(r'(.*\b)234(\b.*)'): "256",
    RegExp(r'(.*\b)234\.(\d+)(\b.*)'): "256.x",
    RegExp(r'(.*\b)235(\b.*)'): "257",
    RegExp(r'(.*\b)235\.(\d+)(\b.*)'): "257.x",
    RegExp(r'(.*\b)236(\b.*)'): "258",
    RegExp(r'(.*\b)236\.(\d+)(\b.*)'): "258.x",
    RegExp(r'(.*\b)238(\b.*)'): "259.2",
    RegExp(r'(.*\b)238\.(\d+)(\b.*)'): "259.2x",
    RegExp(r'(.*\b)239(\b.*)'): "259.6",
    RegExp(r'(.*\b)239\.(\d+)(\b.*)'): "259.6x",
    RegExp(r'(.*\b)241(\b.*)'): "261",
    RegExp(r'(.*\b)241\.(\d+)(\b.*)'): "261.x",
    RegExp(r'(.*\b)242(\b.*)'): "262",
    RegExp(r'(.*\b)242\.(\d+)(\b.*)'): "262.x",
    RegExp(r'(.*\b)243(\b.*)'): "263.2",
    RegExp(r'(.*\b)243\.(\d+)(\b.*)'): "263.2x",
    RegExp(r'(.*\b)246(\b.*)'): "263.5",
    RegExp(r'(.*\b)246\.(\d+)(\b.*)'): "263.5x",
    RegExp(r'(.*\b)247(\b.*)'): "263.8",
    RegExp(r'(.*\b)247\.(\d+)(\b.*)'): "263.8x",
    RegExp(r'(.*\b)248(\b.*)'): "264.2",
    RegExp(r'(.*\b)248\.(\d+)(\b.*)'): "264.2x",
    RegExp(r'(.*\b)249(\b.*)'): "264.6",
    RegExp(r'(.*\b)249\.(\d+)(\b.*)'): "264.6x",
    RegExp(r'(.*\b)250(\b.*)'): "265.0",
    RegExp(r'(.*\b)250\.(\d+)(\b.*)'): "265.0x",
    RegExp(r'(.*\b)251(\b.*)'): "266",
    RegExp(r'(.*\b)251\.(\d+)(\b.*)'): "266.x",
    RegExp(r'(.*\b)252(\b.*)'): "267",
    RegExp(r'(.*\b)252\.(\d+)(\b.*)'): "267.x",
    RegExp(r'(.*\b)253(\b.*)'): "268.2",
    RegExp(r'(.*\b)253\.(\d+)(\b.*)'): "268.2x",
    RegExp(r'(.*\b)254(\b.*)'): "268.6",
    RegExp(r'(.*\b)254\.(\d+)(\b.*)'): "268.6x",
    RegExp(r'(.*\b)255(\b.*)'): "269.2",
    RegExp(r'(.*\b)255\.(\d+)(\b.*)'): "269.2x",
    RegExp(r'(.*\b)259(\b.*)'): "269.6",
    RegExp(r'(.*\b)259\.(\d+)(\b.*)'): "269.6x",
    RegExp(r'(.*\b)260(\b.*)'): "270",
    RegExp(r'(.*\b)261(\b.*)'): "271",
    RegExp(r'(.*\b)261\.(\d+)(\b.*)'): "271.x",
    RegExp(r'(.*\b)262(\b.*)'): "272",
    RegExp(r'(.*\b)262\.(\d+)(\b.*)'): "272.x",
    RegExp(r'(.*\b)263(\b.*)'): "273.2",
    RegExp(r'(.*\b)263\.(\d+)(\b.*)'): "273.2x",
    RegExp(r'(.*\b)264(\b.*)'): "273.6",
    RegExp(r'(.*\b)264\.(\d+)(\b.*)'): "273.6x",
    RegExp(r'(.*\b)265(\b.*)'): "274",
    RegExp(r'(.*\b)265\.(\d+)(\b.*)'): "274.x",
    RegExp(r'(.*\b)266(\b.*)'): "275",
    RegExp(r'(.*\b)266\.(\d+)(\b.*)'): "275.x",
    RegExp(r'(.*\b)267(\b.*)'): "276.2",
    RegExp(r'(.*\b)267\.(\d+)(\b.*)'): "276.2x",
    RegExp(r'(.*\b)268(\b.*)'): "276.5",
    RegExp(r'(.*\b)268\.(\d+)(\b.*)'): "276.5x",
    RegExp(r'(.*\b)269(\b.*)'): "276.8",
    RegExp(r'(.*\b)269\.(\d+)(\b.*)'): "276.8x",
    RegExp(r'(.*\b)270(\b.*)'): "277.2",
    RegExp(r'(.*\b)270\.(\d+)(\b.*)'): "277.2x",
    RegExp(r'(.*\b)271(\b.*)'): "277.4",
    RegExp(r'(.*\b)271\.(\d+)(\b.*)'): "277.4x",
    RegExp(r'(.*\b)272(\b.*)'): "277.6",
    RegExp(r'(.*\b)272\.(\d+)(\b.*)'): "277.6x",
    RegExp(r'(.*\b)273(\b.*)'): "277.8",
    RegExp(r'(.*\b)273\.(\d+)(\b.*)'): "277.8x",
    RegExp(r'(.*\b)274(\b.*)'): "278.4",
    RegExp(r'(.*\b)274\.(\d+)(\b.*)'): "278.4x",
    RegExp(r'(.*\b)275(\b.*)'): "278.5",
    RegExp(r'(.*\b)275\.(\d+)(\b.*)'): "278.5x",
    RegExp(r'(.*\b)276(\b.*)'): "278.6",
    RegExp(r'(.*\b)276\.(\d+)(\b.*)'): "278.6x",
    RegExp(r'(.*\b)277(\b.*)'): "278.7",
    RegExp(r'(.*\b)277\.(\d+)(\b.*)'): "278.7x",
    RegExp(r'(.*\b)278(\b.*)'): "278.8",
    RegExp(r'(.*\b)278\.(\d+)(\b.*)'): "278.8x",
    RegExp(r'(.*\b)279(\b.*)'): "278.9",
    RegExp(r'(.*\b)279\.(\d+)(\b.*)'): "278.9x",
    RegExp(r'(.*\b)280(\b.*)'): "279",
    RegExp(r'(.*\b)280\.(\d+)(\b.*)'): "279.0x",
    RegExp(r'(.*\b)281(\b.*)'): "279.1",
    RegExp(r'(.*\b)281\.(\d+)(\b.*)'): "279.1x",
    RegExp(r'(.*\b)282(\b.*)'): "279.2",
    RegExp(r'(.*\b)282\.(\d+)(\b.*)'): "279.2x",
    RegExp(r'(.*\b)283(\b.*)'): "279.3",
    RegExp(r'(.*\b)283\.(\d+)(\b.*)'): "279.3x",
    RegExp(r'(.*\b)284(\b.*)'): "279.4",
    RegExp(r'(.*\b)284\.(\d+)(\b.*)'): "279.4x",
    RegExp(r'(.*\b)285(\b.*)'): "279.5",
    RegExp(r'(.*\b)285\.(\d+)(\b.*)'): "279.5x",
    RegExp(r'(.*\b)286(\b.*)'): "279.6",
    RegExp(r'(.*\b)286\.(\d+)(\b.*)'): "279.6x",
    RegExp(r'(.*\b)287(\b.*)'): "279.7",
    RegExp(r'(.*\b)287\.(\d+)(\b.*)'): "279.7x",
    RegExp(r'(.*\b)289(\b.*)'): "279.9",
    RegExp(r'(.*\b)289\.(\d+)(\b.*)'): "279.9x",
    RegExp(r'(.*\b)291(\b.*)'): "201.3",
    RegExp(r'(.*\b)291.13(\b.*)'): "201.3",
    RegExp(r'(.*\b)291\.211(\b.*)'): "202.11",
    RegExp(r'(.*\b)291\.4(\b.*)'): "204",
    RegExp(r'(.*\b)291\.44(\b.*)'): "204.4",
    RegExp(r'(.*\b)292(\b.*)'): "232",
    RegExp(r'(.*\b)292\.(\d+)(\b.*)'): "232.x",
    RegExp(r'(.*\b)293(\b.*)'): "233",
    RegExp(r'(.*\b)293\.(\d+)(\b.*)'): "233.x",
    RegExp(r'(.*\b)294(\b.*)'): "223",
    RegExp(r'(.*\b)294\.3(\b.*)'): "227",
    RegExp(r'(.*\b)294\.33(\b.*)'): "227.1",
    RegExp(r'(.*\b)294\.33(\d+)(\b.*)'): "227.1x",
    RegExp(r'(.*\b)294\.34204(\b.*)'): "227.3",
    RegExp(r'(.*\b)294\.34204(\d+)(\b.*)'): "227.3x",
    RegExp(r'(.*\b)294\.34(\b.*)'): "227.5",
    RegExp(r'(.*\b)294\.342(\b.*)'): "227.5",
    RegExp(r'(.*\b)294\.3421(\b.*)'): "227.51",
    RegExp(r'(.*\b)294\.3422(\b.*)'): "227.52",
    RegExp(r'(.*\b)294\.3423(\b.*)'): "227.53",
    RegExp(r'(.*\b)294\.343(\b.*)'): "227.7",
    RegExp(r'(.*\b)294\.343(\d+)(\b.*)'): "227.7x",
    RegExp(r'(.*\b)294\.344(\b.*)'): "227.9",
    RegExp(r'(.*\b)294\.344(\d+)(\b.*)'): "227.9x",
    RegExp(r'(.*\b)294\.35(\b.*)'): "228.1",
    RegExp(r'(.*\b)294\.35(\d+)(\b.*)'): "228.1x",
    RegExp(r'(.*\b)294\.36(\b.*)'): "228.3",
    RegExp(r'(.*\b)294\.36(\d+)(\b.*)'): "228.3x",
    RegExp(r'(.*\b)294\.37(\b.*)'): "228.5",
    RegExp(r'(.*\b)294\.37(\d+)(\b.*)'): "228.5x",
    RegExp(r'(.*\b)294\.38(\b.*)'): "228.7",
    RegExp(r'(.*\b)294\.38(\d+)(\b.*)'): "228.7x",
    RegExp(r'(.*\b)294\.39(\b.*)'): "228.9",
    RegExp(r'(.*\b)294\.39(\d+)(\b.*)'): "228.9x",
    RegExp(r'(.*\b)294\.4(\b.*)'): "226",
    RegExp(r'(.*\b)294\.4(\d+)(\b.*)'): "226.x",
    RegExp(r'(.*\b)294\.5(\b.*)'): "223.1",
    RegExp(r'(.*\b)294\.51(\b.*)'): "223.2",
    RegExp(r'(.*\b)294\.51(\d+)(\b.*)'): "223.2x",
    RegExp(r'(.*\b)294\.52(\b.*)'): "223.5",
    RegExp(r'(.*\b)294\.52(\d+)(\b.*)'): "223.5x",
    RegExp(r'(.*\b)294\.53(\b.*)'): "223.8",
    RegExp(r'(.*\b)294\.53(\d+)(\b.*)'): "223.8x",
    RegExp(r'(.*\b)294\.54(\b.*)'): "224.2",
    RegExp(r'(.*\b)294\.54(\d+)(\b.*)'): "224.2x",
    RegExp(r'(.*\b)294\.55(\b.*)'): "224.6",
    RegExp(r'(.*\b)294\.55(\d+)(\b.*)'): "224.6x",
    RegExp(r'(.*\b)294\.56(\b.*)'): "225.2",
    RegExp(r'(.*\b)294\.56(\d+)(\b.*)'): "225.2x",
    RegExp(r'(.*\b)294\.57(\b.*)'): "225.5",
    RegExp(r'(.*\b)294\.57(\d+)(\b.*)'): "225.5x",
    RegExp(r'(.*\b)294\.59(\b.*)'): "225.8",
    RegExp(r'(.*\b)294\.59(\d+)(\b.*)'): "225.8x",
    RegExp(r'(.*\b)294\.6(\b.*)'): "229",
    RegExp(r'(.*\b)294\.6(\d+)(\b.*)'): "229.x",
    RegExp(r'(.*\b)295(\b.*)'): "235",
    RegExp(r'(.*\b)295(\b.*)'): "235.x",
    RegExp(r'(.*\b)296(\b.*)'): "251",
    RegExp(r'(.*\b)296\.(\d+)(\b.*)'): "251.x",
    RegExp(r'(.*\b)297(\b.*)'): "280",
    RegExp(r'(.*\b)297\.0(\d+)(\b.*)'): "280.0x",
    RegExp(r'(.*\b)297\.12(\b.*)'): "282",
    RegExp(r'(.*\b)297\.12(\d+)(\b.*)'): "282.x",
    RegExp(r'(.*\b)297\.14(\b.*)'): "284",
    RegExp(r'(.*\b)297\.14(\d+)(\b.*)'): "284.x",
    RegExp(r'(.*\b)297\.18(\b.*)'): "288",
    RegExp(r'(.*\b)297\.18(\d+)(\b.*)'): "288.x",
    RegExp(r'(.*\b)297\.2(\b.*)'): "292",
    RegExp(r'(.*\b)297\.2(\d+)(\b.*)'): "292.x",
    RegExp(r'(.*\b)297\.3(\b.*)'): "293",
    RegExp(r'(.*\b)297\.3(\d+)(\b.*)'): "293.x",
    RegExp(r'(.*\b)297\.4(\b.*)'): "294",
    RegExp(r'(.*\b)297\.4(\d+)(\b.*)'): "294.x",
    RegExp(r'(.*\b)297\.5(\b.*)'): "295",
    RegExp(r'(.*\b)297\.5(\d+)(\b.*)'): "295.x",
    RegExp(r'(.*\b)297\.6(\b.*)'): "296",
    RegExp(r'(.*\b)297\.6(\d+)(\b.*)'): "296.x",
    RegExp(r'(.*\b)297\.7(\b.*)'): "297",
    RegExp(r'(.*\b)297\.7(\d+)(\b.*)'): "297.x",
    RegExp(r'(.*\b)297\.8(\b.*)'): "298",
    RegExp(r'(.*\b)297\.8(\d+)(\b.*)'): "298.x",
    RegExp(r'(.*\b)297\.9(\b.*)'): "299.1",
    RegExp(r'(.*\b)297\.9(\d+)(\b.*)'): "299.1x",
    RegExp(r'(.*\b)299\.16(\b.*)'): "231",
    RegExp(r'(.*\b)299\.16(\d+)(\b.*)'): "231.x",
    RegExp(r'(.*\b)299\.17(\b.*)'): "236.7",
    RegExp(r'(.*\b)299\.17(\d+)(\b.*)'): "236.7x",
    RegExp(r'(.*\b)299\.18(\b.*)'): "236.8",
    RegExp(r'(.*\b)299\.18(\d+)(\b.*)'): "236.8x",
    RegExp(r'(.*\b)299\.19(\b.*)'): "236.9",
    RegExp(r'(.*\b)299\.19(\d+)(\b.*)'): "236.9x",
    RegExp(r'(.*\b)299\.2(\b.*)'): "237",
    RegExp(r'(.*\b)299\.2(\d+)(\b.*)'): "237.x",
    RegExp(r'(.*\b)299\.31(\b.*)'): "238",
    RegExp(r'(.*\b)299\.31(\d+)(\b.*)'): "238.x",
    RegExp(r'(.*\b)299\.51(\b.*)'): "221",
    RegExp(r'(.*\b)299\.511(\b.*)'): "221.1",
    RegExp(r'(.*\b)299\.511(\d+)(\b.*)'): "221.1x",
    RegExp(r'(.*\b)299\.512(\b.*)'): "221.6",
    RegExp(r'(.*\b)299\.512(\d+)(\b.*)'): "221.6x",
    RegExp(r'(.*\b)299\.514(\b.*)'): "221.2",
    RegExp(r'(.*\b)299\.514(\d+)(\b.*)'): "221.2x",
    RegExp(r'(.*\b)299\.54(\b.*)'): "222.2",
    RegExp(r'(.*\b)299\.56(\b.*)'): "222.4",
    RegExp(r'(.*\b)299\.561(\b.*)'): "222.5",
    RegExp(r'(.*\b)299\.561(\d+)(\b.*)'): "222.5x",
    RegExp(r'(.*\b)299\.57(\b.*)'): "222.7",
    RegExp(r'(.*\b)299\.58(\b.*)'): "222.8",
    RegExp(r'(.*\b)299\.59(\b.*)'): "222.9",
    RegExp(r'(.*\b)299\.6(\b.*)'): "239.6",
    RegExp(r'(.*\b)299\.6(\d+)(\b.*)'): "239.6x",
    RegExp(r'(.*\b)299\.7(\b.*)'): "239.7",
    RegExp(r'(.*\b)299\.7(\d+)(\b.*)'): "239.7x",
    RegExp(r'(.*\b)299\.8(\b.*)'): "239.8",
    RegExp(r'(.*\b)299\.8(\d+)(\b.*)'): "239.8x",
    RegExp(r'(.*\b)299\.9215(\b.*)'): "239.915",
    RegExp(r'(.*\b)299\.9215(\d+)(\b.*)'): "239.915x",
    RegExp(r'(.*\b)299\.922(\b.*)'): "239.92",
    RegExp(r'(.*\b)299\.922(\d+)(\b.*)'): "239.92x",
    RegExp(r'(.*\b)299\.923(\b.*)'): "239.93",
    RegExp(r'(.*\b)299\.923(\d+)(\b.*)'): "239.93x",
    RegExp(r'(.*\b)299\.924(\b.*)'): "239.94",
    RegExp(r'(.*\b)299\.924(\d+)(\b.*)'): "239.94x",
    RegExp(r'(.*\b)299\.925(\b.*)'): "239.95",
    RegExp(r'(.*\b)299\.925(\d+)(\b.*)'): "239.95x",
    RegExp(r'(.*\b)299\.9292(\b.*)'): "239.22",
    RegExp(r'(.*\b)299\.9292(\d+)(\b.*)'): "239.22x",
    RegExp(r'(.*\b)299\.9293(\b.*)'): "239.23",
    RegExp(r'(.*\b)299\.9293(\d+)(\b.*)'): "239.23x",
    RegExp(r'(.*\b)299\.9294(\b.*)'): "239.24",
    RegExp(r'(.*\b)299\.9294(\d+)(\b.*)'): "239.24x",
    RegExp(r'(.*\b)299\.9295(\b.*)'): "239.25",
    RegExp(r'(.*\b)299\.9295(\d+)(\b.*)'): "239.25x",
    RegExp(r'(.*\b)299\.9296(\b.*)'): "239.26",
    RegExp(r'(.*\b)299\.9296(\d+)(\b.*)'): "239.26x",
    RegExp(r'(.*\b)299\.93(\b.*)'): "299.2",
    RegExp(r'(.*\b)299\.932(\b.*)'): "239.4",
    RegExp(r'(.*\b)299\.933(\b.*)'): "299.3",
    RegExp(r'(.*\b)299\.934(\b.*)'): "299.4",
    RegExp(r'(.*\b)299\.935(\b.*)'): "299.5",
    RegExp(r'(.*\b)299\.936(\b.*)'): "299.6",
    RegExp(r'(.*\b)299\.94(\b.*)'): "299.9",
    RegExp(r'(.*\b)299\.94(\d+)(\b.*)'): "299.9x"
  };

  bool found = false;
  if ((formcallno != null) && (formcallno.length > 0)) {
    String callno = formcallno;
    /* Loop through all of the map rules here watching for a match */
    for (final rule in rules.entries) {
      RegExp exp = rule.key;
      String value = rule.value;
      RegExpMatch? match = exp.firstMatch(callno);
      if (match != null) {
        if (value.contains("x")) {
          String? submatch = match[2];
          if (submatch != null) {
            callno = value.replaceAll("x", submatch);
            callno = match[1]! + callno + match[3]!;
            found = true;
            break;
          }
        } else {
          if (match[0] != null) {
            callno = match[1]! + value + match[2]!;
            found = true;
            break;
          }
        }
      }
    }
    if (found) {
      result?.text = "Revised call number: " + callno;
      result?.classes.remove('alert-danger');
      result?.classes.add('alert-success');
    } else {
      result?.text = "Call number pattern not identified.";
      result?.classes.remove('alert-success');
      result?.classes.add('alert-danger');
    }
  } else {
    result?.text = "No call number entered.";
    result?.classes.remove('alert-success');
    result?.classes.add('alert-danger');
  }
}
