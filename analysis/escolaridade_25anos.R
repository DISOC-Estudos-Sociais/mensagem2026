dados <- PNADcIBGE::get_pnadc(2023, topic = 2)

#saveRDS(dados, file = "data/clean_data/design_pnadc_2024_t2.RDS")

dados <- dados |> 
  srvyr::as_survey()

# Calcular os pontos de corte dos quartis
pontos_corte <- dados |>
  summarise(
    quartis = survey_quantile(VDI5008, 
                              quantiles = c(0.25, 0.5, 0.75), 
                              na.rm = TRUE)
  )

# Extrair os valores dos quartis
q25 <- pontos_corte$quartis_q25
q50 <- pontos_corte$quartis_q50
q75 <- pontos_corte$quartis_q75

# Criar a variável categórica
dados <- dados |>
  mutate(
    quartil_renda = case_when(
      VDI5008 <= q25 ~ "1º quartil",
      VDI5008 <= q50 ~ "2º quartil",
      VDI5008 <= q75 ~ "3º quartil",
      VDI5008 > q75 ~ "4º quartil",
      TRUE ~ NA_character_
    )
  )

# Criar variável numérica de anos de estudo
dados <- dados |>
  mutate(
    anos_estudo_num = case_when(
      VD3005 == "Sem instrução e menos de 1 ano de estudo" ~ 0,
      VD3005 == "1 ano de estudo" ~ 1,
      VD3005 == "2 anos de estudo" ~ 2,
      VD3005 == "3 anos de estudo" ~ 3,
      VD3005 == "4 anos de estudo" ~ 4,
      VD3005 == "5 anos de estudo" ~ 5,
      VD3005 == "6 anos de estudo" ~ 6,
      VD3005 == "7 anos de estudo" ~ 7,
      VD3005 == "8 anos de estudo" ~ 8,
      VD3005 == "9 anos de estudo" ~ 9,
      VD3005 == "10 anos de estudo" ~ 10,
      VD3005 == "11 anos de estudo" ~ 11,
      VD3005 == "12 anos de estudo" ~ 12,
      VD3005 == "13 anos de estudo" ~ 13,
      VD3005 == "14 anos de estudo" ~ 14,
      VD3005 == "15 anos de estudo" ~ 15,
      VD3005 == "16 anos ou mais de estudo" ~ 16,
      TRUE ~ NA_real_
    )
  )

# Calcular as médias por quartil
medias_por_quartil <- dados |>
  filter(V2009>=18 & V2009 <= 29) |> 
  group_by(quartil_renda) |>
  summarise(
    media_anos_estudo = survey_mean(anos_estudo_num, na.rm = TRUE)
  ) |>
  filter(quartil_renda %in% c("1º quartil", "4º quartil"))

medias_por_quartil
