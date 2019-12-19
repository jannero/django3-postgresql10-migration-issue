from django.db import models

# Create your models here.

class Key(models.Model):
    name = models.CharField(max_length=20, unique=True)


class AnotherKey(models.Model):
    name = models.CharField(max_length=20, unique=True)


class Value(models.Model):
    key = models.ForeignKey(
        Key,
        on_delete=models.PROTECT,
    )

    another_key = models.ForeignKey(
        AnotherKey,
        null=True,
        on_delete=models.PROTECT,
    )

    value = models.CharField(max_length=20)
