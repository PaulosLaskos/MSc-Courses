function R2 = LaskosExe2Fun8(x,y)
    % Author: Laskos-Patkos Pavlos, AEM: 4388
    %This function return R squared coefficient
    R2 = 1 - sum((x-y).^2)/sum((x-mean(x)).^2);
end