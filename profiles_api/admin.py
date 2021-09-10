from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import ProfileFeedItem, UserProfile


admin.site.register(UserProfile)
admin.site.register(ProfileFeedItem)
