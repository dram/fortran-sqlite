module sqlite
  use iso_c_binding

  implicit none

  include "constants.f90"

  interface
     function sqlite3_bind_text(stmt, index, text, bytes, destructor) &
          result(res) &
          bind(c, name="sqlite3_bind_text")
       use iso_c_binding, only: c_char, c_int, c_ptr
       type(c_ptr), value :: stmt, destructor
       integer(c_int), value :: index, bytes
       character(kind=c_char), intent(in) :: text (*)
       integer(c_int) :: res
     end function sqlite3_bind_text

     function sqlite3_close(db) result(rc) &
          bind(c, name="sqlite3_close")
       use iso_c_binding, only: c_int, c_ptr
       type(c_ptr), value :: db
       integer(c_int) :: rc
     end function sqlite3_close

     function sqlite3_column_double(stmt, col) result(res) &
          bind(c, name="sqlite3_column_double")
       use iso_c_binding, only: c_double, c_int, c_ptr
       type(c_ptr), value :: stmt
       integer(c_int), value :: col
       real(c_double) :: res
     end function sqlite3_column_double

     function sqlite3_column_int(stmt, col) result(res) &
          bind(c, name="sqlite3_column_int")
       use iso_c_binding, only: c_int, c_ptr
       type(c_ptr), value :: stmt
       integer(c_int), value :: col
       integer(c_int) :: res
     end function sqlite3_column_int

     function sqlite3_column_text(stmt, col) result(res) &
          bind(c, name="sqlite3_column_text")
       use iso_c_binding, only: c_int, c_ptr
       type(c_ptr), value :: stmt
       integer(c_int), value :: col
       type(c_ptr) :: res
     end function sqlite3_column_text

     function sqlite3_finalize(stmt) result(rc) &
          bind(c, name="sqlite3_finalize")
       use iso_c_binding, only: c_int, c_ptr
       type(c_ptr), value :: stmt
       integer(c_int) :: rc
     end function sqlite3_finalize

     function sqlite3_open(filename, db) result(rc) &
          bind(c, name="sqlite3_open")
       use iso_c_binding, only: c_char, c_int, c_ptr
       character(kind=c_char), intent(in) :: filename (*)
       type(c_ptr), intent(out) :: db
       integer(c_int) :: rc
     end function sqlite3_open

     function sqlite3_prepare_v2(db, sql, bytes, stmt, tail) result(rc) &
          bind(c, name="sqlite3_prepare_v2")
       use iso_c_binding, only: c_char, c_int, c_ptr
       type(c_ptr), value :: db
       character(kind=c_char), intent(in) :: sql (*)
       integer(c_int), value :: bytes
       type(c_ptr), intent(out) :: stmt, tail
       integer(c_int) :: rc
     end function sqlite3_prepare_v2

     function sqlite3_step(stmt) result(rc) &
          bind(c, name="sqlite3_step")
       use iso_c_binding, only: c_int, c_ptr
       type(c_ptr), value :: stmt
       integer(c_int) :: rc
     end function sqlite3_step
  end interface
end module sqlite
