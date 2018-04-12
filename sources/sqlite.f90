module sqlite
  use iso_c_binding

  implicit none

  include "constants.f90"

  interface
     function sqlite3_close(db) result(rc) &
          bind(c, name="sqlite3_close")
       use iso_c_binding, only: c_int, c_ptr
       type(c_ptr), value :: db
       integer(c_int) :: rc
     end function sqlite3_close

     function sqlite3_open(filename, db) result(rc) &
          bind(c, name="sqlite3_open")
       use iso_c_binding, only: c_char, c_int, c_ptr
       character(kind=c_char), intent(in) :: filename (*)
       type(c_ptr), intent(out) :: db
       integer(c_int) :: rc
     end function sqlite3_open
  end interface
end module sqlite
