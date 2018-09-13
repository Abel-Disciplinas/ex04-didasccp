function bisseccao(f, a, b, estrategia; epsi=1e-6, max_iter=10_000)
    fa=f(a)
    fb=f(b)
    if estrategia == :bisseccao
        t=1/2
    elseif estrategia == :esquerda
        t=1/10;
    elseif estrategia == :direita
        t = 9/10
    elseif estrategia == :aleatorio
        t= rand()
    elseif estrategia == :falsa_posicao
        t= fb/(fb-fa)
    end
    i=1;
    c= a*t + b*(1-t);
    fc=f(c)
    while abs(fc)>epsi + epsi*(abs(fb)+abs(fa)) && i < max_iter
        if fc == 0
            return c, fc, i;
        else
            if fc*fa < 0
                b=c;
            else
                a=c;
            end
        end
    fa=f(a);
    fb=f(b);
    if estrategia== :aleatorio
        t=rand();
    elseif estrategia == :falsa_posicao
        t= fb/(fb-fa);
    end
    c= a*t + b*(1-t);
    fc=f(c)
    i=i+1;
    end
return c, fc, i;
end
