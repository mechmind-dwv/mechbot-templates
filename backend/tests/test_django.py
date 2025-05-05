from django.test import TestCase
from django.conf import settings

class DjangoConfigTest(TestCase):
    def test_settings_configured(self):
        """Verifica que Django está configurado correctamente"""
        self.assertTrue(settings.configured)
        self.assertEqual(settings.DATABASES['default']['ENGINE'], 
                        'django.db.backends.sqlite3')
