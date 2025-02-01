### Descrição do conteúdo da pasta

#### Arquivos

* `regional_to_muni.csv.gz`: Tabela que relaciona os municípios com suas regionais e macroregionais de saúde (disponibilizados pelo Infodengue).

Tabelas IBGE:
* `area_muni_2023.xls`: Tebela com as áreas em Km2 de cada município do Brasil, acessado em: https://www.ibge.gov.br/geociencias/organizacao-do-territorio/estrutura-territorial/15761-areas-dos-municipios.html;
* `POP22.xlsx`: Tabela com a população de cada município do Brasil segundo o censo de 2022, acessado em: https://www.ibge.gov.br/estatisticas/sociais/trabalho/22827-censo-demografi;
* `pop_22_region.csv`: Tabela com as populações das regionais de saúde da macrorregional oeste. Foi calculada no notebook: `organize_pop_and_dists.ipynb`; 

Séries temporais: 
* `PR_dengue.csv`: Série temporal (escala semanal) com os casos notificados (`casos`), casos notitificados estimados (`casos_est`) pela data de início dos primeiros sintomas (`data_iniSE`) para cada município do Paraná. Acessados pelo API do [Mosqlimate](https://api.mosqlimate.org/), que consulta o infodengue;

* `PR_clima.csv`: Série temporal (escala diária) com a temperatura média de cada cidade do Paraná obtida a partir pela plataforma Copernicus. Os dados foram obtidos a partir da API do [Mosqlimate](https://api.mosqlimate.org/) ; 

* `susp_data_regions_rw.csv`:  Série temporal dos novos casos notificados agregados pela regional de saúde. Foi aplicada uma média móvel de 3 semanas para suavização dos dados. Essa tabela foi obtida usando a tabela `PR_dengue.csv` e o código `organize_time_series.ipynb`;

* `clima_regions_rw.csv`: Série temporal da temperatura média agregada pela regional de saúde. Foi aplicada uma média móvel de 3 semanas para suavização dos dados. Essa tabela foi obtida usando a tabela `PR_clima.csv` e o código `organize_time_series.ipynb`; 

Shapefile: 
* `BR_municipios.gpkg`: Shapefile dos municípios do Brasil disponibilizados pelo Infodengue; (posso achar isso no IBGE?) 
* `shapefile_region.gpkg`: Shapefile das regionais de saúde obtidas a partir do shapefile dos municípios;
 
Distância entre os munícipios: 
* `dist.csv`: Tabela com a distância, segundo o google maps, do centroide das regionais de saúde;
* `dist_table_model.csv`: Tabela com a distância, segundo o google maps, do centroide das regionais de saúde de Cascavel, Toledo e Foz do Iguaçu que serão utilizados no modelo;


#### Códigos 

* `organize_time_series.ipynb`: Notebook para agregar as séries temporais que serão utilizadas no processo de filtragem estocástica.; 
* `organize_pop_and_dists.ipynb`: Tratamento dos dados para obter as informações da Tabels 2 do TCC; 
* `plot_figures_8_e_9.ipynb`: Código para gerar as Figuras 8 e 9 do TCC. 