from django.test import TestCase
from django.urls import reverse, resolve


class UrlTests(TestCase):
    def test_admin_url(self):
        """Testea la URL de admin"""
        path = reverse('admin:index')
        self.assertEqual(resolve(path).view_name, 'admin:index')

    def test_home_url(self):
        """Testea la URL home"""
        path = reverse('home')
        self.assertEqual(resolve(path).func.__name__, 'home')
