module sqlite_aux
  use iso_c_binding
  use sqlite

  implicit none

  private
  public &
       sqlite_aux_bind_text_value, &
       sqlite_aux_error_message, &
       sqlite_aux_open_database, &
       sqlite_aux_prepare_statement

  interface
     pure function strlen(s) bind(c)
       use iso_c_binding, only: c_size_t, c_ptr
       type(c_ptr), value :: s
       integer(c_size_t) strlen
     end function strlen
  end interface

contains

  function sqlite_aux_bind_text_value(stmt, index, text)
    type(c_ptr), intent(in) :: stmt
    integer, intent(in) :: index
    character(*), intent(in), target :: text
    logical sqlite_aux_bind_text_value

    integer rc

    rc = sqlite3_bind_text(stmt, index, c_loc(text), len(text), c_null_ptr)

    sqlite_aux_bind_text_value = rc == sqlite_ok
  end function sqlite_aux_bind_text_value

  function sqlite_aux_error_message(db)
    type(c_ptr), intent(in) :: db
    character(:), allocatable :: sqlite_aux_error_message

    type(c_ptr) cptr

    cptr = sqlite3_errmsg(db)

    block
      character(strlen(cptr)), pointer :: fptr
      call c_f_pointer(cptr, fptr)
      sqlite_aux_error_message = fptr
    end block
  end function sqlite_aux_error_message

  function sqlite_aux_open_database(path)
    character(*), intent(in) :: path
    type(c_ptr) sqlite_aux_open_database

    character(:), allocatable, target :: buffer
    integer rc
    type(c_ptr), target :: cptr

    buffer = path // c_null_char

    rc = sqlite3_open(c_loc(buffer), c_loc(cptr))

    if (rc == sqlite_ok) then
       sqlite_aux_open_database = cptr
    else
       sqlite_aux_open_database = c_null_ptr
    end if
  end function sqlite_aux_open_database

  function sqlite_aux_prepare_statement(db, sql)
    type(c_ptr), intent(in) :: db
    character(*), intent(in) :: sql
    type(c_ptr) sqlite_aux_prepare_statement

    character(:), allocatable, target :: buffer
    integer rc
    type(c_ptr), target :: cptr

    buffer = sql // c_null_char

    rc = sqlite3_prepare_v2( &
         db, c_loc(buffer), len(sql), c_loc(cptr), c_null_ptr)

    if (rc == sqlite_ok) then
       sqlite_aux_prepare_statement = cptr
    else
       sqlite_aux_prepare_statement = c_null_ptr
    end if
  end function sqlite_aux_prepare_statement

end module sqlite_aux
