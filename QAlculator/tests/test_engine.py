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