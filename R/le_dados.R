le_dados <- function(input = "data/clean_data"){
  if (!require("srvyr")) stop("Pacote readr não instalado. Use: install.packages('srvyr')")
  
  design <- readRDS(file.path(input, "pnadc_design.RDS")) |> 
    srvyr::as_survey()
  
  return(design)
}
