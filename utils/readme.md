### Descrição do conteúdo da pasta

`variables.m`: Conjuntos de valores constantes utilizados no modelo final, assim como parâmetros compartilhados entre os dois filtros tanto para a validação com dados simulados quanto para a aplicação nos dados reais. 

`rmse.m`: Função para o cálculdo erro RMSE entre dois vetores. É utilizada para comparar a performance entre os dois filtros estocásticos propostos. 

#### Modelo MSEI
`msei.m`: Implementação do modelo discreto proposto (equação 15 do capítulo 2). 
`model_meta_pop.m`: Aplica o modelo para obter os dados utilizados para obter os dados obtidos por meio de simulação numérica. 
`beta_cos.m`: Implementa a  equação 8 do capítulo 2 acoplada no modelo msei. 
`beta_mord.m`:Implementa a  equação 9 do capítulo 2 acoplada no modelo msei. 
`lambda_ij.m`:Calcula a força de infecção entre duas regionais usando a equação 11 do capítulo 2. 
`comp_epsilon.m`:Calcula a interação entre duas regionais utilizando a equação 14 do capítulo 2. 

#### Ensemble Kalman Filter 
`filter_ekf.m`: Implementa o algoritmo 1 do capítulo 3.
`comp_K.m`: Calcula a matriz de ganho K a partir da equação 41 do capítulo 3. 
`updatate_P.m`: Calcula a atualização da matriz de covariância P definida na linha 10 do algoritmo 1. 

#### Filtro de partículas
`filter_fp.m`: Aplica o algoritmo 4 do capítulo 3. 
`resample.m`: Aplica o algoritmo 3 do capítulo 3. 
