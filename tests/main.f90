program main
  use cstrings
  use iso_c_binding
  use sqlite
  use sqlite_aux

  implicit none

  block
    integer(c_int) rc
    type(c_ptr) res
    type(c_ptr), target :: db, stmt

    call cstring_initialize

    rc = sqlite3_open(cstring(":memory:"), c_loc(db))
    if (rc /= sqlite_ok) stop sqlite_aux_error_message(db)

    rc = sqlite3_prepare_v2( &
         db, cstring("select ?"), -1, c_loc(stmt), c_null_ptr)
    if (rc /= sqlite_ok) stop sqlite_aux_error_message(db)

    if (sqlite3_bind_text( &
         stmt, 1, cstring("abc"), -1, c_null_ptr) /= sqlite_ok) &
         stop sqlite_aux_error_message(db)

    rc = sqlite3_step(stmt)
    print *, "sqlite3_step", rc

    res = sqlite3_column_text(stmt, 0)
    block
      character(1), pointer :: fres
      call c_f_pointer(res, fres)
      print *, "sqlite3_column_text ", fres
    end block

    rc = sqlite3_finalize(stmt)
    print *, "sqlite3_finalize", rc

    rc = sqlite3_close(db)
    print *, "sqlite3_close", rc

    call cstring_finalize
  end block
end program main
