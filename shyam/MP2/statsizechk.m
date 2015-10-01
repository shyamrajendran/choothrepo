
function [err, commonSize, numElements] = statsizechk(nparams,varargin)
try
    tmp = 0;
    for argnum = 1:nparams
        tmp = tmp + varargin{argnum};
    end
    if nargin > nparams+1
        tmp = tmp + zeros(varargin{nparams+1:end});
    end
    err = 0;
    commonSize = size(tmp);
    numElements = numel(tmp);

catch
    err = 1;
    commonSize = [];
    numElements = 0;
end
end