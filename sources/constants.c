#include <stdio.h>
#include <sqlite3.h>

#define INTEGER_PARAMETER "integer(c_int), parameter :: "

int main(void)
{
	printf(INTEGER_PARAMETER "sqlite_done = %d\n", SQLITE_DONE);
	printf(INTEGER_PARAMETER "sqlite_error = %d\n", SQLITE_ERROR);
	printf(INTEGER_PARAMETER "sqlite_misuse = %d\n", SQLITE_MISUSE);
	printf(INTEGER_PARAMETER "sqlite_ok = %d\n", SQLITE_OK);
	printf(INTEGER_PARAMETER "sqlite_row = %d\n", SQLITE_ROW);

	return 0;
}
