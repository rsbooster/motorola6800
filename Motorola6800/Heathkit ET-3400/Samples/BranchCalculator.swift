/*
 Run address: 0x0000
 Input: branch address, destination address
*/

extension Samples {
  static let branchCalculator: [UInt8] = [
    /*00 START JSR REDIS  */ 0xBD, 0xFC, 0xBC,
    /*03       JSR IHB    */ 0xBD, 0xFE, 0x09,
    /*06       TAB        */ 0x16,
    /*07       JSR IHB    */ 0xBD, 0xFE, 0x09,
    /*0A       CBA        */ 0x11,
    /*0B       BCS BACK   */ 0x25, 0x0C,
    /*0D FRWD  ADD B 02   */ 0xCB, 0x02,
    /*0F       SBA        */ 0x10,
    /*10       CMP A 80   */ 0x81, 0x80,
    /*12       BCC NO     */ 0x24, 0x12,
    /*14 OUT   JSR OUTBYT */ 0xBD, 0xFE, 0x20,
    /*17       BRA START  */ 0x20, 0xE7,
    /*19 BACK  NEG A      */ 0x40,
    /*1A       ABA        */ 0x1B,
    /*1B       ADD A 02   */ 0x8B, 0x02,
    /*1D       COM A      */ 0x43,
    /*1E       ADD A 01   */ 0x8B, 0x01,
    /*20       CMP A 80   */ 0x81, 0x80,
    /*22       BCS NO     */ 0x25, 0x02,
    /*24       BRA OUT    */ 0x20, 0xEE,
    /*26 NO    JSR OUTSTR */ 0xBD, 0xFE, 0x52,
    /*29       NO         */ 0x15, 0x9D,
    /*2B       BRA START  */ 0x20, 0xD3,
  ]
}
