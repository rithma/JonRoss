// Brain Eraser by Tavis ported from asm version by John Ross

#define left_speaker 4
#define right_speaker 5


// the 24 bit counter
byte counterA0 = 0;
byte counterCB = 0;
byte counterED = 0;
byte parody_right = 0;
byte parody_left = 0;


void setup() {
  // put your setup code here, to run once:
  // start the serial connection
  Serial.begin(115200);
  // wait for serial monitor to open
  while(! Serial);
  delay(100);
  Serial.println("Running\n");
  
  // setup which pins are output
  pinMode (left_speaker, OUTPUT);
  pinMode (right_speaker, OUTPUT);

  // setup clock frequency shits.??
}



void loop() {
  //Serial.print("Starting Loop_");
  // the parity generators

  //while (1) {
    //Serial.print("Entering While Loop_");
    //Serial.println(String(parody_left));
    
    
    // main delay, controls overall program speed
    delayMicroseconds(150);  // will have to play with this value
    
    digitalWrite(left_speaker,bitRead(parody_left,0));
    digitalWrite(right_speaker,bitRead(parody_right,0));

    // start computing parity
    parody_right = 0;
    parody_left = 0;

    
    // increment the counters.
    counterA0++;
    //Serial.println(String(counterA0));
    if (counterA0 == 0 ) {
      counterCB++;
    }
    //Serial.println(String(counterCB));
    if (counterCB == 0 && counterA0 == 0) {
      counterED++;
    }
    //Serial.println(String(counterCB));


//    termAZ01:
//    sbrs  counterA0,Q0                ;if Qo is zero, skip incrementing parityleft
//                                  ;and continue on to the next slower bit, Q1.
//    rjmp termAZ02
//    sbrc  counterCB,CQ0               ;so, q0 was a one... is cq0 on, is it 1?
//                                  ;if cq0 is off skip any Q0 action on parityleft.
//    inc  parodyleft                   ;increment parityleft (if Q0 AND CQ0 equal 1).


     // for loop takes care of terms AZ01 - AZ12
    for (int i = 0; i < 4 ; i++) {  //
      if (bitRead(counterA0,i) == 1 && bitRead(counterCB,i+4) == 1) {
        parody_left++;  
      }
    }

    // termAZ21
    if (bitRead(counterA0,4) == 1 && bitRead(counterCB,0) == 1) {
      parody_left++;  
    }
    // termAZ22
    if (bitRead(counterA0,5) == 1 && bitRead(counterCB,1) == 1) {
      parody_left++;  
    }
    // termAZ31
    if (bitRead(counterA0,4) == 1 && bitRead(counterCB,2) == 1) {
      parody_left++;  
    }

    // termBZ01 - BZ03
    for (int i = 0; i < 4 ; i++) {  //
      if (bitRead(counterCB,i) == 1 && bitRead(counterED,i) == 1) {
        parody_left++;  
      }
    }

    // termEZ01
    if (bitRead(counterA0,0) == 1 && bitRead(counterCB,4) == 1 && bitRead(counterED,6) == 0) {
        parody_right++;  
    }

    // termEZ02
    if (bitRead(counterA0,3) == 1 && bitRead(counterCB,5) == 1 && bitRead(counterED,6) == 1) {
        parody_right++;  
    }

    // termEZ03
    if (bitRead(counterED,5) == 0 || bitRead(counterED,6) == 0) {
        // do EZ04
        if (bitRead(counterA0,3) == 1 && bitRead(counterCB,5) == 1 ) {
          parody_right++;
        }     
    }
    
    if (bitRead(counterED,5) == 1 && bitRead(counterED,6) == 1) {
        // do EZ05
        if (bitRead(counterA0,2) == 1 && bitRead(counterCB,7) == 1 && bitRead(counterED,7) == 1 && bitRead(counterED,5) == 1 && bitRead(counterED,6) == 1) {
          parody_right++;
        }
    }

    // termEZ11
    if (bitRead(counterA0,2) == 1 && bitRead(counterCB,6) == 1 ) {
        parody_right++;  
    }

    // termEZ12
    if (bitRead(counterA0,3) == 1 && bitRead(counterCB,7) == 1 ) {
        parody_right++;  
    }

    // termEZ21 // button pin is 0 ?
    if (bitRead(counterA0,4) == 1 && bitRead(counterCB,1) == 1 ) {
        parody_right++;  
    }

    // termEZ22 // button pin is 1 ?
    if (bitRead(counterA0,4) == 1 && bitRead(counterCB,0) == 1 ) {
        parody_right++;  
    }

    // termEZ23 // button pin is 0 ?
    if (bitRead(counterA0,5) == 1 && bitRead(counterCB,0) == 1 ) {
        parody_right++;  
    }

    // termEZ24 // button pin is 1 ?
    if (bitRead(counterA0,5) == 1 && bitRead(counterCB,0) == 1 ) {
        parody_right++;  
    }
    
    // termEZ31
    if (bitRead(counterA0,4) == 1 && bitRead(counterCB,2) == 1 ) {
        parody_right++;  
    }

    // termEZ32
    if (bitRead(counterA0,5) == 1 && bitRead(counterCB,3) == 1 ) {
        parody_right++;  
    }

    // termFZ01
    if (bitRead(counterCB,0) == 1 && bitRead(counterED,0) == 1 ) {
        parody_right++;  
    }

    // termFZ02
    if (bitRead(counterCB,1) == 1 && bitRead(counterED,1) == 1 ) {
        parody_right++;  
    }

    // termFZ11 // button 2 is 0
    if (bitRead(counterCB,2) == 1 && bitRead(counterED,2) == 1 ) {
        parody_right++;  
    }    

    // termFZ12 // button 2 is 1
    if (bitRead(counterCB,2) == 1 && bitRead(counterED,3) == 1 ) {
        parody_right++;  
    }

    // termFZ13 // button 2 is 0
    if (bitRead(counterCB,3) == 1 && bitRead(counterED,3) == 1 ) {
        parody_right++;  
    }

//    // termFZ14 // button 2 is 1
//    if (bitRead(counterCB,3) == 1 && bitRead(counterED,2) == 1 ) {
//        parody_right++;  
//    }

     
     

}
