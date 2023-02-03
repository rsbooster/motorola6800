/*
 Run address: 0x0000
 Input: None
*/

extension Samples {
  static let decimalCounter: [UInt8] = [
    /*00  LDA A 00   */ 0x86, 0x00,
    /*02  LDA B 01   */ 0x8B, 0x01,
    /*04  ABA        */ 0x19,
    /*05  JSR REDIS  */ 0xBD, 0xFC, 0xBC,
    /*08  JSR OUTBYT */ 0xBD, 0xFE, 0x20,
    /*0B  JMP        */ 0x7E, 0x00, 0x02,
    /*0E  WAI        */ 0x3E,
  ]
}
