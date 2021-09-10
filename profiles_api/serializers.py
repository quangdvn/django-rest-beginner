from django.db import models
from django.db.models import fields
from rest_framework import serializers

from .models import ProfileFeedItem, UserProfile


class HelloSerializer(serializers.Serializer):
    """Serialize a name field for API View"""
    name = serializers.CharField(max_length=10)


class UserProfileSerializer(serializers.ModelSerializer):
    """Serialize an user profile object"""

    class Meta:
        model = UserProfile
        fields = ('id', 'email', 'name', 'password')
        extra_kwargs = {
            'password': {
                'write_only': True,  # Only use to create or update
                'style': {
                    'input_type': 'password'
                }
            }
        }

        def create(self, validated_data):
            user = UserProfile.objects.create_user(
                email=validated_data['email'],
                name=validated_data['name'],
                password=validated_data['password'],
            )

            return user


class ProfileFeedItemSerializer(serializers.ModelSerializer):
    """Serialize feed item"""

    class Meta:
        model = ProfileFeedItem
        fields = ('id', 'user_profile', 'status_text', 'created_on')
        extra_kwagrs = {
            'user_profile': {
                'read_only': True
            }
        }
