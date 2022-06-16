#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define DATASET_PATH "/home/debian/datasets"
#define GPIO_PATH "/sys/class/gpio/"

void set_PIN_direction (char pin[], char dir[]) {
	FILE* fp;
	char fullFileName[100]; // to store the path and filename
	sprintf(fullFileName, GPIO_PATH "%s" "/direction", pin); // write path/name
	fp = fopen(fullFileName, "w+"); // open file for writing
	fprintf(fp, "%s", dir); // send the value to the file
	fclose(fp);
}

void writeGPIO(char pin[], char value[]) {
	FILE* fp;
	char fullFileName[100];

	sprintf(fullFileName, GPIO_PATH "%s" "/value", pin); // write path/namea

	fp = fopen(fullFileName, "w+"); // open file for writing
	fprintf(fp, "%s", value); // send the value to the file

	fclose(fp);
}

int readGPIO(char pin[]) {
	FILE* fp;
	int value;
	char fullFileName[100];

	sprintf(fullFileName, GPIO_PATH "%s" "/value", pin); // write path/namea

	fp = fopen(fullFileName, "r"); // open file for reading
	fscanf(fp, "%d", &value); // send the value to the file

	fclose(fp);

	return value;
}


void send_byte(char data) {
	char bit0 = (data & (char)0b00000001);
	char bit1 = (data & (char)0b00000010) >> 1;
	char bit2 = (data & (char)0b00000100) >> 2;
	char bit3 = (data & (char)0b00001000) >> 3;
	char bit4 = (data & (char)0b00010000) >> 4;
	char bit5 = (data & (char)0b00100000) >> 5;
	char bit6 = (data & (char)0b01000000) >> 6;
	char bit7 = (data & (char)0b10000000) >> 7;

//	printf("Starting transmition... ok is %d\n", readGPIO("/gpio20"));

	// Check if ok is low. Wait until it is true 
	while (readGPIO("/gpio20") == 1);

//	printf("Started... Setting up data lanes and init\n");

	if((int)bit0 == 1)
		writeGPIO("/gpio30", "1"); // data0
	else
		writeGPIO("/gpio30", "0"); // data0

	if((int)bit1 == 1)
		writeGPIO("/gpio60", "1"); // data1
	else
		writeGPIO("/gpio60", "0"); // data1

	if((int)bit2 == 1)
		writeGPIO("/gpio31", "1"); // data2
	else
		writeGPIO("/gpio31", "0"); // data2

	if((int)bit3 == 1)
		writeGPIO("/gpio50", "1"); // data3
	else
		writeGPIO("/gpio50", "0"); // data3
	
	if((int)bit4 == 1)
		writeGPIO("/gpio48", "1"); // data4
	else
		writeGPIO("/gpio48", "0"); // data4

	if((int)bit5 == 1)
		writeGPIO("/gpio51", "1"); // data5
	else
		writeGPIO("/gpio51", "0"); // data5

	if((int)bit6 == 1)
		writeGPIO("/gpio5", "1"); // data6
	else
		writeGPIO("/gpio5", "0"); // data6

	if((int)bit7 == 1)
		writeGPIO("/gpio4", "1"); // data7
	else
		writeGPIO("/gpio4", "0"); // data7


	writeGPIO("/gpio7", "1");

	//printf("Waiting FPGA response...\n");

	// Wait until FPGA states it is ready
	while (readGPIO("/gpio20") == 0);

	//printf("FPGA ready...\n");

	writeGPIO("/gpio7", "0");
//	writeGPIO("/gpio112", "0");

	//printf("Data sent. Waiting FPGA ACK...\n");
	
	// Wait until FPGA states it received successfully the data
	while (readGPIO("/gpio20") == 1);

	//printf("ACK received. Transmition done sucessfully...\n");
	//}
	
}

int main(int argc, char* argv[]){

	FILE* dataset;
	char  fileName[100];

	char read_data;

	char first_byte;
	char second_byte;

	int sent_count = 0;
	int received_count = 0;

	int accept_count = 0;
	int drop_count = 0;

	int found = 0;
	int receiving = 0;

	int first_pkg = 1;

	int running = 1;

	int i;

	sprintf(fileName, DATASET_PATH "/01_20200902191856.pcap");
	printf("Using the following dataset:\n%s\n\n", fileName);

	dataset = fopen(fileName, "rb");

	// CONFIGURE PIN DIRECTION
	set_PIN_direction("/gpio49", "out");  // ok

	//SENDING
	set_PIN_direction("/gpio20", "in");  // ok
	set_PIN_direction("/gpio7",  "out"); // init

	set_PIN_direction("/gpio30", "out"); // data0
	set_PIN_direction("/gpio60", "out"); // data1
	set_PIN_direction("/gpio31", "out"); // data2
	set_PIN_direction("/gpio50", "out"); // data3
	set_PIN_direction("/gpio48", "out"); // data4
	set_PIN_direction("/gpio51", "out"); // data5
	set_PIN_direction("/gpio5",  "out"); // data6
	set_PIN_direction("/gpio4",  "out"); // data7

	//RECEIVING
	set_PIN_direction("/gpio112",  "in");  // init
	set_PIN_direction("/gpio115",  "out"); // ok

	set_PIN_direction("/gpio2",  "in"); // data0
	set_PIN_direction("/gpio15", "in"); // data1
	set_PIN_direction("/gpio14", "in"); // data2
	
	// RESET init SIGNAL
	writeGPIO("/gpio7", "0");
	
	// RESET FPGA
	writeGPIO("/gpio49", "1");
	writeGPIO("/gpio49", "0");

	while(running) {
		// FIND PACKET
		while(!found) {

			fread(&read_data, sizeof(read_data), 1, dataset);
			first_byte = read_data;

			fread(&read_data, sizeof(read_data), 1, dataset);
			second_byte = read_data;
	
			printf("%x%x ", first_byte, second_byte);

			if((first_byte == (char)0x08) && (second_byte == (char)0x00)) {
				fread(&read_data, sizeof(read_data), 1, dataset);
				first_byte = read_data;

				fread(&read_data, sizeof(read_data), 1, dataset);
				second_byte = read_data;

				printf("%x%x ", first_byte, second_byte);

				if((first_byte == (char)0x45) && (second_byte == (char)0x00)) {

					printf("\n\nPACKET FOUND. Start sending to FPGA\n\n");
				
					send_byte(first_byte);
					send_byte(second_byte);
					found = 1;
				}
			}
		}
	
		if(found){
			i=1;
			while(i<20) {
				if((receiving == 1) && (readGPIO("/gpio112") == 0)) {
					if(readGPIO("/gpio2") == 1) {
						drop_count++;
					}

					if(readGPIO("/gpio2") == 0) {
						accept_count++;
					}

					printf("Sent packets:	%d\n", sent_count);
					printf("drop_packet:	%d\n", drop_count);
					printf("accept_packet:	%d\n", accept_count);

					receiving = 2;
					writeGPIO("/gpio115", "0");
				}


				if((receiving == 0) && (readGPIO("/gpio112") == 1)){
					writeGPIO("/gpio115", "1");
					receiving = 1;

					printf("receiving: ");
				}

				if(i<19) {

					fread(&read_data, sizeof(read_data), 1, dataset);

					printf("%x ", read_data);

					send_byte(read_data);

					i++;
				}
				
				if(i == 19)  {

					printf("\n");

					if(receiving != 2)
						printf("Missed pkg\n");
					
					receiving = 0;
					i++;
				}
			}
			
			first_pkg = 0;
			sent_count++;
			found = 0;
		}
		printf("DONE SENDIND PACKET\n\n");
	}

	return 0;
}
