/*
 Run address: 0x0000
 Input: None
*/

extension Samples {
  static let terminalUsage: [UInt8] = [
    /*00  LDX DATA   */ 0xCE, 0x00, 0x59,
    /*03  LDAA X,0   */ 0xA6, 0x00,
    /*05  BEQ END    */ 0x27, 0x51,

    /*07  LDAB 0x00  */ 0xC6, 0x00,
    /*09  STAB 0x1001*/ 0xF7, 0x10, 0x01,
    /*0C  JSR DELAY  */ 0xBD, 0x00, 0x52,
    
    /*0F  STAA 0x1001*/ 0xB7, 0x10, 0x01,
    /*12  JSR DELAY  */ 0xBD, 0x00, 0x52,

    /*15  LSRA       */ 0x44,
    /*16  STAA 0x1001*/ 0xB7, 0x10, 0x01,
    /*19  JSR DELAY  */ 0xBD, 0x00, 0x52,
                        
    /*1C  LSRA       */ 0x44,
    /*1D  STAA 0x1001*/ 0xB7, 0x10, 0x01,
    /*20  JSR DELAY  */ 0xBD, 0x00, 0x52,
    
    /*23  LSRA       */ 0x44,
    /*24  STAA 0x1001*/ 0xB7, 0x10, 0x01,
    /*27  JSR DELAY  */ 0xBD, 0x00, 0x52,
    
    /*2A  LSRA       */ 0x44,
    /*2B  STAA 0x1001*/ 0xB7, 0x10, 0x01,
    /*2E  JSR DELAY  */ 0xBD, 0x00, 0x52,
    
    /*31  LSRA       */ 0x44,
    /*32  STAA 0x1001*/ 0xB7, 0x10, 0x01,
    /*35  JSR DELAY  */ 0xBD, 0x00, 0x52,
    
    /*38  LSRA       */ 0x44,
    /*39  STAA 0x1001*/ 0xB7, 0x10, 0x01,
    /*3C  JSR DELAY  */ 0xBD, 0x00, 0x52,
    
    /*3F  LSRA       */ 0x44,
    /*40  STAA 0x1001*/ 0xB7, 0x10, 0x01,
    /*43  JSR DELAY  */ 0xBD, 0x00, 0x52,
                        
    /*46  LDAB 0x01  */ 0xC6, 0x01,
    /*48  STAA 0x1001*/ 0xF7, 0x10, 0x01,
    /*4B  JSR DELAY  */ 0xBD, 0x00, 0x52,
    
    /*4E  INX        */ 0x08,
    /*4F  JMP NEXT   */ 0x7E, 0x00, 0x03,

    /*52  LDAB 0x64  */ 0xC6, 0x17,
    /*54  DECB       */ 0x5A,
    /*55  BNE        */ 0x26, 0xFD,
    /*57  RTS        */ 0x39,
    
    /*58  WAI        */ 0x3E,
                        
    /*59  DATA       */ 0x48, 0x45, 0x4C, 0x4C, 0x4F, 0x21, 0x00
  ]
}
