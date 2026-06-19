from django.contrib import admin
from django.urls import path
from django.views.generic import RedirectView
from config.views import home

urlpatterns = [
    path("", RedirectView.as_view(url="/home/", permanent=False)),
    path("admin/", admin.site.urls),
    path("home/", home, name="home"),
    path("docs/", RedirectView.as_view(url="/home/", permanent=False)),
]
