using DelimitedFiles, Random, Plots, Measurements, Statistics

dat, hdr = readdlm("ff3_factors.csv", ',', header=true)
b = dat[:, end] / 100
s = dat[:, 2] / 100 .+ b
b, s = [1.0; cumprod(1 .+ b)], [1.0; cumprod(1 .+ s)]
n = length(b)

T = 120

ids = rand(1:n-T, 100)

function port(α, i)
    x, y = b[i:i+T], s[i:i+T]
    rm = y[end] ./ y[1:end-1]
    rf = x[end] ./ x[1:end-1]
    p = sum(α * rm + (1.0 - α) * rf)
    return p
end

p = [port(0.7, k) for k in ids]