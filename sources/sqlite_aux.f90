module sqlite_aux
  use iso_c_binding
  use sqlite

  implicit none

  private
  public &
       sqlite_aux_error_message, &
       sqlite_aux_get_text_column, &
       sqlite_aux_prepare_statement

  interface
     pure function strlen(s) bind(c)
       use iso_c_binding, only: c_size_t, c_ptr
       type(c_ptr), value :: s
       integer(c_size_t) strlen
     end function strlen
  end interface

contains

  function sqlite_aux_error_message(db)
    type(c_ptr), value :: db
    character(:), allocatable :: sqlite_aux_error_message

    type(c_ptr) cptr

    cptr = sqlite3_errmsg(db)

    block
      character(strlen(cptr)), pointer :: fptr
      call c_f_pointer(cptr, fptr)
      sqlite_aux_error_message = fptr
    end block
  end function sqlite_aux_error_message

  subroutine sqlite_aux_get_text_column(stmt, index, text)
    type(c_ptr), value :: stmt
    integer, value :: index
    character(:), intent(out), allocatable :: text

    type(c_ptr) cptr

    cptr = sqlite3_column_text(stmt, index)

    block
      character(strlen(cptr)), pointer :: fptr
      call c_f_pointer(cptr, fptr)
      text = fptr
    end block
  end subroutine sqlite_aux_get_text_column

  function sqlite_aux_prepare_statement(db, sql)
    type(c_ptr), value :: db
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
