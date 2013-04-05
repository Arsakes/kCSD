function [nic, SKEW_PDF_s, hi_kurt_s, lo_kurt_s,...
    SKEW_PDF_t, hi_kurt_t, lo_kurt_t, mode, alpha, clustering]...
    = get_stica_stone_vars(arglist)
propertyArgIn = arglist;
while length(propertyArgIn) >= 2,
    prop = propertyArgIn{1};
    val = propertyArgIn{2};
    propertyArgIn = propertyArgIn(3:end);
    
    switch prop
        case 'SKEW_PDF_s'
            SKEW_PDF_s = val;
        case 'SKEW_PDF_t'
            SKEW_PDF_t = val;
        case 'nic'
            nic = val;       
        case 'hi_kurt_s'
            hi_kurt_s = val;
        case 'lo_kurt_s'
            lo_kurt_s = val;
        case 'hi_kurt_t'
            hi_kurt_t = val;
        case 'lo_kurt_t'
            lo_kurt_t = val;
        case 'mode'
            mode = val;
        case 'alpha'
            alpha = val;
        case 'clustering'
            clustering = val;
    end
end
 

if ~exist('mode', 'var')
%     error('specify mode (''s'', ''t'' or ''st'') ');
    mode = [];
end

if ~exist('SKEW_PDF_s', 'var')
    SKEW_PDF_s = 0;
end

if ~exist('SKEW_PDF_t', 'var')
    SKEW_PDF_t = 0;
end

if SKEW_PDF_s == 0;
    if ~exist('lo_kurt_s', 'var')
        if exist('hi_kurt_s', 'var')
            lo_kurt_s = 1:nic;
            lo_kurt_s(hi_kurt_s) = [];
        else
            error('specify ''SKEW_PDF_s'' or at least one of: ''lo_kurt_s'', ''hi_kurt_s''');
        end
    else
        hi_kurt_s = 1:nic;
        hi_kurt_s(lo_kurt_s) = []; 
    end
else
    lo_kurt_s = [];
    hi_kurt_s = [];
end;

if SKEW_PDF_t == 0;
    if ~exist('lo_kurt_t', 'var')
        if exist('hi_kurt_t', 'var')
            lo_kurt_t = 1:nic;
            lo_kurt_t(hi_kurt_t) = [];
        else
            error('specify ''SKEW_PDF_t'' or at least one of: ''lo_kurt_t'', ''hi_kurt_t''');
        end
    else
        hi_kurt_t = 1:nic;
        hi_kurt_t(lo_kurt_t) = [];
    end
    
else
    lo_kurt_t = [];
    hi_kurt_t = [];
end;

if ~exist('alpha', 'var')
    alpha = 0.5;
end;

if ~exist('clustering', 'var')
    clustering = 0;
end;
