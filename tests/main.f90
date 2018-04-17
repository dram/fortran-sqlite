program main
  use iso_c_binding

  implicit none

  block
    use sqlite

    character(:), allocatable, target :: name, s, sql
    integer(c_int) :: rc
    type(c_ptr) :: db, stmt, tail, res

    name = ":memory:" // achar(0)
    rc = sqlite3_open(c_loc(name), db)
    print *, "sqlite3_open", rc

    sql = "select ?" // achar(0)
    rc = sqlite3_prepare_v2(db, c_loc(sql), -1, stmt, tail)
    print *, "sqlite3_prepare_v2", rc

    s = "abc"
    rc = sqlite3_bind_text(stmt, 1, c_loc(s), len(s), c_null_ptr)
    print *, "sqlite3_bind_text", rc

    rc = sqlite3_step(stmt)
    print *, "sqlite3_step", rc

    res = sqlite3_column_text(stmt, 0)
    block
      character(len(s)), pointer :: fres
      call c_f_pointer(res, fres)
      print *, "sqlite3_column_text ", fres
    end block

    rc = sqlite3_finalize(stmt)
    print *, "sqlite3_finalize", rc

    rc = sqlite3_close(db)
    print *, "sqlite3_close", rc
  end block
end program main
