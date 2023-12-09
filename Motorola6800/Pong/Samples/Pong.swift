/*
 Run address: 0x8000
 Input: None
*/

extension Samples {
  static let pong: [UInt8] = [
/*    xPrevious = $4000              */
/*    yPrevious = $4001              */
/*    xCurrent = $4002               */
/*    yCurrent = $4003               */
/*    xSpeed = $4004                 */
/*    ySpeed = $4005                 */

/*    8000:  SETUP:                  */
/*    8000:    LDAA #$1              */    0x86, 0x01,
/*    8002:    STAA xPrevious        */    0xB7, 0x40, 0x00,
/*    8005:    STAA yPrevious        */    0xB7, 0x40, 0x01,
/*    8008:    STAA xCurrent         */    0xB7, 0x40, 0x02,
/*    800B:    STAA yCurrent         */    0xB7, 0x40, 0x03,
/*    800E:    STAA xSpeed           */    0xB7, 0x40, 0x04,
/*    8011:    STAA ySpeed           */    0xB7, 0x40, 0x05,
/*    8014:    LDS #$7FFF            */    0x8E, 0x7F, 0xFF,
/*    8017:    JMP MAIN              */    0x7E, 0x80, 0x1A,

/*    801A:  MAIN:                   */
/*    801A:    LDAA #$0              */    0x86, 0x00,
/*    801C:    JSR CLEAR_SCREEN      */    0xBD, 0x80, 0x70,
/*    801F:  draw$:                  */
/*    801F:    LDAA xCurrent         */    0xB6, 0x40, 0x02,
/*    8022:    LDAB yCurrent         */    0xF6, 0x40, 0x03,
/*    8025:    SEC                   */    0x0D,
/*    8026:    JSR MODIFY_PIXEL      */    0xBD, 0x80, 0x7C,
/*    8029:    LDAA xPrevious        */    0xB6, 0x40, 0x00,
/*    802C:    LDAB yPrevious        */    0xF6, 0x40, 0x01,
/*    802F:    CLC                   */    0x0C,
/*    8030:    JSR MODIFY_PIXEL      */    0xBD, 0x80, 0x7C,
/*    8033:    LDAA xCurrent         */    0xB6, 0x40, 0x02,
/*    8036:    STAA xPrevious        */    0xB7, 0x40, 0x00,
/*    8039:    LDAB yCurrent         */    0xF6, 0x40, 0x03,
/*    803C:    STAB yPrevious        */    0xF7, 0x40, 0x01,
/*    803F:    CMPA #199             */    0x81, 0xC7,
/*    8041:    BNE rigth_check$      */    0x26, 0x03,
/*    8043:    NEG xSpeed            */    0x70, 0x40, 0x04,
/*    8046:  rigth_check$:           */
/*    8046:    CMPA #0               */    0x81, 0x00,
/*    8048:    BNE left_check$       */    0x26, 0x03,
/*    804A:    NEG xSpeed            */    0x70, 0x40, 0x04,
/*    804D:  left_check$:            */
/*    804D:    CMPB #149             */    0xC1, 0x95,
/*    804F:    BNE bottom_check$     */    0x26, 0x03,
/*    8051:    NEG ySpeed            */    0x70, 0x40, 0x05,
/*    8054:  bottom_check$:          */
/*    8054:    CMPB #0               */    0xC1, 0x00,
/*    8056:    BNE top_check$        */    0x26, 0x03,
/*    8058:    NEG ySpeed            */    0x70, 0x40, 0x05,
/*    805B:  top_check$:             */
/*    805B:    ADDA xSpeed           */    0xBB, 0x40, 0x04,
/*    805E:    STAA xCurrent         */    0xB7, 0x40, 0x02,
/*    8061:    ADDB ySpeed           */    0xFB, 0x40, 0x05,
/*    8064:    STAB yCurrent         */    0xF7, 0x40, 0x03,
/*    8067:    LDX #$05FF            */    0xCE, 0x05, 0xFF,
/*    806A:  delay_loop$:            */
/*    806A:    DEX                   */    0x09,
/*    806B:    BNE delay_loop$       */    0x26, 0xFD,
/*    806D:    JMP draw$             */    0x7E, 0x80, 0x1F,
/*    8070:  CLEAR_SCREEN:           */
/*    8070:    LDX #$2000            */    0xCE, 0x20, 0x00,
/*    8073:  loop$:                  */
/*    8073:    CLR 0, X              */    0x6F, 0x00,
/*    8075:    INX                   */    0x08,
/*    8076:    CPX #$32C0            */    0x8C, 0x32, 0xC0,
/*    8079:    BNE loop$             */    0x26, 0xF8,
/*    807B:    RTS                   */    0x39,

/*    807C:  MODIFY_PIXEL:           */
/*    807C:    PSHA                  */    0x36,
/*    807D:    TPA                   */    0x07,
/*    807E:    ANDA #$1              */    0x84, 0x01,
/*    8080:    PSHB                  */    0x37,
/*    8081:    CLRB                  */    0x5F,
/*    8082:    PSHB                  */    0x37,
/*    8083:    PSHA                  */    0x36,
/*    8084:    TSX                   */    0x30,
/*    8085:    CLC                   */    0x0C,
/*    8086:    ROL 2, X              */    0x69, 0x02,
/*    8088:    ROL 1, X              */    0x69, 0x01,
/*    808A:    CLC                   */    0x0C,
/*    808B:    ROL 2, X              */    0x69, 0x02,
/*    808D:    ROL 1, X              */    0x69, 0x01,
/*    808F:    CLC                   */    0x0C,
/*    8090:    ROL 2, X              */    0x69, 0x02,
/*    8092:    ROL 1, X              */    0x69, 0x01,
/*    8094:    CLC                   */    0x0C,
/*    8095:    ROL 2, X              */    0x69, 0x02,
/*    8097:    ROL 1, X              */    0x69, 0x01,
/*    8099:    CLC                   */    0x0C,
/*    809A:    ROL 2, X              */    0x69, 0x02,
/*    809C:    ROL 1, X              */    0x69, 0x01,
/*    809E:    LDAB #$20             */    0xC6, 0x20,
/*    80A0:    ADDB 1, X             */    0xEB, 0x01,
/*    80A2:    STAB 1, X             */    0xE7, 0x01,
/*    80A4:    LDAA 3, X             */    0xA6, 0x03,
/*    80A6:    TAB                   */    0x16,
/*    80A7:    LSRA                  */    0x44,
/*    80A8:    LSRA                  */    0x44,
/*    80A9:    LSRA                  */    0x44,
/*    80AA:    ADDA 2, X             */    0xAB, 0x02,
/*    80AC:    STAA 2, X             */    0xA7, 0x02,
/*    80AE:    LDX 1, X              */    0xEE, 0x01,
/*    80B0:    ANDB #$7              */    0xC4, 0x07,
/*    80B2:    PULA                  */    0x32,
/*    80B3:    TSTA                  */    0x4D,
/*    80B4:    BEQ clear_pixel$      */    0x27, 0x0E,
/*    80B6:  set_pixel$:             */
/*    80B6:    TSTB                  */    0x5D,
/*    80B7:    BEQ do_set_pixel$     */    0x27, 0x05,
/*    80B9:    CLC                   */    0x0C,
/*    80BA:    ASLA                  */    0x48,
/*    80BB:    DECB                  */    0x5A,
/*    80BC:    BRA set_pixel$        */    0x20, 0xF8,
/*    80BE:  do_set_pixel$:          */
/*    80BE:    ORAA 0, X             */    0xAA, 0x00,
/*    80C0:    STAA 0, X             */    0xA7, 0x00,
/*    80C2:    BRA return$           */    0x20, 0x0E,
/*    80C4:  clear_pixel$:           */
/*    80C4:    LDAA #$FE             */    0x86, 0xFE,
/*    80C6:  loop$:                  */
/*    80C6:    TSTB                  */    0x5D,
/*    80C7:    BEQ do_clear$         */    0x27, 0x05,
/*    80C9:    SEC                   */    0x0D,
/*    80CA:    ROLA                  */    0x49,
/*    80CB:    DECB                  */    0x5A,
/*    80CC:    BRA loop$             */    0x20, 0xF8,
/*    80CE:  do_clear$:              */
/*    80CE:    ANDA 0, X             */    0xA4, 0x00,
/*    80D0:    STAA 0, X             */    0xA7, 0x00,
/*    80D2:  return$:                */
/*    80D2:    INS                   */    0x31,
/*    80D3:    INS                   */    0x31,
/*    80D4:    INS                   */    0x31,
/*    80D5:    RTS                   */    0x39,
  ]
}
