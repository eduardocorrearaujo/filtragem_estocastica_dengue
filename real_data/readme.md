Nesta pasta estão os códigos utilizados para a criação dos resultados de validação dos filtros estocásticos aplicados para a estimação de parâmetros utilizando como medidas os novos casos de dengue notificados. 

`comp_Q_R_real.m`: Função que retorna as matrizes de covariância associadas com os modelos e com as medidas que são utilizadas no processo de filtragem estocástica. 

`filter_data_by_year.m`: Função para filtrar os dados de dengue, assim como de temperatura, por ano para serem usados no processo de filtragem;

`fn_enkf_cos.m`: Função que aplica o EnKF utilizando a taxa de contágio cossenoidal para o ano passado como parâmetro e retorna os estados estimados; 

`fn_enkf_mod.m`: Função que aplica o EnKF utilizando a taxa de contágio que varia com a temperatura para o ano passado como parâmetro e retorna os estados estimados; 

`fn_FP_cos.m`: Função que aplica o FP utilizando a taxa de contágio cossenoidal para o ano passado como parâmetro e retorna os estados estimados; 

`fn_FP_mord.m`: Função que aplica o FP utilizando a taxa de contágio que varia com a temperatura para o ano passado como parâmetro e retorna os estados estimados; 

`apply_filtros.m`: Script para aplicar as 4 variações de filtro e modelo propostas para os anos de 2019 a 2024 salvando em .csv as estimativas geradas.

`comp_betas.m`: Função para calcular as curvas da taxa de contágio a partir dos estados estimados na filtragem estocástica. 

`plot_beta_filters.m`: Função que plota a curva do $\beta$ estimado para cada uma das 4 variações de filtros a partir do ano e regional de saúde fornecidos como parâmetros. 

`plot_comp_filters.m`: Função que plota a curva das medidas de novos casos estimados por cada uma das 4 variações de filtros  a partir do ano e regional de saúde fornecidos como parâmetros. Essa função também calcula o RMSE entre a medida estimada e a medida real. 

`gen_figuras.m`: Função que gera os painéis com as medidas estimadas por todos os filtros e anos para cada regional de saúde. 

`make_aux_plot.m`: Função que gera outras visualizações utilizadas para validação dos filtros que não foram incluídas no TCC.

`otim_beta_cos_pars.ipynb`: notebook com o código para a estimação dos parâmetros da taxa de contágio cossenoidal utilizando otimização numérica. Os valores obtidos nesse notebook foram utilizados para inicializar os filtros.