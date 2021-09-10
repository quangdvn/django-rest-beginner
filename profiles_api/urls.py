from django.urls import path, include
# from rest_framework import routers
from rest_framework.routers import DefaultRouter

from . import views

router = DefaultRouter()

router.register(prefix='hello',
                viewset=views.HelloViewSet,
                basename='hello')

router.register(prefix='profile',
                viewset=views.UserProfileViewSet,
                basename='user-profile')

router.register(prefix='feed',
                viewset=views.UserProfileFeedViewSet,
                basename='feed')

urlpatterns = [
    path(route='hello',
         view=views.HelloApiView.as_view(),
         name='hello'),
    path(route='login',
         view=views.UserLoginApiView.as_view(),
         name='login'),
    path(route='',
         view=include(router.urls))
]
