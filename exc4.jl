# funções teste:

function funcao1(x)
  if x<=10.0^(-3)
    return 2000*x -1;
  else
    return 1;
  end
end

function funcao2(x)
  return cos(x^10)
end

function funcao3(x)
    if x>=0
        return sqrt(x) -1
    end
end

#bissecção:

function bissecao(f, a, b, estrategia; epsi=1e-6, max_iter=10_000)
    fa=f(a)
    fb=f(b)
    if estrategia == :bissecao
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

#programa pra avaliar a eficiência do método aleatório (média em 3000 aplicações do método)

function avaliarand(f,a,b)
    soma=0
    j=0
    for i=1:3000
        u=bissecao(f,a,b,:aleatorio)[3]
        if a>=9999
            j=j+1
        end
        soma = soma+u
    end
    return soma/3000
    # faz a media, mas penalizando de alguma maneira quando o método falha
end

# comparando os métodos

v=[:bissecao,:esquerda,:direita,:falsa_posicao,:aleatorio]

function compara(f, a, b, v)
    efi=zeros(5)
    for i=1:5
        if v[i] != :aleatorio
            efi[i]= bissecao(f,a,b,v[i])[3]
        else
            efi[i]= avaliarand(f,a,b)
        end 
    end
    return efi
end

efi=zeros(5,3)
efi[:,1] = compara(funcao1,0,250,v)
efi[:,2] = compara(funcao2,0,(101pi)^(1/10),v)
efi[:,3] = compara(funcao3,0,1000,v)

media=zeros(5,1)

for i=1:5
    media[i]=0;
    for j=1:3
        media[i]=media[i]+efi[i,j]
    end
    media[i]=media[i]/3
end

indmenor=1
menor=media[1]
for i=1:5
    if media[i]<menor
        indmenor=i
        menor = media[i]
    end
end
melhor=v[indmenor]

println("o melhor é $melhor")