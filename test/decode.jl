using Test
using GeoIP

decode(x) = hex2bytes(x) |> GeoIP.MaxMindDB.decode

@testset "Boolean Decoding" begin
    @test decode("0007") == false
    @test decode("0107") == true
end

@testset "Float64 Decoding" begin
    @test decode("680000000000000000") == 0.0
    @test decode("683FE0000000000000") == 0.5
    @test decode("68400921FB54442EEA") == 3.14159265359
    @test decode("68405EC00000000000") == 123.0
    @test decode("6841D000000007F8F4") == 1073741824.12457
    @test decode("68BFE0000000000000") == -0.5
    @test decode("68C00921FB54442EEA") == -3.14159265359
    @test decode("68C1D000000007F8F4") == -1073741824.12457
end

@testset "Float32 Decoding" begin
    @test decode("040800000000") == Float32(0.0)
    @test decode("04083F800000") == Float32(1.0)
    @test decode("04083F8CCCCD") == Float32(1.1)
    @test decode("04084048F5C3") == Float32(3.14)
    @test decode("0408461C3FF6") == Float32(9999.99)
    @test decode("0408BF800000") == Float32(-1.0)
    @test decode("0408BF8CCCCD") == Float32(-1.1)
    @test decode("0408C048F5C3") == Float32(-3.14)
    @test decode("0408C61C3FF6") == Float32(-9999.99)
end

@testset "Int32 Decoding" begin
    @test decode("0001") == 0
    @test decode("0401ffffffff") == -1
    @test decode("0101ff") == 255
    @test decode("0401ffffff01") == -255
    @test decode("020101f4") == 500
    @test decode("0401fffffe0c") == -500
    @test decode("0201ffff") == 65535
    @test decode("0401ffff0001") == -65535
    @test decode("0301ffffff")  == 16777215
    @test decode("0401ff000001") == -16777215
    @test decode("04017fffffff") == 2147483647
    @test decode("040180000001") == -2147483647
end