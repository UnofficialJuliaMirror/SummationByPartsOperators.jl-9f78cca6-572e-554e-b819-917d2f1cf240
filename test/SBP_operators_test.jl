using Base.Test
using SummationByPartsOperators

accuracy_test_list = (MattssonSvärdShoeybi2008(),)

# Accuracy tests of first derivative operators.
for source in accuracy_test_list, T in (Float32,Float64)
    xmin = -one(T)
    xmax = 2*one(T)
    N = 101
    der_order = 1

    acc_order = 2
    D = derivative_operator(source, der_order, acc_order, xmin, xmax, N)
    println(DevNull, D)
    println(DevNull, D.coefficients)
    x1 = grid(D)
    x0 = ones(x1)
    x2 = x1 .* x1
    x3 = x2 .* x1
    res = zeros(x0)
    @test derivative_order(D) == der_order
    @test accuracy_order(D)   == acc_order
    @test issymmetric(D) == false
    # interior and boundary
    A_mul_B!(res, D, x0)
    @test all(i->abs(res[i]) < eps(T), eachindex(res))
    A_mul_B!(res, D, x1)
    @test all(i->res[i] ≈ x0[i], eachindex(res))
    # only interior
    A_mul_B!(res, D, x2)
    @test all(i->res[i] ≈ 2*x1[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x3)
    @test any(i->!(res[i] ≈ 3*x2[i]), acc_order+1:length(res)-acc_order-1)
    # integration
    k=0; @test integrate(x0, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=1; @test integrate(x1, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)

    acc_order = 4
    D = derivative_operator(source, der_order, acc_order, xmin, xmax, N)
    println(DevNull, D)
    println(DevNull, D.coefficients)
    x1 = grid(D)
    x0 = ones(x1)
    x2 = x1 .* x1
    x3 = x2 .* x1
    x4 = x2 .* x2
    x5 = x2 .* x3
    x6 = x3 .* x3
    x7 = x4 .* x3
    res = zeros(x0)
    @test derivative_order(D) == der_order
    @test accuracy_order(D)   == acc_order
    @test issymmetric(D) == false
    # interior and boundary
    A_mul_B!(res, D, x0)
    @test all(i->abs(res[i]) < 20*eps(T), eachindex(res))
    A_mul_B!(res, D, x1)
    @test all(i->res[i] ≈ x0[i], eachindex(res))
    A_mul_B!(res, D, x2)
    @test all(i->res[i] ≈ 2*x1[i], eachindex(res))
    # only interior
    A_mul_B!(res, D, x3)
    @test all(i->res[i] ≈ 3*x2[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x4)
    @test all(i->res[i] ≈ 4*x3[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x5)
    @test any(i->!(res[i] ≈ 5*x4[i]), acc_order+1:length(res)-acc_order-1)
    # integration
    k=0; @test integrate(x0, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=1; @test integrate(x1, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=2; @test integrate(x2, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=3; @test integrate(x3, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)

    acc_order = 6
    D = derivative_operator(source, der_order, acc_order, xmin, xmax, N)
    println(DevNull, D)
    println(DevNull, D.coefficients)
    x1 = grid(D)
    x0 = ones(x1)
    x2 = x1 .* x1
    x3 = x2 .* x1
    x4 = x2 .* x2
    x5 = x2 .* x3
    x6 = x3 .* x3
    x7 = x4 .* x3
    res = zeros(x0)
    @test derivative_order(D) == der_order
    @test accuracy_order(D)   == acc_order
    @test issymmetric(D) == false
    # interior and boundary
    A_mul_B!(res, D, x0)
    @test all(i->abs(res[i]) < 40*eps(T), eachindex(res))
    A_mul_B!(res, D, x1)
    @test all(i->res[i] ≈ x0[i], eachindex(res))
    A_mul_B!(res, D, x2)
    @test all(i->res[i] ≈ 2*x1[i], eachindex(res))
    A_mul_B!(res, D, x3)
    @test all(i->res[i] ≈ 3*x2[i], eachindex(res))
    # only interior
    A_mul_B!(res, D, x4)
    @test all(i->res[i] ≈ 4*x3[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x5)
    @test all(i->res[i] ≈ 5*x4[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x6)
    @test all(i->res[i] ≈ 6*x5[i], acc_order+1:length(res)-acc_order-1)
    # integration
    k=0; @test integrate(x0, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=1; @test integrate(x1, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=2; @test integrate(x2, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=3; @test integrate(x3, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=4; @test integrate(x4, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=5; @test integrate(x5, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=6; @test integrate(x6, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=7; @test integrate(x7, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)

    acc_order = 8
    D = derivative_operator(source, der_order, acc_order, xmin, xmax, N)
    println(DevNull, D)
    println(DevNull, D.coefficients)
    x1 = grid(D)
    x0 = ones(x1)
    x2 = x1 .* x1
    x3 = x2 .* x1
    x4 = x2 .* x2
    x5 = x2 .* x3
    x6 = x3 .* x3
    x7 = x4 .* x3
    res = zeros(x0)
    @test derivative_order(D) == der_order
    @test accuracy_order(D)   == acc_order
    @test issymmetric(D) == false
    # interior and boundary
    A_mul_B!(res, D, x0)
    @test all(i->abs(res[i]) < 2000*eps(T), eachindex(res))
    A_mul_B!(res, D, x1)
    @test all(i->isapprox(res[i], x0[i], rtol=8000*eps(T)), eachindex(res))
    A_mul_B!(res, D, x2)
    @test all(i->isapprox(res[i], 2*x1[i], rtol=8000*eps(T)), eachindex(res))
    A_mul_B!(res, D, x3)
    @test all(i->isapprox(res[i], 3*x2[i], rtol=8000*eps(T)), eachindex(res))
    A_mul_B!(res, D, x4)
    @test all(i->res[i] ≈ 4*x3[i], acc_order+1:length(res)-acc_order-1)
    # only interior
    A_mul_B!(res, D, x5)
    @test all(i->res[i] ≈ 5*x4[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x6)
    @test all(i->isapprox(res[i], 6*x5[i], rtol=8000*eps(T)), acc_order+1:length(res)-acc_order-1)
    # integration
    k=0; @test integrate(x0, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=1; @test integrate(x1, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=2; @test integrate(x2, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=3; @test integrate(x3, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=4; @test integrate(x4, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=5; @test integrate(x5, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=6; @test integrate(x6, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
    k=7; @test integrate(x7, D) ≈ (xmax^(k+1)-(xmin)^(k+1))/(k+1)
end

# Accuracy tests of second derivative operators.
for source in accuracy_test_list, T in (Float32,Float64)
    xmin = -one(T)
    xmax = 2*one(T)
    N = 101
    der_order = 2

    acc_order = 2
    D = derivative_operator(source, der_order, acc_order, xmin, xmax, N)
    println(DevNull, D)
    println(DevNull, D.coefficients)
    x1 = grid(D)
    x0 = ones(x1)
    x2 = x1 .* x1
    x3 = x2 .* x1
    x4 = x2 .* x2
    res = zeros(x0)
    @test derivative_order(D) == der_order
    @test accuracy_order(D)   == acc_order
    @test issymmetric(D) == false
    # interior and boundary
    A_mul_B!(res, D, x0)
    @test all(i->abs(res[i]) < eps(T), eachindex(res))
    A_mul_B!(res, D, x1)
    @test all(i->abs(res[i]) < 5000*eps(T), eachindex(res))
    # only interior
    A_mul_B!(res, D, x2)
    @test all(i->res[i] ≈ 2*x0[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x3)
    @test all(i->res[i] ≈ 6*x1[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x4)
    @test any(i->!(res[i] ≈ 12*x2[i]), acc_order+1:length(res)-acc_order-1)
    # boundary derivative
    @test abs(derivative_left( D, x0, Val{1}())) < eps(T)
    @test abs(derivative_right(D, x0, Val{1}())) < eps(T)
    @test derivative_left( D, x1, Val{1}()) ≈ one(T)
    @test derivative_right(D, x1, Val{1}()) ≈ one(T)
    @test derivative_left( D, x2, Val{1}()) ≈ 2xmin
    @test derivative_right(D, x2, Val{1}()) ≈ 2xmax

    acc_order = 4
    D = derivative_operator(source, der_order, acc_order, xmin, xmax, N)
    println(DevNull, D)
    println(DevNull, D.coefficients)
    x1 = grid(D)
    x0 = ones(x1)
    x2 = x1 .* x1
    x3 = x2 .* x1
    x4 = x2 .* x2
    x5 = x2 .* x3
    x6 = x3 .* x3
    x7 = x4 .* x3
    res = zeros(x0)
    @test derivative_order(D) == der_order
    @test accuracy_order(D)   == acc_order
    @test issymmetric(D) == false
    # interior and boundary
    A_mul_B!(res, D, x0)
    @test all(i->abs(res[i]) < 1000*eps(T), eachindex(res))
    A_mul_B!(res, D, x1)
    @test all(i->abs(res[i]) < 10000*eps(T), eachindex(res))
    A_mul_B!(res, D, x2)
    @test all(i->isapprox(res[i], 2*x0[i], rtol=5000*eps(T)), eachindex(res))
    # only interior
    A_mul_B!(res, D, x3)
    @test all(i->res[i] ≈ 6*x1[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x4)
    @test all(i->res[i] ≈ 12*x2[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x5)
    @test all(i->res[i] ≈ 20*x3[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x6)
    @test any(i->!(res[i] ≈ 30*x4[i]), acc_order+1:length(res)-acc_order-1)
    # boundary derivative
    @test abs(derivative_left( D, x0, Val{1}())) < 10*eps(T)
    @test abs(derivative_right(D, x0, Val{1}())) < 10*eps(T)
    @test derivative_left( D, x1, Val{1}()) ≈ one(T)
    @test derivative_right(D, x1, Val{1}()) ≈ one(T)
    @test derivative_left( D, x2, Val{1}()) ≈ 2xmin
    @test derivative_right(D, x2, Val{1}()) ≈ 2xmax
    @test derivative_left( D, x3, Val{1}()) ≈ 3xmin^2
    @test derivative_right(D, x3, Val{1}()) ≈ 3xmax^2

    acc_order = 6
    D = derivative_operator(source, der_order, acc_order, xmin, xmax, N)
    println(DevNull, D)
    println(DevNull, D.coefficients)
    x1 = grid(D)
    x0 = ones(x1)
    x2 = x1 .* x1
    x3 = x2 .* x1
    x4 = x2 .* x2
    x5 = x2 .* x3
    x6 = x3 .* x3
    x7 = x4 .* x3
    res = zeros(x0)
    @test derivative_order(D) == der_order
    @test accuracy_order(D)   == acc_order
    @test issymmetric(D) == false
    # interior and boundary
    A_mul_B!(res, D, x0)
    @test all(i->abs(res[i]) < 10000*eps(T), eachindex(res))
    A_mul_B!(res, D, x1)
    @test all(i->abs(res[i]) < 20000*eps(T), eachindex(res))
    A_mul_B!(res, D, x2)
    @test all(i->isapprox(res[i], 2*x0[i], rtol=10000*eps(res[i])), eachindex(res))
    A_mul_B!(res, D, x3)
    @test all(i->isapprox(res[i], 6*x1[i], rtol=5000*eps(res[i])), eachindex(res))
    # only interior
    A_mul_B!(res, D, x4)
    @test all(i->res[i] ≈ 12*x2[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x5)
    @test all(i->res[i] ≈ 20*x3[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x6)
    @test all(i->res[i] ≈ 30*x4[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x7)
    @test all(i->res[i] ≈ 42*x5[i], acc_order+1:length(res)-acc_order-1)
    # boundary derivative
    @test abs(derivative_left( D, x0, Val{1}())) < 40*eps(T)
    @test abs(derivative_right(D, x0, Val{1}())) < 40*eps(T)
    @test derivative_left( D, x1, Val{1}()) ≈ one(T)
    @test derivative_right(D, x1, Val{1}()) ≈ one(T)
    @test derivative_left( D, x2, Val{1}()) ≈ 2xmin
    @test derivative_right(D, x2, Val{1}()) ≈ 2xmax
    @test derivative_left( D, x3, Val{1}()) ≈ 3xmin^2
    @test derivative_right(D, x3, Val{1}()) ≈ 3xmax^2
    @test derivative_left( D, x4, Val{1}()) ≈ 4xmin^3
    @test derivative_right(D, x4, Val{1}()) ≈ 4xmax^3

    acc_order = 8
    D = derivative_operator(source, der_order, acc_order, xmin, xmax, N)
    println(DevNull, D)
    println(DevNull, D.coefficients)
    x1 = grid(D)
    x0 = ones(x1)
    x2 = x1 .* x1
    x3 = x2 .* x1
    x4 = x2 .* x2
    x5 = x2 .* x3
    x6 = x3 .* x3
    x7 = x4 .* x3
    x8 = x4 .* x4
    res = zeros(x0)
    @test derivative_order(D) == der_order
    @test accuracy_order(D)   == acc_order
    @test issymmetric(D) == false
    # interior and boundary
    A_mul_B!(res, D, x0)
    @test all(i->abs(res[i]) < 10000*eps(T), eachindex(res))
    A_mul_B!(res, D, x1)
    @test all(i->abs(res[i]) < 20000*eps(T), eachindex(res))
    A_mul_B!(res, D, x2)
    @test all(i->isapprox(res[i], 2*x0[i], rtol=40000*eps(T)), eachindex(res))
    A_mul_B!(res, D, x3)
    @test all(i->isapprox(res[i], 6*x1[i], rtol=20000*eps(T)), eachindex(res))
    A_mul_B!(res, D, x4)
    @test all(i->res[i] ≈ 12*x2[i], acc_order+1:length(res)-acc_order-1)
    # only interior
    A_mul_B!(res, D, x5)
    @test all(i->res[i] ≈ 20*x3[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x6)
    @test all(i->isapprox(res[i], 30*x4[i], rtol=10000*eps(T)), acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x7)
    @test all(i->res[i] ≈ 42*x5[i], acc_order+1:length(res)-acc_order-1)
    A_mul_B!(res, D, x8)
    @test all(i->isapprox(res[i], 56*x6[i], rtol=20000*eps(T)), acc_order+1:length(res)-acc_order-1)
    # boundary derivative
    @test abs(derivative_left( D, x0, Val{1}())) < 40*eps(T)
    @test abs(derivative_right(D, x0, Val{1}())) < 40*eps(T)
    @test derivative_left( D, x1, Val{1}()) ≈ one(T)
    @test derivative_right(D, x1, Val{1}()) ≈ one(T)
    @test derivative_left( D, x2, Val{1}()) ≈ 2xmin
    @test derivative_right(D, x2, Val{1}()) ≈ 2xmax
    @test derivative_left( D, x3, Val{1}()) ≈ 3xmin^2
    @test derivative_right(D, x3, Val{1}()) ≈ 3xmax^2
    @test derivative_left( D, x4, Val{1}()) ≈ 4xmin^3
    @test derivative_right(D, x4, Val{1}()) ≈ 4xmax^3
    @test derivative_left( D, x5, Val{1}()) ≈ 5xmin^4
    @test derivative_right(D, x5, Val{1}()) ≈ 5xmax^4
end


# Compare mul! with β=0 and mul! without β.
for T in (Float32, Float64), acc_order in (2,4,6,8)
    xmin = zero(T)
    xmax = 5*one(T)
    N = 51
    source = MattssonSvärdShoeybi2008()
    D_serial = derivative_operator(source, 1, acc_order, xmin, xmax, N)
    D_threads= derivative_operator(source, 1, acc_order, xmin, xmax, N, Val{:threads}())
    x = grid(D_serial)
    u = x.^5
    dest1 = zeros(u)
    dest2 = zeros(u)

    mul!(dest1, D_serial, u, one(T), zero(T))
    mul!(dest2, D_serial, u, one(T))
    @test all(i->dest1[i] ≈ dest2[i], eachindex(u))
    mul!(dest1, D_threads, u, one(T), zero(T))
    mul!(dest2, D_threads, u, one(T))
    @test all(i->dest1[i] ≈ dest2[i], eachindex(u))
    dest3 = D_serial*u
    @test all(i->dest1[i] ≈ dest3[i], eachindex(u))
end