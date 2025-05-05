import pytest
from django.test import TestCase
from django.conf import settings

@pytest.mark.django_db
def test_database_config():
    """Prueba de configuración de base de datos con pytest"""
    assert 'default' in settings.DATABASES
    assert settings.DATABASES['default']['ENGINE'] == 'django.db.backends.sqlite3'

class DjangoConfigTest(TestCase):
    def test_settings_configured(self):
        """Prueba de configuración Django con TestCase"""
        self.assertTrue(settings.configured)
        self.assertEqual(settings.DATABASES['default']['ENGINE'],
                        'django.db.backends.sqlite3')
