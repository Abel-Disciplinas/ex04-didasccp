using Plots
gr(size=(600,400))

include("bisseccao.jl")

function tests()
    funcoes = [ (funcao1, 0, 1),
                (funcao2, 0, (101pi)^(1/10)),
                (x -> x * exp(x) - 1, 0, 1) ]
    for i = 1:length(funcoes)
        (f, a, b) = funcoes[i]
        x, fx, k = bisseccao(f,a,b,:falsa_posicao)
        println("Exemplo $i")
        println("x=$x")
        println("fx=$fx")
        println("k=$k")
    end
end

tests()
