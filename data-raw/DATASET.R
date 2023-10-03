library(ready4)
library(ready4fun)
library(ready4class)
ready4fun::write_fn_type_dirs()
pkg_desc_ls <- ready4fun::make_pkg_desc_ls(pkg_title_1L_chr = "Author R Packages Of Health Economic Model Modules" %>% tools::toTitleCase(),
                                           pkg_desc_1L_chr = "ready4pack provides a set of tools for authoring R packages of model modules developed with the ready4 framework (https://www.ready4-dev.com/).
  This development version of the ready4pack package has been made available as part of the process of testing and documenting the package.
  Therefore you should only trial this software if you feel confident that you understand what it does and have created a sandpit area in which you can safely undertake testing. If you have any questions, please contact the authors (matthew.hamilton1@monash.edu).",
                                           authors_prsn = c(utils::person(
                                             given = "Matthew",family = "Hamilton", email =
                                               "matthew.hamilton1@monash.edu",role = c("aut",
                                                                                         "cre"),comment = c(ORCID = "0000-0001-7407-9194")
                                           ),
                                           utils::person("Orygen", role = c("cph", "fnd")),
                                           utils::person("Australian Government Research Training Program", role =c("fnd")),
                                           utils::person("VicHealth",role = c("fnd")),
                                           utils::person("Victoria University", role =c("fnd"))
                                           ),
                                           urls_chr = c("https://ready4-dev.github.io/ready4pack/",
                                                        "https://github.com/ready4-dev/ready4pack",
                                                        "https://www.ready4-dev.com/"))
x <- pkg_desc_ls %>%
  ready4fun::make_manifest(addl_pkgs_ls = ready4fun::make_addl_pkgs_ls(#depends_chr = "ready4",
                                                                       suggests_chr = "rmarkdown"),
                           build_ignore_ls = ready4fun::make_build_ignore_ls(file_nms_chr = c("initial_setup.R")),
                           check_type_1L_chr = "ready4",
                           custom_dmt_ls = ready4fun::make_custom_dmt_ls(),
                           copyright_holders_chr = "Orygen",
                           dev_pkgs_chr = c("ready4","ready4fun","ready4class"),
                           lifecycle_stage_1L_chr = "experimental",
                           path_to_pkg_logo_1L_chr = "../../../../../Documentation/Images/ready4pack-logo/default.png",
                           piggyback_to_1L_chr = "ready4-dev/ready4",
                           ready4_type_1L_chr = "authoring",
                           zenodo_badge_1L_chr = "[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5644322.svg)](https://doi.org/10.5281/zenodo.5644322)")
y <- ready4class::make_pt_ready4class_constructor(make_s3_lgl = T,
                                                  name_stub_chr = "manifest",
                                                  pt_ls = list(list("list")),
                                                  pt_chkr_pfx_ls = list(list("is.")),
                                                  pt_ns_ls = list(list("base")),
                                                  vals_ls = list(list(x_ready4fun_manifest = "ready4fun::ready4fun_manifest()",
                                                                      constructor_r3 = "ready4class::ready4class_constructor()",
                                                                      pkg_ds_ls_ls = "list()",
                                                                      clss_to_apply_ls = "list()")),
                                                  class_desc_chr = "ready4 s3 class Manifest for packages containing datasets.") %>%
  ready4class::ready4class_constructor()
z <- ready4class::ready4class_manifest(ready4class::make_pt_ready4class_manifest(x, # Convert to metamorphose method on constructor class
                                                                                 constructor_r3 = y)) # then add methods to ready4class_manifest class
x <- author(z)
ready4::write_extra_pkgs_to_actions()
write_to_edit_workflow("pkgdown.yaml") # In other packages, run for "test-coverage.yaml" as well.
readLines("_pkgdown.yml") %>%
  stringr::str_replace_all("  - text: Model", "  - text: Framework & Model") %>%
  writeLines(con = "_pkgdown.yml")
# readme_chr <- readLines("README.md")
# readme_chr[-which(readme_chr %>% purrr::map_lgl(~startsWith(.x, "[![test-coverage]")))] %>%
#   writeLines(con = "README.md")
devtools::build_vignettes()
