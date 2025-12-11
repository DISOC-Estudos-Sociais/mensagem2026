le_dados <- function(year = 2024, input = "../data/clean_data"){
  if (!require("srvyr")) stop("Pacote readr não instalado. Use: install.packages('srvyr')")
  
  design <- readRDS(file.path(input, sprintf("pnadc_design_%d.RDS", year))) |> 
    srvyr::as_survey()
  
  return(design)
}
