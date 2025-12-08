baixa_dados <- function(output = "data/clean_data"){
  
  # Carregar pacotes necessários
  if (!require("PNADcIBGE")) stop("Pacote PNADcIBGE não instalado. Use: install.packages('PNADcIBGE')")
  if (!require("readr")) stop("Pacote readr não instalado. Use: install.packages('readr')")
  
  message("Baixando dados da PNADC 2024 - Trimestre 4")
  dados <- PNADcIBGE::get_pnadc(year = 2024, topic = 4)
  
  saveRDS(dados, file = file.path(output, "pnadc_design.RDS"))
  
  message("Dados salvos em:", file.path(output, "pnadc_design.RDS"))
}
