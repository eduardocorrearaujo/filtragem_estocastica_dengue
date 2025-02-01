% Parâmetros utilizados no modelo em todas as simulações:

TAU = 1; 
THETA = 1.0;
ALPHA = 2; 
EPSILON = comp_epsilon(THETA, ALPHA);
N  = [581990, 445448, 425785]; 
GAMMA = 0.875;
CAPA = 1/(75.5*(365/7)); 


% Parâmetros utilizados para os filtros estocásticos da pasta`validation`
T0 = 1;
TFINAL = 52;
TEMP = T0:TFINAL;

I0 = [10, 0, 0];

BETAS_0 = [0.7, 0.7, 0.7] ; 
eta_ =  0.7;
ETAS = [eta_,eta_,eta_]; 
zita_ =  0.16;
ZITAS = [zita_, zita_, zita_]; 
phi_ = -6.01;
PHIS = [phi_, phi_, phi_];  

a_0 = 0.0012;
AS = [a_0, a_0, a_0] ; 
b_ = 14;
BS = [b_,b_,b_]; 
c_ = 36;
CS = [c_,c_,c_];

A_0_SIM = [0.001, 0.001, 0.001];

BETA_0_SIM  = [0.8, 0.8, 0.8]; 

ETA_0_SIM = [0.8, 0.8, 0.8];

% Parâmetros compartilhados por todos os filtros 
VAR_NOISE_COS = [(0.02)^2, (0.02)^2, (0.02)^2, (0.02)^2, (0.02)^2, (0.02)^2]; 
VAR_NOISE_MORD = [(0.0002)^2, (0.0002)^2, (0.0002)^2];

P_K_K_COS = diag([1000, 1000, 1000 100, 100, 100, 100, 100, 100, (0.02)^2 , (0.02)^2, (0.02)^2, (0.02)^2, (0.02)^2, (0.02)^2]);

P_K_K_MORD = diag([1000, 1000, 1000 100, 100, 100, 100, 100, 100, (0.0002)^2,  (0.0002)^2,  (0.0002)^2]);

NENS = 500;

NPARTS = 5000;

NTHR = 2500; 

% Parâmetros utilizados para os filtros estocásticos da pasta `real_data`
A_0_REAL = [0.001, 0.001, 0.001];

BETA_0_REAL  = [0.64, 0.85, 0.76]; 

ETA_0_REAL = [0.54, 0.46, 0.67];
