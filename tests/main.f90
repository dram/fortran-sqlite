program main
  use iso_c_binding

  implicit none

  block
    use sqlite
    use sqlite_aux

    integer(c_int) :: rc
    type(c_ptr) :: db, res, stmt

    db = sqlite_aux_open_database(":memory:")
    if (.not. c_associated(db)) stop sqlite_aux_error_message(db)

    stmt = sqlite_aux_prepare_statement(db, "select ?")
    if (.not. c_associated(stmt)) stop sqlite_aux_error_message(db)

    if (.not. sqlite_aux_bind_text_value(stmt, 1, "abc")) &
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
  end block
end program main
