module key16(
  input            clk,   //ʱ��
    input      [3:0] row,  //ɨ���� [0123]K3  L3  J4  K4 
    output reg [3:0] col, //ɨ���ź� [0123]L5  J6  K6  M2
  output reg [4:0] key  // ����ļ���ֵ
);

reg [16:0] cnt;  //��Ƶ
always @ (posedge clk)
    cnt = cnt + 1;
wire check = cnt[16];

parameter NO_KEY_PRESSED = 3'b000;  // û�а�������  
parameter SCAN_COL0      = 3'b001;  // ɨ��0��
parameter SCAN_COL1      = 3'b010;  // ɨ��1 
parameter SCAN_COL2      = 3'b011;  // ɨ��2 
parameter SCAN_COL3      = 3'b100;  // ɨ��3
parameter KEY_PRESSED    = 3'b101;  // �а�������
 
reg [2:0] current_state, next_state;    // ��̬����̬
 
always @ (posedge check)
    current_state = next_state;
 
always @ *
  case (current_state)
    NO_KEY_PRESSED :                    // û�а�������
        if (row != 4'hF)
          next_state = SCAN_COL0;
        else
            next_state = NO_KEY_PRESSED;
    SCAN_COL0 :                         // ɨ��0��
        if (row != 4'hF)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_COL1;
    SCAN_COL1 :                         // ɨ��1
        if (row != 4'hF)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_COL2;    
    SCAN_COL2 :                         // ɨ��2
        if (row != 4'hF)
          next_state = KEY_PRESSED;
        else
          next_state = SCAN_COL3;
    SCAN_COL3 :                         // ɨ��3
        if (row != 4'hF)
          next_state = KEY_PRESSED;
        else
          next_state = NO_KEY_PRESSED;
    KEY_PRESSED :                       // �а�������
        if (row != 4'hF)
          next_state = KEY_PRESSED;
        else
          next_state = NO_KEY_PRESSED;                      
  endcase

reg       key_pressed_flag;             // ���̰��±�־
reg [3:0] col_val, row_val;             // �С���
 reg [3:0]void=0;                       // ɨ�������
always @ (posedge check)
  begin
      if(row==4'hf)
          void=void+1;
      else void=0;
      if(void[3])
          key_pressed_flag=0;            //�ж�ɨ���Ƿ�ȫ��
  if (next_state==NO_KEY_PRESSED)
  begin
    col              = 4'h0;
    key_pressed_flag =    0;
  end
  else
    case (next_state)
      SCAN_COL0 :                       // ɨ���0��
        col = 4'b1110;
      SCAN_COL1 :                       // ɨ���1��
        col = 4'b1101;
      SCAN_COL2 :                       // ɨ���2��
        col = 4'b1011;
      SCAN_COL3 :                       // ɨ���3��
        col = 4'b0111;
      KEY_PRESSED :                     // �а�������
      begin
        col_val          = col;        // ������ֵ
        row_val          = row;        // ������ֵ
        key_pressed_flag = 1;          // �ü��̰��±�־  
      end
    endcase
end

always @ (posedge check)
  if (!key_pressed_flag)
    key = 5'b10000;
  else
    case ({col_val, row_val})
      8'b11101110 : key = 5'b00001;
      8'b11011110 : key = 5'b00010;
      8'b10111110 : key = 5'b00011;
      8'b01111110 : key = 5'b01010;
      
      8'b11101101 : key = 5'b00100;
      8'b11011101 : key = 5'b00101;
      8'b10111101 : key = 5'b00110;
      8'b01111101 : key = 5'b01011;
      
      8'b11101011 : key = 5'b00111;
      8'b11011011 : key = 5'b01000;
      8'b10111011 : key = 5'b01001;
      8'b01111011 : key = 5'b01100;
      
      8'b11100111 : key = 5'b01110;
      8'b11010111 : key = 5'b00000;
      8'b10110111 : key = 5'b01111;
      8'b01110111 : key = 5'b01101;
    endcase
endmodule