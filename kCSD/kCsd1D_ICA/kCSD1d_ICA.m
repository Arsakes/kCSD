classdef kCSD1d_ICA < kCSD1d
    %----------------------------------------------------------------------
    properties
        ICA_data
    end
    %----------------------------------------------------------------------
    %inheriting class constructor
    methods
        function k = kCSD1d_ICA(varargin)
            k = k@kCSD1d(varargin{:});
        end
        
        %----------------------------ICA FUNCTIONS-------------------------
        function ICA_preprocessing(k)
            k.ICA_data = ICA_preprocessing(k.csdEst);
        end
        
        function get_neig(k, proc)
            neig = 0;
            act_proc = 0;
            while act_proc<proc
                neig = neig + 1;
                d_small = diag(k.ICA_data.D);
                d_small = d_small(1:neig);
                d_big = diag(k.ICA_data.D);
                act_proc = sum(d_small)/sum(d_big);
            end;
            k.ICA_data.neig = neig;
        end
        
        function calc_ica(k, varargin)
            %k.get_neig(0.99);
            %varargin{end+1}='neig';
            %varargin{end+1}=k.ICA_data.neig;
            [S_components, T_components, S, T] = stica_stone(k, varargin);
            k.ICA_data.S_components = S_components;
            k.ICA_data.T_components = T_components;
            k.ICA_data.Scp = S';
            k.ICA_data.Tcp = T';
            k.ICA_data.arglist = varargin;
        end
    end
end


