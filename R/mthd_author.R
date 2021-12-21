#' Author and save files
#' @description author.ready4pack_manifest() is an author method that authors and saves files to local or remote locations. This method is implemented for the ready4 s3 class Manifest for packages containing datasets. The function is called for its side effects and does not return a value.
#' @param x An instance of ready4 s3 class Manifest for packages containing datasets.
#' @return x (An object)
#' @rdname author-methods
#' @export 
#' @importFrom ready4 metamorphose author authorData
author.ready4pack_manifest <- function (x) 
{
    x$x_ready4fun_manifest <- ready4::metamorphose(x) %>% ready4::author()
    ready4::authorData(x)
    return(x)
}
#' @rdname author-methods
#' @aliases author,ready4pack_manifest-method
#' @importFrom ready4 author
methods::setMethod("author", methods::className("ready4pack_manifest", package = "ready4pack"), author.ready4pack_manifest)
