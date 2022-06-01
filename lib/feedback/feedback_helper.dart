
Future<String> restingFeedback(age, bpm, gender) async{
  String text = "";
  //Color color;
  if (gender == "Male"){
    //Male
    if(int.parse(age) >= 18 && int.parse(age) <= 25){
      //18-25
      if(bpm < 61){
        text = "Excellent";
      }else if (bpm >= 61 && bpm < 69){
        text = "Good";
      }else if (bpm >= 70 && bpm < 73){
        text = "Average";
      }else if (bpm >= 74 && bpm < 82){
        text = "Below Average";
      }else if (bpm >= 82){
        text = "Poor";
      }
    }else if(int.parse(age) >= 26 && int.parse(age) <= 35){
      //26-35
      if(bpm < 61){
        text = "Excellent";
      }else if (bpm >= 61 && bpm < 70){
        text = "Good";
      }else if (bpm >= 71 && bpm < 74){
        text = "Average";
      }else if (bpm >= 75 && bpm < 82){
        text = "Below Average";
      }else if (bpm >= 82){
        text = "Poor";
      }
    }else if(int.parse(age) >= 36 && int.parse(age) <= 45){
      //36-45
      if(bpm < 63){
        text = "Excellent";
      }else if (bpm >= 63 && bpm < 70){
        text = "Good";
      }else if (bpm >= 71 && bpm < 76){
        text = "Average";
      }else if (bpm >= 76 && bpm < 83){
        text = "Below Average";
      }else if (bpm >= 83){
        text = "Poor";
      }
    }else if(int.parse(age) >= 46 && int.parse(age) <= 55){
      //46-55
      if(bpm < 64){
        text = "Excellent";
      }else if (bpm >= 64 && bpm < 72){
        text = "Good";
      }else if (bpm >= 72 && bpm < 77){
        text = "Average";
      }else if (bpm >= 77 && bpm < 84){
        text = "Below Average";
      }else if (bpm >= 84){
        text = "Poor";
      }
    }else if(int.parse(age) >= 56 && int.parse(age) < 65){
      //56-64
      if(bpm <= 61){
        text = "Excellent";
      }else if (bpm >= 62 && bpm <= 71){
        text = "Good";
      }else if (bpm >= 72 && bpm <= 75){
        text = "Average";
      }else if (bpm >= 76 && bpm <= 81){
        text = "Below Average";
      }else if (bpm >= 82){
        text = "Poor";
      }
    }else if(int.parse(age) >= 65){
      //65+
      if(bpm <= 61){
        text = "Excellent";
      }else if (bpm >= 62 && bpm <= 69){
        text = "Good";
      }else if (bpm >= 70 && bpm <= 73){
        text = "Average";
      }else if (bpm >= 74 && bpm <= 79){
        text = "Below Average";
      }else if (bpm >= 80){
        text = "Poor";
      }
    }else{
      //child
      text = "Keep it up!";
    }
  }else{
    //Female
    if(int.parse(age) >= 18 && int.parse(age) <= 25){
      //18-25
      if(bpm <= 65){
        text = "Excellent";
      }else if (bpm >= 66 && bpm <= 73){
        text = "Good";
      }else if (bpm >= 74 && bpm <= 78){
        text = "Average";
      }else if (bpm >= 79 && bpm <= 84){
        text = "Below Average";
      }else if (bpm >= 85){
        text = "Poor";
      }
    }else if(int.parse(age) >= 26 && int.parse(age) <= 35){
      //26-35
      if(bpm <= 64){
        text = "Excellent";
      }else if (bpm >= 65 && bpm <= 72){
        text = "Good";
      }else if (bpm >= 73 && bpm <= 76){
        text = "Average";
      }else if (bpm >= 77 && bpm <= 82){
        text = "Below Average";
      }else if (bpm >= 83){
        text = "Poor";
      }
    }else if(int.parse(age) >= 36 && int.parse(age) <= 45){
      //36-45
      if(bpm <= 64){
        text = "Excellent";
      }else if (bpm >= 65 && bpm <= 73){
        text = "Good";
      }else if (bpm >= 74 && bpm <= 78){
        text = "Average";
      }else if (bpm >= 79 && bpm <= 84){
        text = "Below Average";
      }else if (bpm >= 85){
        text = "Poor";
      }
    }else if(int.parse(age) >= 46 && int.parse(age) <= 55){
      //46-55
      if(bpm <= 65){
        text = "Excellent";
      }else if (bpm >= 66 && bpm <= 73){
        text = "Good";
      }else if (bpm >= 74 && bpm <= 77){
        text = "Average";
      }else if (bpm >= 78 && bpm <= 83){
        text = "Below Average";
      }else if (bpm >= 84){
        text = "Poor";
      }
    }else if(int.parse(age) >= 56 && int.parse(age) < 65){
      //56-64
      if(bpm <= 64){
        text = "Excellent";
      }else if (bpm >= 65 && bpm <= 73){
        text = "Good";
      }else if (bpm >= 74 && bpm <= 77){
        text = "Average";
      }else if (bpm >= 78 && bpm <= 83){
        text = "Below Average";
      }else if (bpm >= 84){
        text = "Poor";
      }
    }else if(int.parse(age) >= 65){
      //65+
      if(bpm <= 64){
        text = "Excellent";
      }else if (bpm >= 65 && bpm <= 72){
        text = "Good";
      }else if (bpm >= 73 && bpm <= 76){
        text = "Average";
      }else if (bpm >= 77 && bpm <= 84){
        text = "Below Average";
      }else if (bpm >= 85){
        text = "Poor";
      }
    }else{
      //child
      text = "Keep it up!";
    }
  }
  return text;
}

Future<String> activeFeedback(age_s, bpm) async {
  String text = "";
  int age = int.parse(age_s);
  //int bpm = int.parse(bpm_s);
  int max_hr = 220 - age;

  if (bpm >= 0.5*max_hr && bpm <= 0.6*max_hr){
    text = "1";
  }else if (bpm > 0.6*max_hr && bpm <= 0.7*max_hr){
    text = "2";
  }else if (bpm > 0.7*max_hr && bpm <= 0.8*max_hr){
    text = "3";
  }else if (bpm > 0.8*max_hr && bpm <= 0.9*max_hr) {
    text = "4";
  }else if (bpm > 0.9*max_hr && bpm < max_hr){
    text = "5";
  }else if (bpm < 0.5*max_hr){
    text = "-1";
  }else if (bpm > max_hr){
    text = "-2";
  }
  return text;
}

