n = [10 10^2 10^3 10^4 10^5 10^6 10^7 10^8];

p = zeros(1,numel(n));

for i=1:1:8
   k = rand(1,n(i));
   p(i) = numel(find(k>0.5))/n(i);
end

semilogx(n,p,"o")
