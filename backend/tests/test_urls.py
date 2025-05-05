from django.test import TestCase
from django.urls import reverse, resolve


class UrlTests(TestCase):
    def test_home_url(self):
        path = reverse("home")
        assert resolve(path).view_name == "home"
