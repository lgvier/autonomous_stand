
const int RELAY_PIN = 3;

// the setup function runs once when you press reset or power the board
void setup() {
  // initialize digital pin LED_BUILTIN as an output.
  pinMode(LED_BUILTIN, OUTPUT);

  // initialize digital pin as an output.
  pinMode(RELAY_PIN, OUTPUT);

  // open serial port, set data rate to 9600 bps
  Serial.begin(9600);
}

// the loop function runs over and over again forever
void loop() {
  if (Serial.available() > 0) { // got something
    // read from serial
    int incoming_num = Serial.parseInt();
    Serial.print("I received: ");
    Serial.println(incoming_num, DEC);
    // if the number 1 is received, push the button
    if (incoming_num == 1) {
      Serial.println("Time to get up!");
      // press
      digitalWrite(LED_BUILTIN, HIGH);
      digitalWrite(RELAY_PIN, HIGH);
      // wait
      delay(500);
      // release
      digitalWrite(LED_BUILTIN, LOW);
      digitalWrite(RELAY_PIN, LOW);
    }
  }
}
