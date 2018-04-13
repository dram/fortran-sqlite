#include <stdio.h>
#include <sqlite3.h>

int main(void)
{
	printf("integer(c_int) :: sqlite_error = %d\n", SQLITE_ERROR);
	printf("integer(c_int) :: sqlite_ok = %d\n", SQLITE_OK);
	printf("integer(c_int) :: sqlite_row = %d\n", SQLITE_ROW);

	return 0;
}
