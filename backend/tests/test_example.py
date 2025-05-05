### backend/tests/test_example.py
def test_example():
    """Prueba de ejemplo que siempre pasa"""
    assert 1 + 1 == 2

@pytest.mark.skip(reason="Ejemplo de prueba pendiente")
def test_future_feature():
    """Prueba pendiente de implementación"""
    pass