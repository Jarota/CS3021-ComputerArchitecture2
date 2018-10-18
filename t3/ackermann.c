#include <stdio.h>
#define numRegisterWindows 6

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

int ackermann(int x, int y){
	overflowCheck();
	int ret;
	if(x==0){
		ret = y + 1;
	}
	else if(y==0){
		ret = ackermann(x-1, 1);
	}
	else {
		ret = ackermann(x-1, ackermann(x, y-1));
	}
	underflowCheck();
	return ret;
}


int main(int argc, char** argv){
	ackermann(3, 6);
	printf("Number of Calls: %d\nMaximum Register Window Depth: %d\nOverflows: %d\nUnderflows: %d\n", calls, maxDepth, overflows, underflows);
	return 0;
}
