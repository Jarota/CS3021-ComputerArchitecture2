#include <stdio.h>
#include <time.h>
#define numRegisterWindows 16

int calls;
int depth;
int maxDepth;

int overflows;
int underflows;

int windowsInUse;

void overflowCheck(){
	calls++;
	depth++;
	if(depth>maxDepth){
		maxDepth = depth;
	}
	if(windowsInUse==numRegisterWindows){
		overflows++;
	}
	else {
		windowsInUse++;
	}
}

void underflowCheck(){
	depth--;
	if(windowsInUse==2){
		underflows++;
	}
	else {
		windowsInUse--;
	}
}

int ackermannWithChecks(int x, int y){
	overflowCheck();
	int ret;
	if(x==0){
		ret = y + 1;
	}
	else if(y==0){
		ret = ackermannWithChecks(x-1, 1);
	}
	else {
		ret = ackermannWithChecks(x-1, ackermannWithChecks(x, y-1));
	}
	underflowCheck();
	return ret;
}

int ackermann(int x, int y){
	if(x==0){
		return y + 1;
	}
	else if(y==0){
		return ackermann(x-1, 1);
	}
	else {
		return ackermann(x-1, ackermann(x, y-1));
	}
}


int main(int argc, char** argv){
	//ackermannWithChecks(3, 6);
	//printf("Number of Calls: %d\nMaximum Register Window Depth: %d\nOverflows: %d\nUnderflows: %d\n", calls, maxDepth, overflows, underflows);
	int start, end;
	volatile int x = 3;	// prevent compiler optimising away the superfluous calls to ackermann
	int i = 0;
	start = clock();	// start time
	while(i<100000){
		ackermann(x, 6);
		i++;
	}
	end = clock();		// end time

	double timeTaken = (double) end - start;
	double timePerCall = timeTaken / 100000;
	printf("Time Taken: %.1f\nAverage Time Per Call: %.3f", timeTaken, timePerCall);

	return 0;
}
