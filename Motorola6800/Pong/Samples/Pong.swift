/*
 Run address: 0x8200
 Input: None
*/

extension Samples {
  static let pong: [UInt8] = [
  /* SET_SCREEN (A) */
  /* 8000 LDX 2000    */  0xCE, 0x20, 0x00,
  /* 8003 STA X,0     */  0xA7, 0x00,
  /* 8005 INC X       */  0x08,
  /* 8006 CPX 32C0    */  0x8C, 0x32, 0xC0,
  /* 8009 BNE F8      */  0x26, 0xF8,
  /* 800B RTS         */  0x39,

  /* SET_PIXEL (A, B, X) */
  /* 800C CLR X,0     */  0x6F, 0x00,
  /* 800E CLR X,1     */  0x6F, 0x01,
  /* 8010 STAB X,1    */  0xE7, 0x01,
  /* 8012 CLC         */  0x0C,
  /* 8013 ROL X,1     */  0x69, 0x01,
  /* 8015 ROL X,0     */  0x69, 0x00,
  /* 8017 CLC         */  0x0C,
  /* 8018 ROL X,1     */  0x69, 0x01,
  /* 801A ROL X,0     */  0x69, 0x00,
  /* 801C CLC         */  0x0C,
  /* 801D ROL X,1     */  0x69, 0x01,
  /* 801F ROL X,0     */  0x69, 0x00,
  /* 8021 CLC         */  0x0C,
  /* 8022 ROL X,1     */  0x69, 0x01,
  /* 8024 ROL X,0     */  0x69, 0x00,
  /* 8026 CLC         */  0x0C,
  /* 8027 ROL X,1     */  0x69, 0x01,
  /* 8029 ROL X,0     */  0x69, 0x00,
  /* 802B LDAB #20    */  0xC6, 0x20,
  /* 802D ADDB X,0    */  0xEB, 0x00,
  /* 802F STAB X,0    */  0xE7, 0x00,
  /* 8031 TAB         */  0x16,
  /* 8032 LSRA        */  0x44,
  /* 8033 LSRA        */  0x44,
  /* 8034 LSRA        */  0x44,
  /* 8035 ADDA X,1    */  0xAB, 0x01,
  /* 8037 STAA X,1    */  0xA7, 0x01,
  /* 8039 LDAA        */  0x86, 0x01,
  /* 803B ANDB #7     */  0xC4, 0x07,
  /* 803D BEQ         */  0x27, 0x04,
  /* 803F ASLA        */  0x48,
  /* 8040 DECB        */  0x5A,
  /* 8041 BRA         */  0x20, 0xFA,
  /* 8043 LDX X,0     */  0xEE, 0x00,
  /* 8045 ORAA X,0    */  0xAA, 0x00,
  /* 8047 STAA X,0    */  0xA7, 0x00,
  /* 8049 RTS         */  0x39,

  /* CLEAR_PIXEL (A, B, X) */
  /* 804A CLR X,0     */  0x6F, 0x00,
  /* 804C CLR X,1     */  0x6F, 0x01,
  /* 804E STAB X,1    */  0xE7, 0x01,
  /* 8050 CLC         */  0x0C,
  /* 8051 ROL X,1     */  0x69, 0x01,
  /* 8053 ROL X,0     */  0x69, 0x00,
  /* 8055 CLC         */  0x0C,
  /* 8056 ROL X,1     */  0x69, 0x01,
  /* 8058 ROL X,0     */  0x69, 0x00,
  /* 805A CLC         */  0x0C,
  /* 805B ROL X,1     */  0x69, 0x01,
  /* 805D ROL X,0     */  0x69, 0x00,
  /* 805F CLC         */  0x0C,
  /* 8060 ROL X,1     */  0x69, 0x01,
  /* 8062 ROL X,0     */  0x69, 0x00,
  /* 8064 CLC         */  0x0C,
  /* 8065 ROL X,1     */  0x69, 0x01,
  /* 8067 ROL X,0     */  0x69, 0x00,
  /* 8069 LDAB #20    */  0xC6, 0x20,
  /* 806B ADDB X,0    */  0xEB, 0x00,
  /* 802D STAB X,0    */  0xE7, 0x00,
  /* 806F TAB         */  0x16,
  /* 8070 LSRA        */  0x44,
  /* 8071 LSRA        */  0x44,
  /* 8072 LSRA        */  0x44,
  /* 8073 ADDA X,1    */  0xAB, 0x01,
  /* 8075 STAA X,1    */  0xA7, 0x01,
  /* 8077 LDAA        */  0x86, 0xFE,
  /* 8079 ANDB #7     */  0xC4, 0x07,
  /* 807B BEQ         */  0x27, 0x05,
  /* 807D ASLA        */  0x48,
  /* 807E INCA        */  0x4C,
  /* 807F DECB        */  0x5A,
  /* 8080 BRA         */  0x20, 0xF9,
  /* 8082 LDX X,0     */  0xEE, 0x00,
  /* 8084 ANDA X,0    */  0xA4, 0x00,
  /* 8086 STAA X,0    */  0xA7, 0x00,
  /* 8088 RTS         */  0x39,
                          
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,

  /* MAIN () */
  /* 8100 LDA 0       */  0x86, 0x00,
  /* 8102 JS SET_SCR  */  0xBD, 0x80, 0x00,

  /* 8105 LDAA        */  0xB6, 0x40, 0x02,
  /* 8108 LDAB        */  0xF6, 0x40, 0x03,
  /* 810B LDX #4010   */  0xCE, 0x40, 0x10,
  /* 810E JSR SET_P   */  0xBD, 0x80, 0x0C,

  /* 8111 LDAA        */  0xB6, 0x40, 0x00,
  /* 8114 LDAB        */  0xF6, 0x40, 0x01,
  /* 8117 LDX #4010   */  0xCE, 0x40, 0x10,
  /* 811A JSR CLR_P   */  0xBD, 0x80, 0x4A,

  /* 811D LDAA        */  0xB6, 0x40, 0x02,
  /* 8120 STAA        */  0xB7, 0x40, 0x00,
  /* 8123 LDAB        */  0xF6, 0x40, 0x03,
  /* 8126 STAB        */  0xF7, 0x40, 0x01,

  /* 8129 CMPA 199    */  0x81, 0xC7,
  /* 812B BNE 01      */  0x26, 0x03,
  /* 812D NEG         */  0x70, 0x40, 0x04,
  /* 8130 CMPA 0      */  0x81, 0x00,
  /* 8132 BNE 01      */  0x26, 0x03,
  /* 8134 NEG         */  0x70, 0x40, 0x04,

  /* 8137 CMPB 149    */  0xC1, 0x95,
  /* 8139 BNE 01      */  0x26, 0x03,
  /* 813B NEG         */  0x70, 0x40, 0x05,
  /* 813E CMPB 0      */  0xC1, 0x00,
  /* 8140 BNE 01      */  0x26, 0x03,
  /* 8142 NEG         */  0x70, 0x40, 0x05,

  /* 8145 ADDA        */  0xBB, 0x40, 0x04,
  /* 8148 STAA        */  0xB7, 0x40, 0x02,
  /* 814B ADDB        */  0xFB, 0x40, 0x05,
  /* 814E STAB        */  0xF7, 0x40, 0x03,

  /* 8151 LDX         */  0xCE, 0x05, 0xFF,
  /* 8154 DEX         */  0x09,
  /* 8155 BNE         */  0x26, 0xFD,

  /* 8157 JMP 8105    */  0x7E, 0x81, 0x05,
  /* 815A WAI         */  0x3E,
                          
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                          0x00, 0x00, 0x00, 0x00, 0x00,

  /* SETUP() */
  /* 8200 LDAA 01     */  0x86, 0x01,
  /* 8202 STAA        */  0xB7, 0x40, 0x00,
  /* 8205 STAA        */  0xB7, 0x40, 0x01,
  /* 8208 STAA        */  0xB7, 0x40, 0x02,
  /* 820B STAA        */  0xB7, 0x40, 0x03,
  /* 820E STAA        */  0xB7, 0x40, 0x04,
  /* 8211 STAA        */  0xB7, 0x40, 0x05,
  /* 8214 LDS         */  0xBE, 0x7F, 0xFF,
  /* 8217 JMP 0004    */  0x7E, 0x81, 0x00,
  ]
}