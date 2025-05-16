import pytest
from Calculator.engine import Calculadora

@pytest.fixture
def calc():
    return Calculadora()

def test_soma(calc):
    assert calc.somar(12, 8) == 20
