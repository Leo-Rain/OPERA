function [] = elliptical_wing_o_matic(num_panels, vecM, valALPHA, strSPACING, valDELTIME, valMAXTIME, AR)

vecN = 1;
rchord = 1;
tchord = 0.1;

syms b
A = ((pi.*rchord.*(0.5.*b))/2);

hspan = double(solve((b.^2)/A == AR, b))./2;

left = [0 0];
right = [0 hspan];

% y = linspace(left(2), right(2), num_panels);
y = (((1 - (cos(linspace(pi/2,0,num_panels)))))-1).*-hspan;
chord = sqrt( (rchord.^2).*(1 - ((y.^2)./(hspan.^2))));
chord(end) = tchord;

x = (rchord + left(1)) - chord;

y = [-flip(y(2:end)) y]+hspan;
x = [flip(x(2:end)) x];
chord = [flip(chord(2:end)) chord];

str = sprintf('OPERA INPUT FILE\nALL UNITS IN SI\n\nANALYSIS PARAMETERS\n\nAnalysis Type:	 	strATYPE = 3D\nLifting Surface:	strA2TYPE = THIN\nSteady or Unsteady:	strA3TYPE = STEADY\n\nChordwise Spacing:	strSPACING = %s\n\nMaximum Timesteps: 		valMAXTIME = %d\nTimestep Size: 			valDELTIME = %0.2f\nRelaxed or Fixed Wake: 	strRELAX = FIXED\n\nAngles of Attack: 		seqALPHA = %0.2f\nAngles of Sideslip: 	seqBETA = 0\n\nGEOMETRY\n\nNo. of panels:	valPANELS =	%d\n\nDefines leading edge of wing, all measured in metres:\nKeep vecM the same for all panels on a wing.',strSPACING, valMAXTIME, valDELTIME, valALPHA, 2.*(num_panels-1));
for i = 1:(num_panels-1).*2
    panels{i} = sprintf('\nPanel #:%d.\nNumber of spanwise elements:	vecN 		= %d.\nNumber of chordwise elements: 	vecM 		= %d.\nSymmetry about YZ Plane:		strSYM 		= NO\nTrailing edge:					strTE 		= YES\nLeading edge:					strLE       = YES\nxleft		yleft		zleft		chord		epsilon	 	airfoil\n', i, vecN, vecM);
    goem = sprintf('%0.5f\t%0.5f\t0\t%0.5f\t0\tNACA 0015\n%0.5f\t%0.5f\t0\t%0.5f\t0\tNACA 0015\n\n',x(i),y(i),chord(i),x(i+1),y(i+1),chord(i+1));
    panels{i} = [panels{i} goem];
    
end

stuff = strjoin(convertCharsToStrings([str panels]));

fid = fopen('G:\GIT\opera\inputs\ellipse.dat','wt');
fprintf(fid, stuff);
fclose(fid);

end