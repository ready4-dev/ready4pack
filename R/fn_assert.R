#' Assert single row tibble
#' @description assert_single_row_tb() is an Assert function that validates that an object conforms to required condition(s). If the object does not meet all required conditions, program execution will be stopped and an error message provided. Specifically, this function implements an algorithm to assert single row tibble. Function argument x specifies the object on which assert validation checks are to be performed. The function is called for its side effects and does not return a value.
#' @param x An object
#' @return NULL
#' @rdname assert_single_row_tb
#' @export 
#' @importFrom testit assert
#' @importFrom tibble is_tibble
#' @keywords internal
assert_single_row_tb <- function (x) 
{
    testit::assert("Object is not a tibble", tibble::is_tibble(x))
    testit::assert("Tibble does not have exactly one row", nrow(x) == 
        1)
}
