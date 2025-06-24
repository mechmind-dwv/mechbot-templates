from django.contrib import admin
from django.urls import path
from config.views import home  # Nota: importamos desde config.views

urlpatterns = [path("admin/", admin.site.urls), path("home/", home, name="home")]
