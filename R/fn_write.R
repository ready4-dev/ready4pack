#' Write package datasets to dataverse dataset comma separated variables files
#' @description write_pkg_dss_to_dv_ds_csvs() is a Write function that writes a file to a specified local directory. Specifically, this function implements an algorithm to write package datasets to dataverse dataset comma separated variables files. The function returns Dataset (a list).
#' @param pkg_dss_tb Package datasets (a tibble)
#' @param dv_nm_1L_chr Dataverse name (a character vector of length one)
#' @param ds_url_1L_chr Dataset url (a character vector of length one)
#' @param wait_time_in_secs_int Wait time in secs (an integer vector), Default: 5
#' @param dev_pkg_nm_1L_chr Development package name (a character vector of length one), Default: ready4fun::get_dev_pkg_nm()
#' @param parent_dv_dir_1L_chr Parent dataverse directory (a character vector of length one), Default: '../../../../Data/Dataverse'
#' @param key_1L_chr Key (a character vector of length one), Default: Sys.getenv("DATAVERSE_KEY")
#' @param server_1L_chr Server (a character vector of length one), Default: Sys.getenv("DATAVERSE_SERVER")
#' @return Dataset (a list)
#' @rdname write_pkg_dss_to_dv_ds_csvs
#' @export 
#' @importFrom ready4fun get_dev_pkg_nm
#' @importFrom purrr walk
#' @importFrom utils data
#' @importFrom dplyr mutate_if
#' @importFrom stringr str_c
#' @importFrom ready4 write_to_dv_with_wait
#' @keywords internal
write_pkg_dss_to_dv_ds_csvs <- function (pkg_dss_tb, dv_nm_1L_chr, ds_url_1L_chr, wait_time_in_secs_int = 5L, 
    dev_pkg_nm_1L_chr = ready4fun::get_dev_pkg_nm(), parent_dv_dir_1L_chr = "../../../../Data/Dataverse", 
    key_1L_chr = Sys.getenv("DATAVERSE_KEY"), server_1L_chr = Sys.getenv("DATAVERSE_SERVER")) 
{
    ds_chr <- pkg_dss_tb$ds_obj_nm_chr
    purrr::walk(ds_chr, ~{
        utils::data(list = .x, package = dev_pkg_nm_1L_chr, envir = environment())
        eval(parse(text = .x)) %>% dplyr::mutate_if(is.list, 
            list(~ifelse(stringr::str_c(.) == "NULL", NA_character_, 
                stringr::str_c(.)))) %>% write.csv(file = paste0("data-raw/", 
            .x, ".csv"), row.names = F)
    })
    ds_ls <- ready4::write_to_dv_with_wait(dss_tb = pkg_dss_tb, 
        dv_nm_1L_chr = dv_nm_1L_chr, ds_url_1L_chr = ds_url_1L_chr, 
        wait_time_in_secs_int = wait_time_in_secs_int, parent_dv_dir_1L_chr = parent_dv_dir_1L_chr, 
        paths_to_dirs_chr = c("data-raw"), inc_fl_types_chr = ".csv", 
        key_1L_chr = key_1L_chr, server_1L_chr = server_1L_chr)
    return(ds_ls)
}
#' Write to add urls to datasets
#' @description write_to_add_urls_to_dss() is a Write function that writes a file to a specified local directory. Specifically, this function implements an algorithm to write to add urls to datasets. The function returns Package datasets (a tibble).
#' @param ds_url_1L_chr Dataset url (a character vector of length one)
#' @param abbreviations_lup Abbreviations (a lookup table)
#' @param pkg_dss_tb Package datasets (a tibble)
#' @param pkg_nm_1L_chr Package name (a character vector of length one), Default: ready4fun::get_dev_pkg_nm()
#' @param object_type_lup Object type (a lookup table)
#' @return Package datasets (a tibble)
#' @rdname write_to_add_urls_to_dss
#' @export 
#' @importFrom ready4fun get_dev_pkg_nm write_and_doc_ds
#' @importFrom dataverse dataset_files
#' @importFrom purrr map_chr map_dfr walk
#' @importFrom stringr str_remove
#' @importFrom tibble tibble
#' @importFrom dplyr inner_join select
#' @importFrom utils data
#' @keywords internal
write_to_add_urls_to_dss <- function (ds_url_1L_chr, abbreviations_lup, pkg_dss_tb, pkg_nm_1L_chr = ready4fun::get_dev_pkg_nm(), 
    object_type_lup) 
{
    ds_fls_ls <- dataverse::dataset_files(ds_url_1L_chr)
    fl_ids_chr <- purrr::map_chr(1:length(ds_fls_ls), ~ds_fls_ls[[.x]][["dataFile"]][["pidURL"]])
    fl_nms_chr <- purrr::map_chr(1:length(ds_fls_ls), ~ds_fls_ls[[.x]][["dataFile"]][["originalFileName"]] %>% 
        stringr::str_remove(".csv"))
    url_lup <- purrr::map_dfr(1:length(ds_fls_ls), ~tibble::tibble(ds_obj_nm_chr = ds_fls_ls[[.x]][["dataFile"]][["originalFileName"]] %>% 
        stringr::str_remove(".csv"), url_chr = ds_fls_ls[[.x]][["dataFile"]][["pidURL"]]))
    pkg_dss_tb <- dplyr::inner_join(pkg_dss_tb %>% dplyr::select(-url_chr), 
        url_lup)
    purrr::walk(pkg_dss_tb, ~{
        utils::data(list = ..1, package = pkg_nm_1L_chr, envir = environment())
        eval(parse(text = paste0("ds<-", ..1)))
        ds %>% ready4fun::write_and_doc_ds(db_1L_chr = ..1, title_1L_chr = ..2, 
            desc_1L_chr = ..3, url_1L_chr = ..4, abbreviations_lup = abbreviations_lup, 
            object_type_lup = object_type_lup, pkg_dss_tb = pkg_dss_tb)
    })
    return(pkg_dss_tb)
}
