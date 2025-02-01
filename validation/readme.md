Nesta pasta estão os códigos utilizados para a criação dos resultados de validação dos filtros estocásticos aplicados para a estimação de parâmetros utilizando as medidas simuladas numericamente. 

`comp_Q_R_sim.m`: Função que retorna as matrizes de covariância associadas com os modelos e com as medidas que são utilizadas no processo de filtragem estocástica. 

Validamos a metodologia tanto usando a taxa de contágio definida pela função cosseno (`cos`), quando são estimados dois parâmetros por regional, quanto usando a taxa de contágio que utiliza a série temporal da temperatura média (`mord`). Por essa razão nessa pasta há arquivos duplicados com a nome `cos` ou `mord` no final que se referem a qual taxa de contágio foi utilizada no modelo. 

`generate_noise_samples_{taxa}.m`: Código para aplicar o modelo, adicionar ruído na série de medidas e salvar; 

`fitro_fp_fn_{taxa}.m`: Aplica o FP para estimação das medidas geradas por `generate_noise_samples_{taxa}.m`;

`fitro_ekf_fn_{taxa}.m`: Aplica o EnKF para estimação das medidadas geradas por `generate_noise_samples_{taxa}.m`.

`comp_estimates_{taxa}.m`: Carrega as estimativas do filtro, gera as figuras e calcula o RMSE entre eles e as medidas.   