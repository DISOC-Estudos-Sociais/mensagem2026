baixa_dados <- function(year = 2024, output = "data/clean_data"){
  
  # Carregar pacotes necessários
  if (!require("PNADcIBGE")) stop("Pacote PNADcIBGE não instalado. Use: install.packages('PNADcIBGE')")
  if (!require("readr")) stop("Pacote readr não instalado. Use: install.packages('readr')")
  
  message(sprintf("Baixando dados da PNADC %d - Entrevista 1", year))
  dados <- PNADcIBGE::get_pnadc(year, interview = 1)
  
  saveRDS(dados, file = file.path(output, sprintf("pnadc_design_%d.RDS", year)))
  
  message("Dados salvos em:", file.path(output, sprintf("pnadc_design_%d.RDS", year)))
}
