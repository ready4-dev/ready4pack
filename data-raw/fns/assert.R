assert_single_row_tb <- function(x){
  testit::assert("Object is not a tibble",tibble::is_tibble(x))
  testit::assert("Tibble does not have exactly one row",nrow(x)==1)
}
