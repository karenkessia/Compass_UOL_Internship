import pytest
from Calculator.engine import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

def test_soma(calc):
    assert calc.somar(12, 8) == 20

def test_subtracao(calc):
    assert calc.subtrair(50, 35) == 15

def test_multiplicacao(calc):
    assert calc.multiplicar(4, 6) == 24

def test_divisao(calc):
     assert calc.dividir(100, 5) == 20

def test_divisao_por_zero(calc):
    with pytest.raises(ValueError):
        calc.dividir(20, 0)

def test_media(calc):
    assert calc.media(10, 30) == 20

def test_eh_par_true(calc):
    assert calc.eh_par(14) is True

def test_eh_par_false(calc):
    assert calc.eh_par(15) is False


