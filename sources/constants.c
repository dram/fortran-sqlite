#include <stdio.h>
#include <sqlite3.h>

#define INT_PARAMETER "integer(c_int), parameter :: "

int main(void)
{
	printf(INT_PARAMETER "sqlite_done = %d\n", SQLITE_DONE);
	printf(INT_PARAMETER "sqlite_error = %d\n", SQLITE_ERROR);
	printf(INT_PARAMETER "sqlite_misuse = %d\n", SQLITE_MISUSE);
	printf(INT_PARAMETER "sqlite_ok = %d\n", SQLITE_OK);
	printf(INT_PARAMETER "sqlite_row = %d\n", SQLITE_ROW);

	return 0;
}
