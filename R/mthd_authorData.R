#' Author and document datasets
#' @description authorData.ready4pack_manifest() is an authorData method that authors and saves files necessary for creating and documenting datasets. This method is implemented for the ready4 s3 class Manifest for packages containing datasets. The function is called for its side effects and does not return a value.
#' @param x An instance of `ready4pack_manifest`, a ready4 s3 class Manifest for packages containing datasets.
#' @return No return value, called for side effects.
#' @rdname authorData-methods
#' @export 
#' @importFrom purrr map_chr walk2 walk
#' @importFrom ready4fun write_and_doc_ds
#' @importFrom ready4 authorData
authorData.ready4pack_manifest <- function (x) 
{
    if (!is.null(x$clss_to_apply_ls) & !identical(x$clss_to_apply_ls, 
        list(NULL))) {
        ds_nms_chr <- x$pkg_ds_ls_ls %>% purrr::map_chr(~.x$db_1L_chr)
        x$clss_to_apply_ls %>% purrr::walk2(names(x$clss_to_apply_ls), 
            ~{
                fun_fn <- eval(parse(text = .y))
                .x %>% purrr::walk(~{
                  idx_1L_int <- which(ds_nms_chr == .x)
                  x$pkg_ds_ls_ls[[idx_1L_int]]$db_df %>% fun_fn %>% 
                    ready4fun::write_and_doc_ds(db_1L_chr = x$pkg_ds_ls_ls[[idx_1L_int]]$db_1L_chr, 
                      title_1L_chr = x$pkg_ds_ls_ls[[idx_1L_int]]$title_1L_chr, 
                      desc_1L_chr = x$pkg_ds_ls_ls[[idx_1L_int]]$desc_1L_chr, 
                      url_1L_chr = x$pkg_ds_ls_ls[[idx_1L_int]]$url_1L_chr, 
                      abbreviations_lup = x$x_ready4fun_manifest$subsequent_ls$abbreviations_lup, 
                      object_type_lup = x$x_ready4fun_manifest$subsequent_ls$object_type_lup)
                })
            })
    }
}
#' @rdname authorData-methods
#' @aliases authorData,ready4pack_manifest-method
#' @importFrom ready4 authorData
methods::setMethod("authorData", methods::className("ready4pack_manifest", package = "ready4pack"), authorData.ready4pack_manifest)
