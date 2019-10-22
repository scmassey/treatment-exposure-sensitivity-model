function [S,R] = BLImodel(t,unvaried,varied)
% function [S,R,A] = BLImodel(t,unvaried,varied)

C0  = unvaried(1);
q   = unvaried(2);
rho = unvaried(3);

mu_s= varied(1);
z = varied(2);
gamma = varied(3);

decayRate = log(2)/7;
startTx=14; %day 7
dose=0.1;
doseTime=7;
totalpulses=floor((t(end))/doseTime); % Total number of pulses
doses=ones(1,totalpulses)*dose;

int_A=zeros(size(t)); % initializing the integral of A(t) values vector
% A=zeros(size(t));

%If tx starts on day 7
for p=startTx/7:length(doses) % loop through pulses
%     A=A+doses(:,p).*2^p*exp(-decayRate.*t).*heaviside(t-7*p);
    int_A=int_A+ doses(p).*(2^p).*((exp(-decayRate*7*p)-exp(-decayRate*t))/decayRate).*heaviside(t-7*p);
end


S = C0*(1-q)*exp(rho.*t - gamma*mu_s.*int_A);
R = C0*q    *exp(rho.*t - gamma*z*mu_s.*int_A);
