function [matWELST, matWVLST, matWDVE, valWNELE, matWEATT, matWEIDX, matWPLEX, matWDVECT, matWCENTER, matWCOEFF, matWROTANG, vecWLE, vecWTE, ...
    vecWLEDVE, vecWTEDVE, vecWDVECIRC, vecWSYM, vecWSYMDVE, vecWDVESYM, matWVGRID, vecWOTE, ...
    vecWOTEDVE, matWEGRID, matWE2GRID, vecWVMU, vecWEMU, vecWDVEFLIP] = fcnCREATEWAKE2(valTIMESTEP, strATYPE, matNEWWAKE, matCOEFF, valWSIZE, ...
    vecTEDVE, matCENTER, matROTANG, matWCOEFF, matWPLEX, vecWDVECIRC, vecWSYMDVE, vecSYMDVE, vecWDVESYM, vecDVESYM, ...
    vecWSYM, matWVGRID, matWVLST, matWELST, matWEGRID, vecWVMU, vecWEMU, vecWDVEFLIP, matWCENTER, matWROTANG, matWDVECT, ...
    matWDVE, matWEIDX, vecWLEDVE, matWEATT)

WDVEFLIP = [false(size(matNEWWAKE,1)./2, 1); true(size(matNEWWAKE,1)./2, 1)];

valWNELE = valTIMESTEP*valWSIZE*2;
[~, WELST, WVLST, WDVE, ~, WEATT, WEIDX, WPLEX, WDVECT, ~, ~, WCENTER, WROTANG] = fcnTRIANG(matNEWWAKE, WDVEFLIP);

if valTIMESTEP > 1
    [idx1,b1] = ismember(WVLST, matWVLST, 'rows');
    
    % WDVE, WELST
    idx_WDVE = false(size(WDVE));
    idx_WELST = false(size(WELST));
    new = find(idx1);
    old = b1(idx1);
    for j = 1:length(new)
        tmp_DVE = WDVE == new(j);
        WDVE(tmp_DVE) = old(j);
        idx_WDVE = idx_WDVE | tmp_DVE;
        
        tmp_WELST = WELST == new(j);
        WELST(tmp_WELST) = old(j);
        idx_WELST = idx_WELST | tmp_WELST;
    end
    
    old = unique(WDVE(~idx_WDVE));
    new_vt = [(size(matWVLST,1)+1):size(matWVLST,1) + length(new)];
    for j = 1:length(old)
        tmp_DVE = WDVE == old(j) & ~idx_WDVE;
        WDVE(tmp_DVE) = new_vt(j);
        
        tmp_WELST = WELST == old(j) & ~idx_WELST;
        WELST(tmp_WELST) = new_vt(j);
    end
    
    matWDVE = cat(1, matWDVE, WDVE);
    matWVLST = cat(1, matWVLST, WVLST(~idx1, :));
    
    % WEIDX
    [idx2,b2] = ismember(WELST, matWELST, 'rows');
    idx_WEIDX = false(size(WEIDX));
    new = find(idx2);
    old = b2(idx2);
    for j = 1:length(new)
        tmp_WEIDX = WEIDX == new(j);
        WEIDX(tmp_WEIDX) = old(j);
        idx_WEIDX = idx_WEIDX | tmp_WEIDX;
    end
    
    old = unique(WEIDX(~idx_WEIDX));
    new = [(size(matWELST,1)+1):size(matWELST,1) + length(old)]';
    for j = 1:length(old)
        tmp_WEIDX = WEIDX == old(j) & ~idx_WEIDX;
        WEIDX(tmp_WEIDX) = new(j);
    end
    
    matWEIDX = cat(1, matWEIDX, WEIDX);
    matWELST = cat(1, matWELST, WELST(~idx2, :));
else
    matWDVE = WDVE;
    matWVLST = WVLST;
    matWELST = WELST;
    matWEIDX = WEIDX;
end

matWCENTER = cat(1, matWCENTER, WCENTER);
matWROTANG = cat(1, matWROTANG, WROTANG);
matWDVECT = cat(1, matWDVECT, WDVECT);
matWPLEX = cat(3, matWPLEX, WPLEX);
vecWDVEFLIP = cat(1, vecWDVEFLIP, WDVEFLIP);

% WEATT needs special care when valTIMESTEP > 1
matWEATT = cat(1, matWEATT, WEATT);

% Wake leading and trailing edge DVE identifications
if valTIMESTEP > 1
    old_le_dve = vecWLEDVE;
end
vecWLEDVE = [(valWNELE - 2*valWSIZE + 1):(valWNELE - valWSIZE)]'; % Post trailing edge row of wake HDVEs
vecWTEDVE = [(valWNELE - valWSIZE + 1):valWNELE]';

if valTIMESTEP > 1
    matWEATT(matWEIDX(vecWLEDVE,3),:) = sort(matWEATT(matWEIDX(vecWLEDVE,3),:), 2);
    matWEATT(matWEIDX(vecWLEDVE,1),1) = old_le_dve;
end

% Wake leading and trailing edge DVE identifications
vecWLE = matWEIDX(vecWLEDVE,2);
vecWTE = matWEIDX(vecWTEDVE,3);
vecWOTEDVE = [(1:valWSIZE) + valWSIZE]';
vecWOTE = matWEIDX(vecWOTEDVE, 3);

% Symmetry
if any(vecDVESYM)
    vecWDVESYM = [vecWDVESYM; repmat(vecDVESYM(vecTEDVE), 2, 1)];
end
idx = ismember(vecTEDVE, vecSYMDVE);
vecWSYMDVE = [vecWSYMDVE; vecWLEDVE(idx)];
vecWSYM = [vecWSYM; matWEIDX(vecWSYMDVE, 1)];

%% Wake circulation grid points
WVMU = zeros(size(matWVLST,1),1);
WEMU = zeros(size(matWELST,1),1);

if valTIMESTEP == 1
    matWVGRID = [unique(reshape(matWDVE(vecWLEDVE,2:3)',1,[],1)','stable')'; unique(reshape(matWDVE(vecWTEDVE,3:-2:1)',1,[],1)','stable')'];
    matWEGRID = [vecWLE matWEIDX(vecWLEDVE,3) vecWTE]';
    vecWVMU = WVMU;
    vecWEMU = WEMU;
else
    matWVGRID = [unique(reshape(matWDVE(vecWLEDVE,2:3)',1,[],1)','stable')'; matWVGRID];
    matWEGRID = [[vecWLE matWEIDX(vecWLEDVE,3)]'; matWEGRID];
    
    old_WVMU = vecWVMU;
    old_WEMU = vecWEMU;
    vecWVMU = zeros(size(matWVLST,1),1);
    vecWEMU = zeros(size(matWELST,1),1);
    
    if strcmpi(strATYPE{3},'UNSTEADY')
        vecWVMU(vmap) = old_WVMU;
        vecWEMU(emap) = old_WEMU;
    end
end

tmp = permute(cat(3, matWVGRID(1:end-1,:), matWVGRID(2:end,:)), [1 3 2]);
tmp = reshape(permute(tmp, [2 1 3]), size(tmp, 2), [])';
[~,idx] = ismember(sort(tmp,2), sort(matWELST,2),'rows');
matWE2GRID = reshape(idx, valTIMESTEP, size(matWVGRID,2));

% fcnPLOTWAKE(1, gcf, matWDVE, valWNELE, matWVLST, matWELST, matWDVECT, matWCENTER, valWSIZE, 0, matWVGRID);

%% Coefficients
[vecWVMU, vecWEMU] = fcnWAKEMU(strATYPE, vecWLE, matWVGRID, matWEGRID, matWE2GRID, vecWVMU, vecWEMU, matWELST, matWVLST, vecTEDVE, matCOEFF, matCENTER, matROTANG);
matWCOEFF = fcnADJCOEFF(vecWVMU, vecWEMU, matWVLST, matWCENTER, matWROTANG, matWDVE, matWCOEFF, matWELST, matWEIDX, valWNELE);


end



