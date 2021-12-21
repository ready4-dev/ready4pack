#' Metamorphose an object
#' @description metamorphose.ready4pack_manifest() is a metamorphose method that metamorphoses an instance of a class into an instance of a different (non-child) class. This method is implemented for the ready4 s3 class Manifest for packages containing datasets. The function returns Manifest (a ready4 S3).
#' @param x An instance of ready4 s3 class Manifest for packages containing datasets.
#' @return Manifest (a ready4 S3)
#' @rdname metamorphose-methods
#' @export 
#' @importFrom ready4class ready4class_constructor ready4class_manifest make_pt_ready4class_manifest
#' @importFrom ready4 metamorphose
metamorphose.ready4pack_manifest <- function (x) 
{
    if (identical(x$pkg_ds_ls_ls, list(NULL))) 
        x$pkg_ds_ls_ls <- list()
    x$x_ready4fun_manifest$subsequent_ls$pkg_ds_ls_ls <- x$pkg_ds_ls_ls
    if (!identical(x$constructor_r3, ready4class::ready4class_constructor())) {
        manifest_r3 <- ready4class::ready4class_manifest(ready4class::make_pt_ready4class_manifest(x$x_ready4fun_manifest, 
            constructor_r3 = x$constructor_r3))
    }
    else {
        manifest_r3 <- x$x_ready4fun_manifest
    }
    return(manifest_r3)
}
#' @rdname metamorphose-methods
#' @aliases metamorphose,ready4pack_manifest-method
#' @importFrom ready4 metamorphose
methods::setMethod("metamorphose", methods::className("ready4pack_manifest", package = "ready4pack"), metamorphose.ready4pack_manifest)
