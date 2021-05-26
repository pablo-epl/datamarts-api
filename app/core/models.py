from django.db import models
from django.contrib.auth.models import AbstractBaseUser
from django.contrib.auth.models import BaseUserManager
from django.contrib.auth.models import PermissionsMixin


class UserManager(BaseUserManager):

    def create_user(self, email: str, password: str = None, **extra_fields):
        """Creates and saves a new user"""
        if not email:
            raise ValueError('Users must have an email address')
        user = self.model(email=self.normalize_email(email), **extra_fields)
        # we need to create the password through the encryption method
        user.set_password(password)
        # to support multiple dbs
        user.save(using=self._db)

        return user

    def create_superuser(self, email: str, password: str = None):
        """Creates and saves a new superuser"""
        user = self.create_user(email, password)
        user.is_curator = True
        user.is_superuser = True

        user.save(using=self._db)

        return user


class User(AbstractBaseUser, PermissionsMixin):
    """Custom user model that supports using email instead of username"""
    email = models.EmailField(max_length=255, unique=True)
    name = models.CharField(max_length=255)
    is_active = models.BooleanField(default=True)
    is_curator = models.BooleanField(default=False)

    objects = UserManager()

    USERNAME_FIELD = 'email'
