function x = tabell(bana)
x = bana(1,[2 4]);
n = 1;       %Target value
m = 1;       %Index
while n<=20
    if bana(m,2)-n >= 0;
        %t = LinPol(bana_high(m-1,1),bana_high(m,1),bana_high(m-1,2),bana_high(m,2),n)
        y = herm(n, bana(m-1,2), bana(m,2), bana(m-1,4), bana(m,4), bana(m-1,5), bana(m,5));
        x = [x; n y];
        n = n+1;
        m = m+1;
    else
        m = m+1;
    end
end