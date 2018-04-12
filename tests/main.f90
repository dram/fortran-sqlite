program main
  use iso_c_binding

  implicit none

  block
    use sqlite

    type(c_ptr) :: db
    integer(c_int) :: rc

    rc = sqlite3_open(":memory:", db)

    rc = sqlite3_close(db)
  end block
end program main
