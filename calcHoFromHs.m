function [Ho, Lo] = calcHoFromHs(Hs,Tp,obsDepth)
% calcHoFromHs.m
% Reverse shoal waves from observation location to deep water.
% Inputs
% Hs    Significant wave height at the observation location
% Tp     Wave period
% obsDepth  Depth of observations


% calculate wavenumber
for ii = 1:length(Tp)
    [k(ii)] = dispersionSolver(2.*pi./Tp(ii), obsDepth(ii));
end
k = k';

% wavelength and group speed at wavemaker
LWaveMaker = 2.*pi./k;
CgWaveMaker = LWaveMaker./Tp.*1/2.*(1 + 2.*k.*obsDepth./(sinh(2.*k.*obsDepth)));

% deep water group speed
Co = 9.81./2/pi.*Tp;
Lo = 9.81./2./pi.*Tp.^2;

% reverse shoal wave height at observation location to deep water
Ho = Hs.*sqrt(2.*CgWaveMaker./Co);
